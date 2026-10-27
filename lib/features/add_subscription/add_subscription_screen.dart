import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/currencies.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/services/notification_service.dart';
import 'package:subctrl/core/utils/notification_prompt.dart';
import 'package:subctrl/core/utils/sync_coordinator.dart';
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
  final planName = TextEditingController();
  String profileId = personalProfileId;
  String currency = 'USD';
  String cycle = 'monthly';
  DateTime start = DateTime.now();
  DateTime? nextBilling;
  OfferKind offer = OfferKind.none;
  /// Preset days, or -1 for a custom end date.
  int freeDays = 14;
  DateTime? customFreeUntil;
  double promoPrice = 0;
  int promoMonths = 3;
  ReminderOffset reminder = ReminderOffset.days3;
  String? methodId;
  String search = '';
  /// null = all categories
  String? categoryFilter;
  bool _purged = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _purgeUnusedCustoms();
      final active = ref.read(activeProfileIdProvider);
      if (active != null) profileId = active;
    });
  }

  Future<void> _purgeUnusedCustoms() async {
    if (_purged) return;
    _purged = true;
    final n = await ref.read(catalogRepoProvider).purgeUnusedCustomServices();
    if (n > 0) {
      ref.invalidate(servicesProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.purgeCustomDone(n))),
        );
      }
    }
  }

  @override
  void dispose() {
    price.dispose();
    planName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(servicesProvider).valueOrNull ?? [];
    final fx = ref.watch(currencyEngineProvider);
    final l10n = context.l10n;
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addSubscriptionTitle)),
      body: AppPage(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 12),
          children: [
            const SizedBox(height: 4),
            Text(l10n.stepOf(step + 1, 5), style: AppTypography.label(c.textMuted)),
            const SizedBox(height: 8),
            ProgressPill(value: (step + 1) / 5, color: c.accent, height: 6),
            const SizedBox(height: 20),
            if (step == 0) _stepService(services),
            if (step == 1) _stepPlan(),
            if (step == 2) _stepBilling(fx),
            if (step == 3) _stepOffer(),
            if (step == 4) _stepReminder(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Material(
          color: c.surface,
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              children: [
                if (step > 0) OutlinedButton(onPressed: () => setState(() => step--), child: Text(l10n.back)),
                const Spacer(),
                FilledButton(
                  onPressed: _next,
                  child: Text(step == 4 ? l10n.save : l10n.next),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stepService(List<ServiceView> services) {
    final q = search.trim().toLowerCase();
    final cat = categoryFilter;
    final filtered = services.where((s) {
      if (cat != null && s.categorySlug != cat && s.categoryId != cat) return false;
      if (q.isNotEmpty && !s.name.toLowerCase().contains(q)) return false;
      return true;
    }).toList()
      ..sort((a, b) {
        // Built-ins first, then customs; alphabetical within each group.
        final ac = a.isCustom ? 1 : 0;
        final bc = b.isCustom ? 1 : 0;
        if (ac != bc) return ac - bc;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    final selected = service;
    final l10n = context.l10n;
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(l10n.selectService),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(hintText: l10n.search, prefixIcon: const Icon(Icons.search_rounded)),
          onChanged: (v) => setState(() => search = v),
        ),
        const SizedBox(height: 12),
        SectionLabel(l10n.categoryTitle),
        const SizedBox(height: 8),
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            primary: false,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _CategoryPill(
                  label: l10n.allCats,
                  selected: cat == null,
                  color: c.accent,
                  onTap: () => setState(() => categoryFilter = null),
                ),
              ),
              for (final slug in CategorySlug.values)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _CategoryPill(
                    label: l10n.categoryLabel(slug),
                    icon: AppPalette.categoryIcon(slug.name),
                    selected: cat == slug.name,
                    color: AppPalette.category(slug.name),
                    onTap: () => setState(() => categoryFilter = slug.name),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: _createCustomService,
          child: Text(l10n.customSubscription),
        ),
        if (selected != null) ...[
          const SizedBox(height: 12),
          SurfaceCard(
            color: context.colors.accent.withValues(alpha: 0.12),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                ServiceAvatar(
                  selected.name,
                  size: 42,
                  logoKey: selected.logoKey ?? selected.id,
                  website: selected.officialWebsiteUrl,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selected.name, style: AppTypography.label(context.colors.textPrimary)),
                      Text(
                        l10n.categorySlugLabel(selected.categorySlug),
                        style: AppTypography.caption(context.colors.textMuted),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle_rounded, color: context.colors.accent),
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
        Text(
          '${filtered.length} / ${services.length}',
          style: AppTypography.caption(context.colors.textMuted),
        ),
        const SizedBox(height: 4),
        for (final s in filtered)
          ListTile(
            selected: selected?.id == s.id,
            selectedTileColor: context.colors.accent.withValues(alpha: 0.12),
            leading: ServiceAvatar(
              s.name,
              size: 38,
              logoKey: s.logoKey ?? s.id,
              website: s.officialWebsiteUrl,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (s.isCustom)
                  IconButton(
                    tooltip: l10n.deleteCustomService,
                    icon: Icon(Icons.delete_outline_rounded, color: context.colors.textMuted),
                    onPressed: () => _deleteCustom(s),
                  ),
                if (selected?.id == s.id) Icon(Icons.check_circle_rounded, color: context.colors.accent),
              ],
            ),
            title: Text(s.name),
            subtitle: Text(l10n.categorySlugLabel(s.categorySlug)),
            onTap: () => _selectService(s),
          ),
      ],
    );
  }

  String _amortizeHint(AppLocalizations l10n, String cycle) {
    final months = BillingCycle.values.where((e) => e.name == cycle).firstOrNull?.monthsEquivalent ?? 0;
    if (months <= 1) return '';
    return '  (${l10n.billingCycleLabel(
          BillingCycle.values.firstWhere((e) => e.name == cycle),
        )} ÷ $months)';
  }

  void _selectService(ServiceView s) {
    setState(() {
      service = s;
      plan = null;
      // Catalogue price is only a suggestion — clear so user confirms on next step.
      if (s.plans.isNotEmpty) {
        final p = s.plans.first;
        plan = p;
        planName.text = p.name;
        cycle = p.billingCycle;
        if (p.suggestedPrice != null) price.text = p.suggestedPrice.toString();
        if (p.suggestedCurrency != null) currency = p.suggestedCurrency!;
      } else {
        price.clear();
        cycle = 'monthly';
      }
      step = 1;
    });
  }

  Future<void> _deleteCustom(ServiceView s) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteCustomService),
        content: Text(l10n.deleteCustomServiceBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.back)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.deleteCustomService)),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      await ref.read(catalogRepoProvider).deleteCustomService(s.id);
      if (service?.id == s.id) {
        setState(() {
          service = null;
          plan = null;
        });
      }
      ref.invalidate(servicesProvider);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.customServiceInUse)));
    }
  }

  Future<void> _createCustomService() async {
    final l10n = context.l10n;
    final nameCtrl = TextEditingController(text: search);
    final siteCtrl = TextEditingController();
    var categoryId = categoryFilter ?? CategorySlug.other.name;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialog) => AlertDialog(
          title: Text(l10n.customSubscription),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  autofocus: true,
                  decoration: InputDecoration(labelText: l10n.selectService),
                  onSubmitted: (_) => Navigator.pop(ctx, true),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: siteCtrl,
                  decoration: InputDecoration(labelText: l10n.officialWebsite, hintText: 'https://'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: categoryId,
                  decoration: InputDecoration(labelText: l10n.categoryTitle),
                  items: [
                    for (final slug in CategorySlug.values)
                      DropdownMenuItem(
                        value: slug.name,
                        child: Text(l10n.categoryLabel(slug)),
                      ),
                  ],
                  onChanged: (v) {
                    if (v != null) setDialog(() => categoryId = v);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.back)),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.next)),
          ],
        ),
      ),
    );
    final name = nameCtrl.text;
    final site = siteCtrl.text;
    nameCtrl.dispose();
    siteCtrl.dispose();
    if (ok != true || !mounted) return;
    if (name.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.customNameRequired)));
      return;
    }

    try {
      final created = await ref.read(catalogRepoProvider).createCustomService(
            name: name,
            categoryId: categoryId,
            site: site.trim().isEmpty ? null : site.trim(),
          );
      ref.invalidate(servicesProvider);
      if (!mounted) return;
      setState(() {
        service = created;
        plan = created.plans.isEmpty ? null : created.plans.first;
        if (plan != null) {
          cycle = plan!.billingCycle;
          if (plan!.suggestedPrice != null) price.text = plan!.suggestedPrice.toString();
          if (plan!.suggestedCurrency != null) currency = plan!.suggestedCurrency!;
        }
        step = 1;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Widget _stepPlan() {
    final plans = service?.plans ?? [];
    final profiles = ref.watch(profilesProvider).valueOrNull ?? [];
    final l10n = context.l10n;
    final c = context.colors;
    final parsed = double.tryParse(price.text) ?? 0;
    final monthly = BillingMath.monthlyEquivalent(parsed, cycle);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (profiles.isNotEmpty) ...[
          SectionLabel(l10n.selectProfileForSub),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in profiles)
                _CategoryPill(
                  label: l10n.profileDisplayName(p.type, p.name),
                  selected: profileId == p.id,
                  color: c.accent,
                  onTap: () => setState(() => profileId = p.id),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        SectionLabel(l10n.selectPlan),
        if (plans.isEmpty)
          Text(l10n.noSuggestedPlans, style: AppTypography.body(c.textMuted))
        else ...[
          Text(l10n.planPriceHint, style: AppTypography.caption(c.textMuted)),
          const SizedBox(height: 8),
          for (final p in plans)
            ListTile(
              selected: plan?.id == p.id,
              title: Text(p.name),
              subtitle: Text(
                [
                  l10n.billingCycleLabel(
                    BillingCycle.values.where((e) => e.name == p.billingCycle).firstOrNull ?? BillingCycle.monthly,
                  ),
                  if (p.suggestedPrice != null) MoneyMath.format(p.suggestedPrice!, p.suggestedCurrency ?? 'USD'),
                ].join(' · '),
              ),
              onTap: () => setState(() {
                plan = p;
                planName.text = p.name;
                if (p.suggestedPrice != null) price.text = p.suggestedPrice.toString();
                if (p.suggestedCurrency != null) currency = p.suggestedCurrency!;
                cycle = p.billingCycle;
              }),
            ),
        ],
        const SizedBox(height: 12),
        TextField(
          controller: planName,
          decoration: InputDecoration(labelText: l10n.planName, hintText: l10n.planPriceHint),
        ),
        const SizedBox(height: 16),
        SectionLabel(l10n.regularPriceAfterOffer),
        const SizedBox(height: 8),
        TextField(
          controller: price,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: l10n.currentPrice, hintText: l10n.planPriceHint),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          key: ValueKey('plan-currency-$currency'),
          initialValue: AppCurrencies.iso.contains(currency) ? currency : 'USD',
          decoration: InputDecoration(labelText: l10n.currency),
          items: [for (final code in AppCurrencies.iso) DropdownMenuItem(value: code, child: Text(code))],
          onChanged: (v) => setState(() => currency = v ?? currency),
        ),
        const SizedBox(height: 16),
        SectionLabel(l10n.billing),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final bc in BillingCycle.values)
              _CategoryPill(
                label: l10n.billingCycleLabel(bc),
                selected: cycle == bc.name,
                color: c.accent,
                onTap: () => setState(() => cycle = bc.name),
              ),
          ],
        ),
        if (parsed > 0) ...[
          const SizedBox(height: 12),
          Text(
            '${l10n.monthlyLoad}: ${MoneyMath.format(monthly, currency)}'
            '${_amortizeHint(l10n, cycle)}',
            style: AppTypography.caption(c.textSecondary),
          ),
        ],
      ],
    );
  }

  Widget _stepBilling(CurrencyEngine engine) {
    final parsed = double.tryParse(price.text) ?? 0;
    final q = engine.quote(parsed, currency);
    final monthly = BillingMath.monthlyEquivalent(q.estimatedCharge, cycle);
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(l10n.billing),
        TextField(
          controller: price,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: l10n.currentPrice),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          key: ValueKey('bill-currency-$currency'),
          initialValue: AppCurrencies.iso.contains(currency) ? currency : 'USD',
          decoration: InputDecoration(labelText: l10n.currency),
          items: [for (final code in AppCurrencies.iso) DropdownMenuItem(value: code, child: Text(code))],
          onChanged: (v) => setState(() => currency = v ?? currency),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final bc in BillingCycle.values)
              _CategoryPill(
                label: l10n.billingCycleLabel(bc),
                selected: cycle == bc.name,
                color: context.colors.accent,
                onTap: () => setState(() => cycle = bc.name),
              ),
          ],
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.startDate),
          trailing: Text(start.toIso8601String().substring(0, 10)),
          onTap: () async {
            final d = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100), initialDate: start);
            if (d != null) setState(() => start = d);
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.nextBillingDate),
          trailing: Text((nextBilling ?? BillingMath.addCycle(start, cycle: cycle)).toIso8601String().substring(0, 10)),
          onTap: () async {
            final d = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100), initialDate: nextBilling ?? start);
            if (d != null) setState(() => nextBilling = d);
          },
        ),
        const SizedBox(height: 8),
        Text('${MoneyMath.format(parsed, currency)}  FX ${q.exchangeRate.toStringAsFixed(2)}  ≈ ${MoneyMath.format(q.convertedAmount, q.baseCurrency)}'),
        if (q.foreignFee > 0) Text('${l10n.foreignFee} ≈ ${MoneyMath.format(q.foreignFee, q.baseCurrency)}'),
        Text('${l10n.estimatedCharge} ≈ ${MoneyMath.format(q.estimatedCharge, q.baseCurrency)}'),
        Text('${l10n.monthlyLoad} ≈ ${MoneyMath.format(monthly, q.baseCurrency)}'),
        if (q.rateUpdatedAt != null) Text('${l10n.lastUpdated}: ${q.rateUpdatedAt}'),
        if (engine.lastError != null) Text('${engine.lastError}\n${l10n.usingLastKnownRate} ${q.exchangeRate.toStringAsFixed(2)}'),
      ],
    );
  }

  DateTime _freePeriodEnd() {
    if (freeDays < 0) {
      return BillingMath.dateOnly(
        customFreeUntil ?? BillingMath.addMonthsClamped(start, 12),
      );
    }
    return BillingMath.addFreePeriod(start, freeDays);
  }

  Widget _stepOffer() {
    final l10n = context.l10n;
    final c = context.colors;
    final parsed = double.tryParse(price.text) ?? plan?.suggestedPrice ?? 0;
    final cycleEnum =
        BillingCycle.values.where((e) => e.name == cycle).firstOrNull ?? BillingCycle.monthly;
    final trialEnd = _freePeriodEnd();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final o in OfferKind.values)
          ListTile(
            selected: offer == o,
            title: Text(l10n.offerKindLabel(o)),
            onTap: () => setState(() => offer = o),
          ),
        if (offer == OfferKind.freePeriod) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final d in const [7, 14, 30, 60, 90, 180, 365, -1])
                _CategoryPill(
                  label: l10n.freeDaysLabel(d),
                  selected: freeDays == d,
                  color: c.accent,
                  onTap: () async {
                    if (d < 0) {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: start,
                        lastDate: DateTime(start.year + 10, start.month, start.day),
                        initialDate: customFreeUntil ?? BillingMath.addMonthsClamped(start, 12),
                      );
                      if (picked == null) return;
                      setState(() {
                        freeDays = -1;
                        customFreeUntil = picked;
                      });
                      return;
                    }
                    setState(() {
                      freeDays = d;
                      customFreeUntil = null;
                    });
                  },
                ),
            ],
          ),
          if (freeDays < 0)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.freeDaysLabel(-1)),
              trailing: Text(trialEnd.toIso8601String().substring(0, 10)),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: start,
                  lastDate: DateTime(start.year + 10, start.month, start.day),
                  initialDate: trialEnd,
                );
                if (picked != null) setState(() => customFreeUntil = picked);
              },
            ),
          const SizedBox(height: 12),
          Text(
            l10n.offerAfterFree(
              trialEnd.toIso8601String().substring(0, 10),
              MoneyMath.format(parsed, currency),
              l10n.billingCycleLabel(cycleEnum),
            ),
            style: AppTypography.body(c.textSecondary),
          ),
          const SizedBox(height: 6),
          Text(l10n.offerFreeKeepsRegular, style: AppTypography.caption(c.textMuted)),
        ],
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
    if (step == 0 && service == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.selectService)));
      return;
    }
    if (step == 1) {
      final parsed = double.tryParse(price.text.trim());
      if (parsed == null || parsed <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.regularPriceRequired)));
        return;
      }
    }
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
      final trialEnd = _freePeriodEnd();
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
        promotionName: const Value('Free period'),
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
        price: promoPrice,
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
    final trialEnd = offer == OfferKind.freePeriod ? _freePeriodEnd() : null;
    final firstCharge = trialEnd?.add(const Duration(days: 1));
    final fire = (trialEnd ?? next).subtract(Duration(days: reminder.days ?? 3));
    final rid = const Uuid().v4();
    final resolvedPlanId = await ref.read(catalogRepoProvider).resolvePlanId(
          serviceId: service!.id,
          selectedPlanId: plan?.id,
          planName: planName.text.trim().isEmpty ? (plan?.name ?? service!.name) : planName.text.trim(),
          billingCycle: cycle,
          suggestedPrice: parsed,
          suggestedCurrency: currency,
        );
    final listPrice = switch (offer) {
      OfferKind.discount || OfferKind.multiStage || OfferKind.custom => promoPrice,
      _ => parsed,
    };
    final id = await ref.read(subscriptionRepoProvider).create(
          serviceId: service!.id,
          planId: resolvedPlanId,
          categoryId: service!.categoryId,
          profileId: profileId,
          status: status,
          startDate: start,
          nextBillingDate: firstCharge ?? next,
          autoRenew: true,
          currency: currency,
          currentPrice: listPrice,
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
    if (mounted) await ensureNotificationPermission(context, ref);
    await resyncAllNotifications(ref);
    await maybeCloudUpload(ref, context.l10n);
    if (!mounted) return;
    // Land on home first so detail has a back target (go() alone clears the stack).
    context.go('/home');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.push('/subs/$id');
    });
  }
}

/// Custom pill — Material [ChoiceChip] can squash CJK labels on first layout.
class _CategoryPill extends StatelessWidget {
  const _CategoryPill({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final bg = selected ? color : Color.lerp(c.surfaceHigh, c.textPrimary, 0.08)!;
    final fg = selected ? c.onAccent : c.textPrimary;
    final border = selected ? color : c.border;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: border, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 15, color: selected ? fg : color),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: AppTypography.sans.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: fg,
                  letterSpacing: 0,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
