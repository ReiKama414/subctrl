import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/features/orders/orders_screen.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(purchaseOrdersProvider);
    final l10n = context.l10n;
    final c = context.colors;
    final hide = ref.watch(preferencesProvider).valueOrNull?.hideAmounts == true;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.orderDetail)),
      body: AppPage(
        child: async.when(
          loading: () => const Padding(padding: EdgeInsets.all(24), child: SkeletonBlock(height: 80)),
          error: (e, _) => Text('$e'),
          data: (orders) {
            final order = orders.where((o) => o.id == id).firstOrNull;
            if (order == null) {
              return Text(l10n.orderNotFound, style: AppTypography.body(c.textMuted));
            }
            final tone = purchaseTone(order.status, c);
            return ListView(
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              children: [
                Row(
                  children: [
                    IconBadge(icon: purchaseIcon(order.status), color: tone, size: 60, iconSize: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.title, style: AppTypography.headline(c.textPrimary).copyWith(fontSize: 22)),
                          const SizedBox(height: 6),
                          StatusMark(l10n.purchaseStatusLabel(order.status), tone: tone),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SurfaceCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      _row(l10n.platform, order.platform, c),
                      _row(l10n.quantity, '${order.quantity}', c),
                      _row(l10n.orderedAt, order.orderedAt.toIso8601String().substring(0, 10), c),
                      if (order.expectedAt != null)
                        _row(l10n.expectedAt, order.expectedAt!.toIso8601String().substring(0, 10), c),
                      if (order.deliveredAt != null)
                        _row(l10n.deliveredAt, order.deliveredAt!.toIso8601String().substring(0, 10), c),
                      if (order.price != null)
                        _row(
                          l10n.priceOptional,
                          hide ? '••••' : MoneyMath.format(order.price!, order.currency ?? 'TWD'),
                          c,
                        ),
                    ],
                  ),
                ),
                if (order.notes != null && order.notes!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  SurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionLabel(l10n.notesOptional),
                        const SizedBox(height: 6),
                        Text(order.notes!, style: AppTypography.body(c.textSecondary)),
                      ],
                    ),
                  ),
                ],
                if (order.trackingUrl != null && order.trackingUrl!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => launchUrl(Uri.parse(order.trackingUrl!), mode: LaunchMode.externalApplication),
                    icon: const Icon(Icons.open_in_new_rounded, size: 18),
                    label: Text(l10n.openTracking),
                  ),
                ],
                const SizedBox(height: 28),
                SectionHeader(l10n.updateStatus),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final s in PurchaseStatus.values)
                      ChoiceChip(
                        avatar: Icon(
                          purchaseIcon(s),
                          size: 16,
                          color: order.status == s ? c.onAccent : purchaseTone(s, c),
                        ),
                        label: Text(l10n.purchaseStatusLabel(s)),
                        selected: order.status == s,
                        onSelected: (_) async {
                          await ref.read(purchaseRepoProvider).updateStatus(order.id, s);
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                TextButton.icon(
                  icon: Icon(Icons.delete_outline_rounded, color: c.danger, size: 20),
                  onPressed: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(l10n.deleteOrder),
                        content: Text(l10n.deleteOrderBody),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
                          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.deleteOrder)),
                        ],
                      ),
                    );
                    if (ok == true) {
                      await ref.read(purchaseRepoProvider).delete(order.id);
                      if (context.mounted) context.pop();
                    }
                  },
                  label: Text(l10n.deleteOrder, style: TextStyle(color: c.danger)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _row(String label, String value, AppColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTypography.body(c.textMuted))),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTypography.body(c.textPrimary).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
