import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/currencies.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/data/seed/bootstrap.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class AddOrderScreen extends ConsumerStatefulWidget {
  const AddOrderScreen({super.key});

  @override
  ConsumerState<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends ConsumerState<AddOrderScreen> {
  final title = TextEditingController();
  final platformCustom = TextEditingController();
  final price = TextEditingController();
  final notes = TextEditingController();
  final trackingUrl = TextEditingController();
  String platform = purchasePlatformPresets.first;
  PurchaseStatus status = PurchaseStatus.preorder;
  DateTime orderedAt = DateTime.now();
  DateTime? expectedAt;
  DateTime? reminderAt;
  int quantity = 1;
  String currency = 'TWD';
  bool saving = false;

  @override
  void dispose() {
    title.dispose();
    platformCustom.dispose();
    price.dispose();
    notes.dispose();
    trackingUrl.dispose();
    super.dispose();
  }

  String get _platformValue {
    if (platform == 'Other') {
      final custom = platformCustom.text.trim();
      return custom.isEmpty ? 'Other' : custom;
    }
    return platform;
  }

  Future<void> _pickDate({required bool expected}) async {
    final initial = expected ? (expectedAt ?? orderedAt.add(const Duration(days: 30))) : orderedAt;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (expected) {
        expectedAt = picked;
      } else {
        orderedAt = picked;
      }
    });
  }

  Future<void> _save() async {
    final name = title.text.trim();
    if (name.isEmpty) return;
    setState(() => saving = true);
    try {
      final parsedPrice = double.tryParse(price.text.trim());
      await ref.read(purchaseRepoProvider).create(
            profileId: ref.read(activeProfileIdProvider) ?? personalProfileId,
            platform: _platformValue,
            title: name,
            status: status,
            orderedAt: orderedAt,
            quantity: quantity,
            expectedAt: expectedAt,
            reminderAt: reminderAt ?? expectedAt?.subtract(const Duration(days: 3)),
            price: parsedPrice,
            currency: parsedPrice == null ? null : currency,
            trackingUrl: trackingUrl.text.trim().isEmpty ? null : trackingUrl.text.trim(),
            notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
          );
      if (!mounted) return;
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/orders');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addOrderTitle)),
      body: AppPage(
        child: ListView(
          children: [
            SectionLabel(l10n.orderItem),
            const SizedBox(height: 8),
            TextField(
              controller: title,
              decoration: InputDecoration(hintText: l10n.orderItemHint),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            SectionLabel(l10n.platform),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final p in purchasePlatformPresets)
                  ChoiceChip(
                    label: Text(p),
                    selected: platform == p,
                    onSelected: (_) => setState(() => platform = p),
                  ),
              ],
            ),
            if (platform == 'Other') ...[
              const SizedBox(height: 8),
              TextField(
                controller: platformCustom,
                decoration: InputDecoration(hintText: l10n.platformCustomHint),
              ),
            ],
            const SizedBox(height: 16),
            SectionLabel(l10n.purchaseStatus),
            const SizedBox(height: 8),
            DropdownButtonFormField<PurchaseStatus>(
              value: status,
              items: [
                for (final s in PurchaseStatus.values.where((s) => s != PurchaseStatus.cancelled))
                  DropdownMenuItem(value: s, child: Text(l10n.purchaseStatusLabel(s))),
              ],
              onChanged: (v) => setState(() => status = v ?? status),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(expected: false),
                    child: Text('${l10n.orderedAt}: ${orderedAt.toIso8601String().substring(0, 10)}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(expected: true),
                    child: Text(
                      expectedAt == null
                          ? l10n.expectedAtOptional
                          : '${l10n.expectedAt}: ${expectedAt!.toIso8601String().substring(0, 10)}',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionLabel(l10n.quantity),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                  icon: const Icon(Icons.remove),
                ),
                Text('$quantity', style: AppTypography.label(c.textPrimary)),
                IconButton(
                  onPressed: () => setState(() => quantity++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionLabel(l10n.priceOptional),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: price,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(hintText: l10n.priceOptional),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: currency,
                    items: [
                      for (final code in AppCurrencies.iso)
                        DropdownMenuItem(value: code, child: Text(code)),
                    ],
                    onChanged: (v) => setState(() => currency = v ?? currency),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: trackingUrl,
              decoration: InputDecoration(hintText: l10n.trackingUrlOptional),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: notes,
              maxLines: 3,
              decoration: InputDecoration(hintText: l10n.notesOptional),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: saving ? null : _save,
              child: Text(saving ? '…' : l10n.save),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
