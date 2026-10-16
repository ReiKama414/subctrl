import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/billing_math.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/charts/price_chart.dart';
import 'package:subctrl/shared/widgets/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({super.key, required this.id});
  final String id;
  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  ChartRange range = ChartRange.year1;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(subscriptionsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.detail)),
      body: async.when(
        loading: () => const Center(child: SkeletonBlock(height: 40, width: 120)),
        error: (e, _) => Text('$e'),
        data: (list) {
          SubscriptionView? sub;
          for (final s in list) {
            if (s.id == widget.id) {
              sub = s;
              break;
            }
          }
          if (sub == null) return AppPage(child: Text(context.l10n.subscriptionNotFound));
          return FutureBuilder(
            future: _extras(sub),
            builder: (context, snap) {
              if (!snap.hasData) {
                return const AppPage(child: Padding(padding: EdgeInsets.all(24), child: SkeletonBlock(height: 80)));
              }
              return _body(sub!, snap.data!);
            },
          );
        },
      ),
    );
  }

  Future<_Extras> _extras(SubscriptionView sub) async {
    final repo = ref.read(subscriptionRepoProvider);
    final fin = ref.read(financeRepoProvider);
    return _Extras(
      events: await repo.events(sub.id),
      history: await repo.priceHistory(sub.id),
      payments: await fin.payments(subscriptionId: sub.id),
    );
  }

  Widget _body(SubscriptionView sub, _Extras extras) {
    final fx = ref.watch(currencyEngineProvider);
    final phase = sub.currentPhase;
    final q = fx.quote(sub.currentPrice, sub.currency);
    final c = context.colors;
    final points = ChartEngine.series(history: extras.history, payments: extras.payments, range: range, now: DateTime.now());
    final accessLeft = sub.accessEndDate == null ? null : BillingMath.daysUntil(sub.accessEndDate!, DateTime.now());
    final l10n = context.l10n;
    final dates = <(IconData, String, DateTime?)>[
      (Icons.event_repeat_rounded, l10n.labelNextBilling, sub.nextBillingDate),
      (Icons.hourglass_bottom_rounded, l10n.labelTrialEnd, phase?.trialEndDate),
      (Icons.local_offer_rounded, l10n.labelPromoEnd, phase?.type == PricePhaseType.promo ? phase?.endDate : null),
      (Icons.event_busy_rounded, l10n.labelCancelDeadline, phase?.cancelDeadline),
      (Icons.notifications_active_rounded, l10n.labelMyReminder, phase?.reminderDate),
      (Icons.payments_rounded, l10n.labelFirstCharge, phase?.firstChargeDate),
      if (sub.status == SubscriptionStatus.cancelled) (Icons.lock_clock_rounded, l10n.labelAccessUntil, sub.accessEndDate),
    ].where((d) => d.$3 != null).toList();
    final links = <(IconData, String, String)>[
      if (sub.officialWebsiteUrl != null) (Icons.language_rounded, l10n.officialWebsite, sub.officialWebsiteUrl!),
      if (sub.manageSubscriptionUrl != null) (Icons.manage_accounts_rounded, l10n.manageSubscription, sub.manageSubscriptionUrl!),
    ];
    final profiles = ref.watch(profilesProvider).valueOrNull ?? [];

    return AppPage(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              ServiceAvatar(sub.serviceName, size: 64),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sub.serviceName, style: AppTypography.headline(c.textPrimary).copyWith(fontSize: 24)),
                    if (sub.planName != null && sub.planName!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(sub.planName!, style: AppTypography.body(c.textMuted)),
                    ],
                    const SizedBox(height: 8),
                    Wrap(spacing: 6, runSpacing: 6, children: [
                      StatusMark(l10n.subscriptionStatus(sub.status)),
                      if (phase != null) StatusMark(l10n.pricePhaseLabel(phase.type), tone: AppPalette.swatches[4]),
                      StatusMark(
                        sub.autoRenew ? l10n.autoRenew : l10n.manualRenew,
                        tone: c.textSecondary,
                        icon: sub.autoRenew ? Icons.autorenew_rounded : Icons.pan_tool_alt_rounded,
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionLabel(l10n.currentPrice),
                const SizedBox(height: 6),
                TerminalAmount(MoneyMath.format(sub.currentPrice, sub.currency), size: 34),
                if (sub.currency != q.baseCurrency) ...[
                  const SizedBox(height: 12),
                  _priceRow('≈ ${q.baseCurrency}', MoneyMath.format(q.convertedAmount, q.baseCurrency), 'FX ${q.exchangeRate.toStringAsFixed(2)}'),
                  if (q.foreignFee > 0) _priceRow(l10n.foreignFee, MoneyMath.format(q.foreignFee, q.baseCurrency)),
                  _priceRow(l10n.estimatedCharge, MoneyMath.format(q.estimatedCharge, q.baseCurrency)),
                ],
                if (sub.status == SubscriptionStatus.cancelled && accessLeft != null && accessLeft >= 0) ...[
                  const SizedBox(height: 10),
                  StatusMark(l10n.daysRemaining(accessLeft), tone: c.warning, icon: Icons.timelapse_rounded),
                ],
              ],
            ),
          ),
          if (dates.isNotEmpty) ...[
            const SizedBox(height: 12),
            SurfaceCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  for (final d in dates)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(d.$1, size: 18, color: c.textMuted),
                          const SizedBox(width: 12),
                          Expanded(child: Text(d.$2, style: AppTypography.body(c.textSecondary))),
                          Text(
                            d.$3!.toIso8601String().substring(0, 10),
                            style: AppTypography.amount(c.textPrimary, size: 14, weight: FontWeight.w600),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 64,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: _relative(d.$3!),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 28),
          SectionHeader(l10n.priceGraph),
          SurfaceCard(
            child: PriceLineChart(points: points, range: range, onRange: (r) => setState(() => range = r)),
          ),
          const SizedBox(height: 28),
          SectionHeader(l10n.renewalIntent),
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final intent in RenewalIntent.values)
                      ChoiceChip(
                        label: Text(l10n.renewalIntentLabel(intent)),
                        selected: sub.renewalIntent == intent,
                        onSelected: (_) => ref.read(subscriptionRepoProvider).setRenewalIntent(sub.id, intent),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                SectionLabel(l10n.usage),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final u in UsageFrequency.values)
                      ChoiceChip(
                        label: Text(l10n.usageFrequencyLabel(u)),
                        selected: sub.usageFrequency == u,
                        onSelected: (_) => ref.read(subscriptionRepoProvider).setUsage(
                              id: sub.id,
                              frequency: u,
                              usageCountPerMonth: sub.usageCountPerMonth,
                            ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.usesPerMonth),
                  subtitle: sub.usageCountPerMonth != null && sub.usageCountPerMonth! > 0
                      ? Text('Cost / use: ${MoneyMath.format(fx.monthlyBase(sub) / sub.usageCountPerMonth!, fx.baseCurrency)}')
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${sub.usageCountPerMonth ?? 0}', style: AppTypography.amount(c.textPrimary, size: 16)),
                      const SizedBox(width: 6),
                      Icon(Icons.edit_rounded, size: 16, color: c.textMuted),
                    ],
                  ),
                  onTap: () => _editUsageCount(sub),
                ),
                if (profiles.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  SectionLabel(l10n.profile),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final p in profiles)
                        ChoiceChip(
                          label: Text(l10n.profileDisplayName(p.type, p.name)),
                          selected: sub.profileId == p.id,
                          onSelected: (_) => ref.read(subscriptionRepoProvider).setProfile(sub.id, p.id),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 28),
          SectionHeader(
            l10n.paymentHistory,
            trailing: TextButton.icon(
              onPressed: () => _recordPayment(sub),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(l10n.recordPayment.replaceAll('+', '').trim()),
            ),
          ),
          SurfaceCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: extras.payments.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(l10n.noPaymentsYet, style: AppTypography.body(c.textMuted)),
                  )
                : Column(
                    children: [
                      for (final p in extras.payments)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              IconBadge(icon: Icons.receipt_rounded, color: c.accent, size: 36, iconSize: 18),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(p.date.toIso8601String().substring(0, 10), style: AppTypography.body(c.textPrimary).copyWith(fontWeight: FontWeight.w600)),
                                    Text(
                                      '${MoneyMath.format(p.originalAmount, p.originalCurrency)} · FX ${p.exchangeRate.toStringAsFixed(2)}'
                                      '${p.foreignFee > 0 ? ' · ${l10n.foreignFee} ${MoneyMath.format(p.foreignFee, p.baseCurrency)}' : ''}',
                                      style: AppTypography.caption(c.textMuted),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                MoneyMath.format(p.actualChargedAmount, p.baseCurrency),
                                style: AppTypography.amount(c.textPrimary, size: 14),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
          ),
          if (extras.events.isNotEmpty) ...[
            const SizedBox(height: 28),
            SectionHeader(l10n.eventHistory),
            SurfaceCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  for (var i = 0; i < extras.events.length; i++)
                    _TimelineRow(
                      icon: _glyph(extras.events[i].type),
                      title: l10n.subscriptionEventTitle(extras.events[i].type),
                      subtitle: [
                        extras.events[i].at.toIso8601String().substring(0, 10),
                        if (extras.events[i].detail != null && extras.events[i].detail!.isNotEmpty) extras.events[i].detail!,
                      ].join(' · '),
                      last: i == extras.events.length - 1,
                    ),
                ],
              ),
            ),
          ],
          if (links.isNotEmpty || (sub.notes != null && sub.notes!.isNotEmpty)) ...[
            const SizedBox(height: 28),
            SurfaceCard(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final l in links)
                    ListTile(
                      leading: Icon(l.$1),
                      title: Text(l.$2),
                      subtitle: Text(l.$3, maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                      onTap: () => launchUrl(Uri.parse(l.$3)),
                    ),
                  if (sub.notes != null && sub.notes!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(sub.notes!, style: AppTypography.body(c.textSecondary)),
                    ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          if (sub.status != SubscriptionStatus.cancelled && sub.status != SubscriptionStatus.expired)
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: c.danger,
                side: BorderSide(color: c.danger.withValues(alpha: 0.5)),
              ),
              onPressed: () async {
                final until = sub.nextBillingDate ?? DateTime.now().add(const Duration(days: 30));
                await ref.read(subscriptionRepoProvider).cancel(sub.id, until);
              },
              icon: const Icon(Icons.cancel_outlined, size: 20),
              label: Text(l10n.cancelKeepHistory),
            ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, [String? note]) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTypography.caption(c.textMuted))),
          if (note != null) ...[
            Text(note, style: AppTypography.caption(c.textMuted)),
            const SizedBox(width: 10),
          ],
          Text(value, style: AppTypography.amount(c.textSecondary, size: 14, weight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _relative(DateTime d) {
    final c = context.colors;
    final days = BillingMath.daysUntil(d, DateTime.now());
    if (days < 0) return const SizedBox.shrink();
    return StatusMark(context.l10n.dueIn(days), tone: days <= 3 ? c.warning : c.textSecondary);
  }

  Future<void> _editUsageCount(SubscriptionView sub) async {
    final l10n = context.l10n;
    final controller = TextEditingController(text: '${sub.usageCountPerMonth ?? ''}');
    final value = await showDialog<int?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.usesPerMonth),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'e.g. 4'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, int.tryParse(controller.text.trim())),
            child: Text(l10n.save),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value == null) return;
    await ref.read(subscriptionRepoProvider).setUsage(
          id: sub.id,
          frequency: sub.usageFrequency,
          usageCountPerMonth: value <= 0 ? null : value,
        );
  }

  Future<void> _recordPayment(SubscriptionView sub) async {
    final fx = ref.read(currencyEngineProvider);
    final amount = sub.currentPrice;
    final q = fx.quote(amount, sub.currency);
    await ref.read(financeRepoProvider).addPayment(
          PaymentView(
            id: '',
            subscriptionId: sub.id,
            date: DateTime.now(),
            originalAmount: amount,
            originalCurrency: sub.currency,
            exchangeRate: q.exchangeRate,
            convertedAmount: q.convertedAmount,
            baseCurrency: q.baseCurrency,
            foreignFee: q.foreignFee,
            actualChargedAmount: q.estimatedCharge,
            paymentMethodId: sub.paymentMethodId,
          ),
        );
    await ref.read(subscriptionRepoProvider).addEvent(
          sub.id,
          SubscriptionEventType.payment,
          SubscriptionEventType.payment.name,
          detail: '${MoneyMath.format(amount, sub.currency)} · ${MoneyMath.format(q.estimatedCharge, q.baseCurrency)}',
        );
    if (mounted) setState(() {});
  }

  IconData _glyph(SubscriptionEventType t) => switch (t) {
        SubscriptionEventType.payment => Icons.receipt_rounded,
        SubscriptionEventType.priceChanged => Icons.trending_up_rounded,
        SubscriptionEventType.planChanged => Icons.swap_horiz_rounded,
        SubscriptionEventType.promoStarted || SubscriptionEventType.trialStarted => Icons.local_offer_rounded,
        SubscriptionEventType.cancelled || SubscriptionEventType.cancelRequested => Icons.cancel_rounded,
        SubscriptionEventType.created => Icons.add_circle_rounded,
        _ => Icons.circle_outlined,
      };
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.icon, required this.title, required this.subtitle, required this.last});
  final IconData icon;
  final String title;
  final String subtitle;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                const SizedBox(height: 8),
                IconBadge(icon: icon, color: c.accent, size: 28, iconSize: 14),
                if (!last)
                  Expanded(child: Container(width: 2, margin: const EdgeInsets.only(top: 4), color: c.border)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.body(c.textPrimary).copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTypography.caption(c.textMuted)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Extras {
  _Extras({required this.events, required this.history, required this.payments});
  final List<EventView> events;
  final List<PriceHistoryView> history;
  final List<PaymentView> payments;
}
