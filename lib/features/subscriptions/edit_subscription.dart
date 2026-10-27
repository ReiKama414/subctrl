import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/services/notification_service.dart';
import 'package:subctrl/core/utils/sync_coordinator.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';
import 'package:uuid/uuid.dart';

Future<bool> showDeleteSubscriptionDialog({
  required BuildContext context,
  required WidgetRef ref,
  required SubscriptionView sub,
}) async {
  final l10n = context.l10n;
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.deleteSubscription),
      content: Text(l10n.deleteSubscriptionBody(sub.serviceName)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: context.colors.danger),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(l10n.deleteSubscription),
        ),
      ],
    ),
  );
  if (ok != true) return false;
  final enabled = ref.read(preferencesProvider).valueOrNull?.notificationsEnabled ?? true;
  await ref.read(subscriptionRepoProvider).deleteSubscription(sub.id);
  await ref.read(notificationServiceProvider).resync(
        await ref.read(subscriptionRepoProvider).allReminders(),
        enabled: enabled,
      );
  await maybeCloudUpload(ref, l10n);
  return true;
}

class _EditSubResult {
  _EditSubResult({
    required this.planName,
    required this.notes,
    required this.start,
    required this.nextBill,
    required this.autoRenew,
    required this.status,
    required this.profileId,
  });

  final String planName;
  final String notes;
  final DateTime start;
  final DateTime? nextBill;
  final bool autoRenew;
  final SubscriptionStatus status;
  final String profileId;
}

Future<void> showEditSubscriptionSheet({
  required BuildContext context,
  required WidgetRef ref,
  required SubscriptionView sub,
  VoidCallback? onChanged,
}) async {
  final l10n = context.l10n;
  final profiles = ref.read(profilesProvider).valueOrNull ?? [];
  final result = await showModalBottomSheet<_EditSubResult>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => _EditSubscriptionSheetBody(sub: sub, profiles: profiles, l10n: l10n),
  );
  if (result == null) return;

  final repo = ref.read(subscriptionRepoProvider);
  final catalog = ref.read(catalogRepoProvider);
  var planId = sub.planId;
  if (result.planName.isNotEmpty) {
    planId = await catalog.resolvePlanId(
      serviceId: sub.serviceId,
      selectedPlanId: sub.planId,
      planName: result.planName,
      billingCycle: sub.billingCycle,
      suggestedPrice: sub.currentPrice,
      suggestedCurrency: sub.currency,
    );
  }

  await repo.updateMeta(
    id: sub.id,
    planId: planId,
    startDate: result.start,
    nextBillingDate: result.nextBill,
    autoRenew: result.autoRenew,
    notes: result.notes.isEmpty ? null : result.notes,
    status: result.status,
  );
  if (result.profileId != sub.profileId) {
    await repo.setProfile(sub.id, result.profileId);
  }
  await maybeCloudUpload(ref, l10n);
  onChanged?.call();
}

class _EditSubscriptionSheetBody extends StatefulWidget {
  const _EditSubscriptionSheetBody({
    required this.sub,
    required this.profiles,
    required this.l10n,
  });

  final SubscriptionView sub;
  final List<UserProfile> profiles;
  final AppLocalizations l10n;

  @override
  State<_EditSubscriptionSheetBody> createState() => _EditSubscriptionSheetBodyState();
}

class _EditSubscriptionSheetBodyState extends State<_EditSubscriptionSheetBody> {
  late final TextEditingController planNameCtrl;
  late final TextEditingController notesCtrl;
  late DateTime start;
  late DateTime? nextBill;
  late bool autoRenew;
  late SubscriptionStatus status;
  late String profileId;

  @override
  void initState() {
    super.initState();
    planNameCtrl = TextEditingController(text: widget.sub.planName ?? '');
    notesCtrl = TextEditingController(text: widget.sub.notes ?? '');
    start = widget.sub.startDate;
    nextBill = widget.sub.nextBillingDate;
    autoRenew = widget.sub.autoRenew;
    status = widget.sub.status;
    profileId = widget.sub.profileId;
  }

  @override
  void dispose() {
    planNameCtrl.dispose();
    notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.editSubscription, style: AppTypography.title(context.colors.textPrimary).copyWith(fontSize: 20)),
              const SizedBox(height: 16),
              TextField(controller: planNameCtrl, decoration: InputDecoration(labelText: l10n.planName)),
              const SizedBox(height: 12),
              TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: InputDecoration(labelText: l10n.notes),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.startDate),
                trailing: Text(start.toIso8601String().substring(0, 10)),
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: start,
                  );
                  if (d != null) setState(() => start = d);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.nextBillingDate),
                trailing: Text(nextBill?.toIso8601String().substring(0, 10) ?? '—'),
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: nextBill ?? start,
                  );
                  if (d != null) setState(() => nextBill = d);
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.autoRenew),
                value: autoRenew,
                onChanged: (v) => setState(() => autoRenew = v),
              ),
              const SizedBox(height: 8),
              SectionLabel(l10n.statusTitle),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final s in SubscriptionStatus.values)
                    ChoiceChip(
                      label: Text(l10n.subscriptionStatus(s)),
                      selected: status == s,
                      onSelected: (_) => setState(() => status = s),
                    ),
                ],
              ),
              if (widget.profiles.isNotEmpty) ...[
                const SizedBox(height: 16),
                SectionLabel(l10n.profile),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final p in widget.profiles)
                      ChoiceChip(
                        label: Text(l10n.profileDisplayName(p.type, p.name)),
                        selected: profileId == p.id,
                        onSelected: (_) => setState(() => profileId = p.id),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(
                    context,
                    _EditSubResult(
                      planName: planNameCtrl.text.trim(),
                      notes: notesCtrl.text.trim(),
                      start: start,
                      nextBill: nextBill,
                      autoRenew: autoRenew,
                      status: status,
                      profileId: profileId,
                    ),
                  ),
                  child: Text(l10n.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showManagePhasesSheet({
  required BuildContext context,
  required WidgetRef ref,
  required SubscriptionView sub,
  VoidCallback? onChanged,
}) async {
  final l10n = context.l10n;
  final phases = [...sub.phases];

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setLocal) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.72,
            minChildSize: 0.4,
            maxChildSize: 0.92,
            builder: (_, scrollCtrl) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.pricePhases,
                            style: AppTypography.title(context.colors.textPrimary).copyWith(fontSize: 20),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final added = await _editPhaseDialog(ctx, l10n, null, sub);
                            if (added != null) setLocal(() => phases.add(added));
                          },
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: Text(l10n.addPhase),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollCtrl,
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                      children: [
                        for (var i = 0; i < phases.length; i++)
                          ListTile(
                            title: Text(l10n.pricePhaseLabel(phases[i].type)),
                            subtitle: Text(
                              '${phases[i].startDate.toIso8601String().substring(0, 10)}'
                              '${phases[i].endDate != null ? ' → ${phases[i].endDate!.toIso8601String().substring(0, 10)}' : ''}'
                              ' · ${phases[i].price} ${phases[i].currency}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined, size: 20),
                                  onPressed: () async {
                                    final edited = await _editPhaseDialog(ctx, l10n, phases[i], sub);
                                    if (edited != null) setLocal(() => phases[i] = edited);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete_outline_rounded, color: context.colors.danger, size: 20),
                                  onPressed: () => setLocal(() => phases.removeAt(i)),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          final companions = <PricePhasesCompanion>[];
                          for (var i = 0; i < phases.length; i++) {
                            final p = phases[i];
                            companions.add(
                              PricePhasesCompanion.insert(
                                id: p.id,
                                subscriptionId: sub.id,
                                type: p.type.name,
                                startDate: p.startDate,
                                endDate: Value(p.endDate),
                                price: p.price,
                                currency: p.currency,
                                billingCycle: p.billingCycle,
                                regularPrice: Value(p.regularPrice),
                                regularCurrency: Value(p.regularCurrency),
                                promotionName: Value(p.promotionName),
                                cancelDeadline: Value(p.cancelDeadline),
                                firstChargeDate: Value(p.firstChargeDate),
                                trialEndDate: Value(p.trialEndDate),
                                reminderDate: Value(p.reminderDate),
                                sortOrder: Value(i),
                              ),
                            );
                          }
                          await ref.read(subscriptionRepoProvider).replacePhases(sub.id, companions);
                          await maybeCloudUpload(ref, l10n);
                          Navigator.pop(ctx);
                          onChanged?.call();
                        },
                        child: Text(l10n.save),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

Future<PhaseView?> _editPhaseDialog(
  BuildContext context,
  AppLocalizations l10n,
  PhaseView? existing,
  SubscriptionView sub,
) async {
  var type = existing?.type ?? PricePhaseType.regular;
  var start = existing?.startDate ?? sub.startDate;
  DateTime? end = existing?.endDate;
  final priceCtrl = TextEditingController(text: '${existing?.price ?? sub.currentPrice}');
  final promoCtrl = TextEditingController(text: existing?.promotionName ?? '');
  final regularCtrl = TextEditingController(text: '${existing?.regularPrice ?? sub.currentPrice}');

  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setDialog) => AlertDialog(
        title: Text(existing == null ? l10n.addPhase : l10n.editPhase),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<PricePhaseType>(
                initialValue: type,
                decoration: InputDecoration(labelText: l10n.pricePhases),
                items: [
                  for (final t in PricePhaseType.values)
                    DropdownMenuItem(value: t, child: Text(l10n.pricePhaseLabel(t))),
                ],
                onChanged: (v) {
                  if (v != null) setDialog(() => type = v);
                },
              ),
              ListTile(
                title: Text(l10n.startDate),
                trailing: Text(start.toIso8601String().substring(0, 10)),
                onTap: () async {
                  final d = await showDatePicker(
                    context: ctx,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: start,
                  );
                  if (d != null) setDialog(() => start = d);
                },
              ),
              ListTile(
                title: Text(l10n.labelPromoEnd),
                trailing: Text(end?.toIso8601String().substring(0, 10) ?? '—'),
                onTap: () async {
                  final d = await showDatePicker(
                    context: ctx,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: end ?? start,
                  );
                  if (d != null) setDialog(() => end = d);
                },
              ),
              TextField(
                controller: priceCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: l10n.currentPrice),
              ),
              TextField(
                controller: regularCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: l10n.regularPriceAfterOffer),
              ),
              TextField(
                controller: promoCtrl,
                decoration: InputDecoration(labelText: l10n.promoName),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.save)),
        ],
      ),
    ),
  );

  final price = double.tryParse(priceCtrl.text.trim()) ?? 0;
  final regular = double.tryParse(regularCtrl.text.trim());
  final promoName = promoCtrl.text.trim();
  priceCtrl.dispose();
  promoCtrl.dispose();
  regularCtrl.dispose();
  if (ok != true) return null;

  return PhaseView(
    id: existing?.id ?? const Uuid().v4(),
    subscriptionId: sub.id,
    type: type,
    startDate: start,
    endDate: end,
    price: price,
    currency: existing?.currency ?? sub.currency,
    billingCycle: existing?.billingCycle ?? sub.billingCycle,
    regularPrice: regular,
    regularCurrency: existing?.regularCurrency ?? sub.currency,
    promotionName: promoName.isEmpty ? null : promoName,
    cancelDeadline: existing?.cancelDeadline,
    firstChargeDate: existing?.firstChargeDate,
    trialEndDate: existing?.trialEndDate,
    reminderDate: existing?.reminderDate,
    autoRenew: existing?.autoRenew ?? true,
  );
}
