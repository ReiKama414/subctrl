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
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        AppPage(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sub.serviceName.toUpperCase(), style: AppTypography.title(c.textPrimary)),
              const SizedBox(height: 8),
              Wrap(spacing: 8, children: [
                StatusMark(sub.status.label),
                if (phase != null) StatusMark(phase.type.label),
                StatusMark(sub.autoRenew ? 'AUTO RENEW' : 'MANUAL'),
              ]),
              const SizedBox(height: 16),
              SurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionLabel(context.l10n.currentPrice),
                    TerminalAmount(MoneyMath.format(sub.currentPrice, sub.currency)),
                    Text('≈ ${MoneyMath.format(q.convertedAmount, q.baseCurrency)}  FX ${q.exchangeRate.toStringAsFixed(2)}'),
                    if (q.foreignFee > 0) Text('${context.l10n.foreignFee} ≈ ${MoneyMath.format(q.foreignFee, q.baseCurrency)}'),
                    Text('${context.l10n.estimatedCharge} ≈ ${MoneyMath.format(q.estimatedCharge, q.baseCurrency)}'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _kv('NEXT BILLING', sub.nextBillingDate),
              _kv('TRIAL END', phase?.trialEndDate),
              _kv('PROMO END', phase?.type == PricePhaseType.promo ? phase?.endDate : null),
              _kv('CANCEL DEADLINE', phase?.cancelDeadline),
              _kv('MY REMINDER', phase?.reminderDate),
              _kv('FIRST CHARGE', phase?.firstChargeDate),
              if (sub.status == SubscriptionStatus.cancelled) ...[
                _kv('ACCESS UNTIL', sub.accessEndDate),
                if (accessLeft != null && accessLeft >= 0) Text('$accessLeft DAYS REMAINING', style: AppTypography.label(c.warning)),
              ],
              const SizedBox(height: 8),
              SectionLabel(context.l10n.profile),
              Builder(builder: (_) {
                final profiles = ref.watch(profilesProvider).valueOrNull ?? [];
                return Wrap(
                  spacing: 6,
                  children: [
                    for (final p in profiles)
                      ChoiceChip(
                        label: Text(context.l10n.profileDisplayName(p.type, p.name)),
                        selected: sub.profileId == p.id,
                        onSelected: (_) => ref.read(subscriptionRepoProvider).setProfile(sub.id, p.id),
                      ),
                  ],
                );
              }),
              const SizedBox(height: 8),
              SectionLabel(context.l10n.renewalIntent),
              Wrap(
                spacing: 6,
                children: [
                  for (final intent in RenewalIntent.values)
                    ChoiceChip(
                      label: Text(intent.label),
                      selected: sub.renewalIntent == intent,
                      onSelected: (_) => ref.read(subscriptionRepoProvider).setRenewalIntent(sub.id, intent),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              SectionLabel(context.l10n.usage),
              Wrap(
                spacing: 6,
                children: [
                  for (final u in UsageFrequency.values)
                    ChoiceChip(
                      label: Text(u.label),
                      selected: sub.usageFrequency == u,
                      onSelected: (_) => ref.read(subscriptionRepoProvider).setUsage(
                            id: sub.id,
                            frequency: u,
                            usageCountPerMonth: sub.usageCountPerMonth,
                          ),
                    ),
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(context.l10n.usesPerMonth),
                subtitle: Text('${sub.usageCountPerMonth ?? 0}'),
                trailing: const Icon(Icons.edit, size: 16),
                onTap: () => _editUsageCount(sub),
              ),
              if (sub.usageCountPerMonth != null && sub.usageCountPerMonth! > 0)
                Text(
                  'Cost / use: ${MoneyMath.format(fx.monthlyBase(sub) / sub.usageCountPerMonth!, fx.baseCurrency)}',
                  style: AppTypography.mono.copyWith(color: c.textSecondary),
                ),
              const SizedBox(height: 16),
              SectionLabel(context.l10n.priceGraph),
              PriceLineChart(points: points, range: range, onRange: (r) => setState(() => range = r)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: SectionLabel(context.l10n.paymentHistory)),
                  TextButton(onPressed: () => _recordPayment(sub), child: Text(context.l10n.recordPayment)),
                ],
              ),
              if (extras.payments.isEmpty)
                Text(context.l10n.noPaymentsYet, style: AppTypography.body(c.textMuted)),
              for (final p in extras.payments)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${p.date.toIso8601String().substring(0, 10)}  PAYMENT'),
                  subtitle: Text(
                    '${MoneyMath.format(p.originalAmount, p.originalCurrency)} · FX ${p.exchangeRate.toStringAsFixed(2)}\n'
                    'Base ${MoneyMath.format(p.convertedAmount, p.baseCurrency)}  '
                    'Fee ${MoneyMath.format(p.foreignFee, p.baseCurrency)}  '
                    'Actual ${MoneyMath.format(p.actualChargedAmount, p.baseCurrency)}',
                  ),
                ),
              SectionLabel(context.l10n.eventHistory),
              for (final e in extras.events)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(_glyph(e.type), style: TextStyle(color: c.accent)),
                  title: Text(e.title),
                  subtitle: Text('${e.at.toIso8601String().substring(0, 10)}  ${e.detail ?? ''}'),
                ),
              if (sub.officialWebsiteUrl != null)
                ListTile(
                  title: Text(context.l10n.officialWebsite),
                  subtitle: Text(sub.officialWebsiteUrl!),
                  onTap: () => launchUrl(Uri.parse(sub.officialWebsiteUrl!)),
                ),
              if (sub.manageSubscriptionUrl != null)
                ListTile(
                  title: Text(context.l10n.manageSubscription),
                  subtitle: Text(sub.manageSubscriptionUrl!),
                  onTap: () => launchUrl(Uri.parse(sub.manageSubscriptionUrl!)),
                ),
              if (sub.notes != null) Text(sub.notes!),
              const SizedBox(height: 12),
              if (sub.status != SubscriptionStatus.cancelled && sub.status != SubscriptionStatus.expired)
                OutlinedButton(
                  onPressed: () async {
                    final until = sub.nextBillingDate ?? DateTime.now().add(const Duration(days: 30));
                    await ref.read(subscriptionRepoProvider).cancel(sub.id, until);
                  },
                  child: Text(context.l10n.cancelKeepHistory),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _kv(String k, DateTime? v) {
    if (v == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: SectionLabel(k)),
          Text(v.toIso8601String().substring(0, 10), style: AppTypography.mono.copyWith(color: context.colors.textPrimary)),
        ],
      ),
    );
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
          'PAYMENT',
          detail: '${MoneyMath.format(amount, sub.currency)} · ${MoneyMath.format(q.estimatedCharge, q.baseCurrency)}',
        );
    if (mounted) setState(() {});
  }

  String _glyph(SubscriptionEventType t) => switch (t) {
        SubscriptionEventType.payment => '●',
        SubscriptionEventType.priceChanged => '▲',
        SubscriptionEventType.planChanged => '◆',
        SubscriptionEventType.promoStarted || SubscriptionEventType.trialStarted => '◇',
        _ => '○',
      };
}

class _Extras {
  _Extras({required this.events, required this.history, required this.payments});
  final List<EventView> events;
  final List<PriceHistoryView> history;
  final List<PaymentView> payments;
}
