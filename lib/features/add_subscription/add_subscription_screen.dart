import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/currencies.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/services/notification_service.dart';
import 'package:subctrl/core/utils/billing_math.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/data/seed/bootstrap.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';
import 'package:uuid/uuid.dart';

class AddSubscriptionScreen extends ConsumerStatefulWidget {
  const AddSubscriptionScreen({super.key});
  @override
  ConsumerState<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends ConsumerState<AddSubscriptionScreen> {
  int step = 0;
  ServiceView? service;
  PlanView? plan;
  final price = TextEditingController();
  String currency = 'USD';
  String cycle = 'monthly';
  DateTime start = DateTime.now();
  DateTime? nextBilling;
  OfferKind offer = OfferKind.none;
  int freeDays = 14;
  double promoPrice = 0;
  int promoMonths = 3;
  ReminderOffset reminder = ReminderOffset.days3;
  String? methodId;
  String search = '';

  @override
  void dispose() {
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(servicesProvider).valueOrNull ?? [];
    final fx = ref.watch(currencyEngineProvider);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addSubscriptionTitle)),
      body: AppPage(
        child: ListView(
          children: [
            const SizedBox(height: 4),
            Text(l10n.stepOf(step + 1, 5), style: AppTypography.label(context.colors.textMuted)),
            const SizedBox(height: 8),
            ProgressPill(value: (step + 1) / 5, color: context.colors.accent, height: 6),
            const SizedBox(height: 20),
            if (step == 0) _stepService(services),
            if (step == 1) _stepPlan(),
            if (step == 2) _stepBilling(fx),
            if (step == 3) _stepOffer(),
            if (step == 4) _stepReminder(),
            const SizedBox(height: 24),
            Row(
              children: [
                if (step > 0) OutlinedButton(onPressed: () => setState(() => step--), child: Text(l10n.back)),
                const Spacer(),
                FilledButton(
                  onPressed: _next,
                  child: Text(step == 4 ? l10n.save : l10n.next),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _stepService(List<ServiceView> services) {
    final filtered = services.where((s) => s.name.toLowerCase().contains(search.toLowerCase())).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(context.l10n.selectService),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(hintText: context.l10n.search, prefixIcon: const Icon(Icons.search_rounded)),
          onChanged: (v) => setState(() => search = v),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () async {
            final created = await ref.read(catalogRepoProvider).createCustomService(name: search.isEmpty ? 'Custom' : search, categoryId: 'other');
            setState(() => service = created);
          },
          child: Text(context.l10n.customSubscription),
        ),
        const SizedBox(height: 8),
        for (final s in filtered.take(40))
          ListTile(
            selected: service?.id == s.id,
            selectedTileColor: context.colors.accent.withValues(alpha: 0.12),
            leading: ServiceAvatar(s.name, size: 38),
            trailing: service?.id == s.id ? Icon(Icons.check_circle_rounded, color: context.colors.accent) : null,
            title: Text(s.name),
            subtitle: Text(context.l10n.categorySlugLabel(s.categorySlug)),
            onTap: () => setState(() => service = s),
          ),
      ],
    );
  }

  Widget _stepPlan() {
    final plans = service?.plans ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(context.l10n.selectPlan),
        if (plans.isEmpty) Text(context.l10n.noSuggestedPlans),
        for (final p in plans)
          ListTile(
            selected: plan?.id == p.id,
            title: Text(p.name),
            subtitle: Text(
              [
                p.billingCycle,
                if (p.suggestedPrice != null) MoneyMath.format(p.suggestedPrice!, p.suggestedCurrency ?? 'USD'),
              ].join(' · '),
            ),
            onTap: () => setState(() {
              plan = p;
              if (p.suggestedPrice != null) price.text = p.suggestedPrice.toString();
              if (p.suggestedCurrency != null) currency = p.suggestedCurrency!;
              cycle = p.billingCycle;
            }),
          ),
      ],
    );
  }

  Widget _stepBilling(CurrencyEngine engine) {
    final parsed = double.tryParse(price.text) ?? 0;
    final q = engine.quote(parsed, currency);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(context.l10n.billing),
        TextField(controller: price, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: context.l10n.currentPrice)),
        const SizedBox(height: 8),
        DropdownButton<String>(
          value: AppCurrencies.iso.contains(currency) ? currency : 'USD',
          isExpanded: true,
          items: [for (final c in AppCurrencies.iso) DropdownMenuItem(value: c, child: Text(c))],
          onChanged: (v) => setState(() => currency = v ?? currency),
        ),
        DropdownButton<String>(
          value: cycle,
          isExpanded: true,
          items: [
            for (final c in BillingCycle.values)
              DropdownMenuItem(value: c.name, child: Text(context.l10n.billingCycleLabel(c))),
          ],
          onChanged: (v) => setState(() => cycle = v ?? cycle),
        ),
        ListTile(
          title: Text(context.l10n.startDate),
          trailing: Text(start.toIso8601String().substring(0, 10)),
          onTap: () async {
            final d = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100), initialDate: start);
            if (d != null) setState(() => start = d);
          },
        ),
        ListTile(
          title: Text(context.l10n.nextBillingDate),
          trailing: Text((nextBilling ?? BillingMath.addCycle(start, cycle: cycle)).toIso8601String().substring(0, 10)),
          onTap: () async {
            final d = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100), initialDate: nextBilling ?? start);
            if (d != null) setState(() => nextBilling = d);
          },
        ),
        const SizedBox(height: 8),
        Text('${MoneyMath.format(parsed, currency)}  FX ${q.exchangeRate.toStringAsFixed(2)}  ≈ ${MoneyMath.format(q.convertedAmount, q.baseCurrency)}'),
        if (q.foreignFee > 0) Text('${context.l10n.foreignFee} ≈ ${MoneyMath.format(q.foreignFee, q.baseCurrency)}'),
        Text('${context.l10n.estimatedCharge} ≈ ${MoneyMath.format(q.estimatedCharge, q.baseCurrency)}'),
        if (q.rateUpdatedAt != null) Text('${context.l10n.lastUpdated}: ${q.rateUpdatedAt}'),
        if (engine.lastError != null) Text('${engine.lastError}\n${context.l10n.usingLastKnownRate} ${q.exchangeRate.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget _stepOffer() {
    final l10n = context.l10n;
    return Column(
      children: [
        for (final o in OfferKind.values)
          ListTile(
            selected: offer == o,
            title: Text(l10n.offerKindLabel(o)),
            onTap: () => setState(() => offer = o),
          ),
        if (offer == OfferKind.freePeriod)
          DropdownButton<int>(
            value: freeDays,
            items: [
              for (final d in const [7, 14, 30, 60, 90])
                DropdownMenuItem(value: d, child: Text(l10n.freeDaysLabel(d))),
            ],
            onChanged: (v) => setState(() => freeDays = v ?? freeDays),
          ),
        if (offer == OfferKind.discount || offer == OfferKind.multiStage || offer == OfferKind.custom)
          TextField(
            decoration: InputDecoration(labelText: l10n.promoPrice),
            keyboardType: TextInputType.number,
            onChanged: (v) => promoPrice = double.tryParse(v) ?? 0,
          ),
      ],
    );
  }

  Widget _stepReminder() {
    final l10n = context.l10n;
    return Column(
      children: [
        SectionLabel(l10n.reminder),
        for (final o in ReminderOffset.values)
          ListTile(
            selected: reminder == o,
            title: Text(l10n.reminderOffsetLabel(o)),
            onTap: () => setState(() => reminder = o),
          ),
      ],
    );
  }

  Future<void> _next() async {
    if (step == 0 && service == null) return;
    if (step < 4) {
      setState(() => step++);
      return;
    }
    final parsed = double.tryParse(price.text) ?? plan?.suggestedPrice ?? 0;
    final next = nextBilling ?? BillingMath.addCycle(start, cycle: cycle);
    final phases = <PricePhasesCompanion>[];
    var status = SubscriptionStatus.active;
    if (offer == OfferKind.freePeriod) {
      status = SubscriptionStatus.trial;
      final trialEnd = start.add(Duration(days: freeDays));
      final deadline = trialEnd.subtract(const Duration(days: 1));
      final firstCharge = trialEnd.add(const Duration(days: 1));
      phases.add(PricePhasesCompanion.insert(
        id: const Uuid().v4(),
        subscriptionId: 'pending',
        type: PricePhaseType.free.name,
        startDate: start,
        endDate: Value(trialEnd),
        price: 0,
        currency: currency,
        billingCycle: cycle,
        regularPrice: Value(parsed),
        regularCurrency: Value(currency),
        cancelDeadline: Value(deadline),
        firstChargeDate: Value(firstCharge),
        trialEndDate: Value(trialEnd),
        reminderDate: Value(BillingMath.applySafetyBuffer(deadline, 2)),
      ));
      phases.add(PricePhasesCompanion.insert(
        id: const Uuid().v4(),
        subscriptionId: 'pending',
        type: PricePhaseType.regular.name,
        startDate: firstCharge,
        price: parsed,
        currency: currency,
        billingCycle: cycle,
      ));
    } else if (offer != OfferKind.none) {
      status = SubscriptionStatus.promo;
      final end = BillingMath.addMonthsClamped(start, promoMonths);
      phases.add(PricePhasesCompanion.insert(
        id: const Uuid().v4(),
        subscriptionId: 'pending',
        type: PricePhaseType.promo.name,
        startDate: start,
        endDate: Value(end),
        price: promoPrice == 0 ? parsed : promoPrice,
        currency: currency,
        billingCycle: cycle,
        regularPrice: Value(parsed),
        regularCurrency: Value(currency),
        promotionName: const Value('Promotional price'),
      ));
    } else {
      phases.add(PricePhasesCompanion.insert(
        id: const Uuid().v4(),
        subscriptionId: 'pending',
        type: PricePhaseType.regular.name,
        startDate: start,
        price: parsed,
        currency: currency,
        billingCycle: cycle,
      ));
    }
    final fire = (next).subtract(Duration(days: reminder.days ?? 3));
    final rid = const Uuid().v4();
    final id = await ref.read(subscriptionRepoProvider).create(
          serviceId: service!.id,
          planId: plan?.id,
          categoryId: service!.categoryId,
          profileId: ref.read(activeProfileIdProvider) ?? personalProfileId,
          status: status,
          startDate: start,
          nextBillingDate: offer == OfferKind.freePeriod ? start.add(Duration(days: freeDays + 1)) : next,
          autoRenew: true,
          currency: currency,
          currentPrice: offer == OfferKind.freePeriod ? 0 : (promoPrice == 0 ? parsed : promoPrice),
          billingCycle: cycle,
          officialWebsiteUrl: service!.officialWebsiteUrl,
          manageSubscriptionUrl: service!.manageSubscriptionUrl,
          phases: phases,
          reminders: [
            RemindersCompanion.insert(
              id: rid,
              subscriptionId: 'pending',
              kind: offer == OfferKind.freePeriod ? ReminderKind.trialEnd.name : ReminderKind.upcomingRenewal.name,
              offsetKind: reminder.name,
              fireAt: fire,
              notificationId: reminderNotificationId(rid),
            ),
          ],
        );
    await ref.read(notificationServiceProvider).resync(await ref.read(subscriptionRepoProvider).allReminders());
    if (mounted) context.go('/subs/$id');
  }
}
