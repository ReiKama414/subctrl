import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/currencies.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/notification_prompt.dart';
import 'package:subctrl/features/orders/order_actions.dart';
import 'package:subctrl/data/seed/bootstrap.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class AddOrderScreen extends ConsumerStatefulWidget {
  const AddOrderScreen({super.key, this.editId});
  final String? editId;

  @override
  ConsumerState<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends ConsumerState<AddOrderScreen> {
  final title = TextEditingController();
  final platformCustom = TextEditingController();
  final price = TextEditingController();
  final deposit = TextEditingController();
  final balance = TextEditingController();
  final shipping = TextEditingController();
  final service = TextEditingController();
  final seller = TextEditingController();
  final orderNo = TextEditingController();
  final trackingNo = TextEditingController();
  final forwarder = TextEditingController();
  final paymentNote = TextEditingController();
  final notes = TextEditingController();
  final trackingUrl = TextEditingController();
  String platform = purchasePlatformPresets.first;
  PurchaseStatus status = PurchaseStatus.preorder;
  PurchaseOrderKind orderKind = PurchaseOrderKind.preorder;
  DateTime orderedAt = DateTime.now();
  DateTime? expectedAt;
  DateTime? reminderAt;
  int quantity = 1;
  String currency = 'TWD';
  bool saving = false;
  bool loaded = false;

  bool get _editing => widget.editId != null;

  @override
  void initState() {
    super.initState();
    if (_editing) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _load());
    } else {
      loaded = true;
    }
  }

  Future<void> _load() async {
    final o = await ref.read(purchaseRepoProvider).getById(widget.editId!);
    if (o == null || !mounted) return;
    title.text = o.title;
    platform = purchasePlatformPresets.contains(o.platform) ? o.platform : 'Other';
    if (platform == 'Other') platformCustom.text = o.platform;
    status = o.status;
    orderKind = o.orderKind;
    orderedAt = o.orderedAt;
    expectedAt = o.expectedAt;
    reminderAt = o.reminderAt;
    quantity = o.quantity;
    currency = o.currency ?? 'TWD';
    if (o.price != null) price.text = '${o.price}';
    if (o.depositPaid != null) deposit.text = '${o.depositPaid}';
    if (o.balanceDue != null) balance.text = '${o.balanceDue}';
    if (o.shippingFee != null) shipping.text = '${o.shippingFee}';
    if (o.serviceFee != null) service.text = '${o.serviceFee}';
    seller.text = o.sellerName ?? '';
    orderNo.text = o.orderNumber ?? '';
    trackingNo.text = o.trackingNumber ?? '';
    forwarder.text = o.forwarder ?? '';
    paymentNote.text = o.paymentNote ?? '';
    notes.text = o.notes ?? '';
    trackingUrl.text = o.trackingUrl ?? '';
    setState(() => loaded = true);
  }

  @override
  void dispose() {
    title.dispose();
    platformCustom.dispose();
    price.dispose();
    deposit.dispose();
    balance.dispose();
    shipping.dispose();
    service.dispose();
    seller.dispose();
    orderNo.dispose();
    trackingNo.dispose();
    forwarder.dispose();
    paymentNote.dispose();
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

  double? _parse(String c) {
    final t = c.trim();
    if (t.isEmpty) return null;
    return double.tryParse(t);
  }

  Future<void> _pickDate({required bool expected, bool reminder = false}) async {
    final initial = reminder
        ? (reminderAt ?? expectedAt ?? orderedAt)
        : expected
            ? (expectedAt ?? orderedAt.add(const Duration(days: 30)))
            : orderedAt;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (reminder) {
        reminderAt = picked;
      } else if (expected) {
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
      final parsedPrice = _parse(price.text);
      final rem = reminderAt ?? expectedAt?.subtract(const Duration(days: 3));
      final repo = ref.read(purchaseRepoProvider);
      if (_editing) {
        await repo.updateFields(
          id: widget.editId!,
          platform: _platformValue,
          title: name,
          status: status,
          orderKind: orderKind,
          orderedAt: orderedAt,
          quantity: quantity,
          expectedAt: expectedAt,
          reminderAt: rem,
          price: parsedPrice,
          depositPaid: _parse(deposit.text),
          balanceDue: _parse(balance.text),
          shippingFee: _parse(shipping.text),
          serviceFee: _parse(service.text),
          currency: currency,
          sellerName: seller.text.trim().isEmpty ? null : seller.text.trim(),
          orderNumber: orderNo.text.trim().isEmpty ? null : orderNo.text.trim(),
          trackingNumber: trackingNo.text.trim().isEmpty ? null : trackingNo.text.trim(),
          trackingUrl: trackingUrl.text.trim().isEmpty ? null : trackingUrl.text.trim(),
          forwarder: forwarder.text.trim().isEmpty ? null : forwarder.text.trim(),
          paymentNote: paymentNote.text.trim().isEmpty ? null : paymentNote.text.trim(),
          notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
        );
      } else {
        await repo.create(
          profileId: ref.read(activeProfileIdProvider) ?? personalProfileId,
          platform: _platformValue,
          title: name,
          status: status,
          orderKind: orderKind,
          orderedAt: orderedAt,
          quantity: quantity,
          expectedAt: expectedAt,
          reminderAt: rem,
          price: parsedPrice,
          depositPaid: _parse(deposit.text),
          balanceDue: _parse(balance.text),
          shippingFee: _parse(shipping.text),
          serviceFee: _parse(service.text),
          currency: parsedPrice == null && _parse(deposit.text) == null ? null : currency,
          sellerName: seller.text.trim().isEmpty ? null : seller.text.trim(),
          orderNumber: orderNo.text.trim().isEmpty ? null : orderNo.text.trim(),
          trackingNumber: trackingNo.text.trim().isEmpty ? null : trackingNo.text.trim(),
          trackingUrl: trackingUrl.text.trim().isEmpty ? null : trackingUrl.text.trim(),
          forwarder: forwarder.text.trim().isEmpty ? null : forwarder.text.trim(),
          paymentNote: paymentNote.text.trim().isEmpty ? null : paymentNote.text.trim(),
          notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
        );
      }
      if (rem != null && mounted) {
        await ensureNotificationPermission(context, ref);
      }
      await resyncAllNotifications(ref);
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
    if (!loaded) {
      return Scaffold(
        appBar: AppBar(title: Text(_editing ? l10n.editOrder : l10n.addOrderTitle)),
        body: const Center(child: SkeletonBlock(height: 24, width: 120)),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_editing ? l10n.editOrder : l10n.addOrderTitle),
        actions: [
          if (_editing)
            IconButton(
              tooltip: l10n.deleteOrder,
              onPressed: () async {
                final deleted = await confirmAndDeleteOrder(context, ref, widget.editId!);
                if (deleted && context.mounted) {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/orders');
                  }
                }
              },
              icon: Icon(Icons.delete_outline_rounded, color: c.danger),
            ),
        ],
      ),
      body: AppPage(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            SectionLabel(l10n.orderItem),
            const SizedBox(height: 8),
            TextField(
              controller: title,
              decoration: InputDecoration(hintText: l10n.orderItemHint),
            ),
            const SizedBox(height: 16),
            SectionLabel(l10n.purchaseStatus),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final k in PurchaseOrderKind.values)
                  ChoiceChip(
                    label: Text(l10n.orderKindLabel(k)),
                    selected: orderKind == k,
                    onSelected: (_) => setState(() => orderKind = k),
                  ),
              ],
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
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => _pickDate(expected: false, reminder: true),
              child: Text(
                reminderAt == null
                    ? l10n.labelMyReminder
                    : '${l10n.labelMyReminder}: ${reminderAt!.toIso8601String().substring(0, 10)}',
              ),
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
            SectionLabel(l10n.depositPaid),
            const SizedBox(height: 8),
            TextField(
              controller: deposit,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: l10n.depositPaid),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: balance,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: l10n.balanceDue),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: shipping,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: l10n.shippingFee),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: service,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: l10n.serviceFee),
            ),
            const SizedBox(height: 20),
            SectionLabel(l10n.orderDetail),
            const SizedBox(height: 8),
            TextField(controller: seller, decoration: InputDecoration(labelText: l10n.sellerName)),
            const SizedBox(height: 12),
            TextField(controller: orderNo, decoration: InputDecoration(labelText: l10n.orderNumber)),
            const SizedBox(height: 12),
            TextField(controller: trackingNo, decoration: InputDecoration(labelText: l10n.trackingNumber)),
            const SizedBox(height: 12),
            TextField(controller: forwarder, decoration: InputDecoration(labelText: l10n.forwarder)),
            const SizedBox(height: 12),
            TextField(controller: paymentNote, decoration: InputDecoration(labelText: l10n.paymentNote)),
            const SizedBox(height: 12),
            TextField(
              controller: trackingUrl,
              decoration: InputDecoration(hintText: l10n.trackingUrlOptional),
            ),
            const SizedBox(height: 12),
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
