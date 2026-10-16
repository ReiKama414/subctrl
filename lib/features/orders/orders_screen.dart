import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/repositories/purchase_repository.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(purchaseOrdersProvider);
    final l10n = context.l10n;
    final c = context.colors;
    final hide = ref.watch(preferencesProvider).valueOrNull?.hideAmounts == true;

    return AppPage(
      child: async.when(
        loading: () => const Padding(padding: EdgeInsets.all(24), child: SkeletonBlock(height: 80)),
        error: (e, _) => Text('$e'),
        data: (_) {
          final orders = ref.watch(scopedPurchaseOrdersProvider);
          final pending = orders.where((o) => o.isPending).toList();
          final done = orders.where((o) => !o.isPending).toList();
          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Row(
                children: [
                  Expanded(child: SectionLabel(l10n.orders)),
                  TextButton(
                    onPressed: () => context.push('/orders/add'),
                    child: Text(l10n.addOrder),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const ProfileSwitcher(compact: true),
              const SizedBox(height: 16),
              Text(
                l10n.pendingOrdersCount(pending.length),
                style: AppTypography.label(c.accent),
              ),
              const SizedBox(height: 12),
              if (orders.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.noOrders, style: AppTypography.label(c.textPrimary)),
                      const SizedBox(height: 8),
                      Text(l10n.noOrdersBody, style: AppTypography.body(c.textMuted)),
                    ],
                  ),
                )
              else ...[
                if (pending.isNotEmpty) ...[
                  SectionLabel(l10n.pendingOrders),
                  const SizedBox(height: 8),
                  ...pending.map((o) => _OrderTile(order: o, hide: hide, onTap: () => context.push('/orders/${o.id}'))),
                  const SizedBox(height: 20),
                ],
                if (done.isNotEmpty) ...[
                  SectionLabel(l10n.completedOrders),
                  const SizedBox(height: 8),
                  ...done.map((o) => _OrderTile(order: o, hide: hide, onTap: () => context.push('/orders/${o.id}'))),
                ],
              ],
            ],
          );
        },
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({required this.order, required this.hide, required this.onTap});
  final PurchaseOrderView order;
  final bool hide;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final expected = order.expectedAt?.toIso8601String().substring(0, 10);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SurfaceCard(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.title, style: AppTypography.label(c.textPrimary)),
                  const SizedBox(height: 4),
                  Text(
                    '${order.platform} · ${l10n.purchaseStatusLabel(order.status)}'
                    '${order.quantity > 1 ? ' · ×${order.quantity}' : ''}',
                    style: AppTypography.body(c.textMuted),
                  ),
                  if (expected != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${l10n.expectedAt}: $expected',
                      style: AppTypography.body(order.status.isPreorderLike ? c.warning : c.textMuted),
                    ),
                  ],
                ],
              ),
            ),
            if (order.price != null)
              Text(
                hide ? '••••' : MoneyMath.format(order.price!, order.currency ?? 'TWD'),
                style: AppTypography.label(c.textSecondary),
              ),
          ],
        ),
      ),
    );
  }
}
