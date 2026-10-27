import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/repositories/purchase_repository.dart';
import 'package:subctrl/features/orders/purchase_flow.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';

Color purchaseTone(PurchaseStatus s, AppColors c) => switch (s) {
      PurchaseStatus.preorder || PurchaseStatus.awaitingShipment => c.warning,
      PurchaseStatus.shipped => AppPalette.swatches[5],
      PurchaseStatus.ordered => AppPalette.swatches[0],
      PurchaseStatus.delivered => c.success,
      PurchaseStatus.cancelled => c.textMuted,
    };

IconData purchaseIcon(PurchaseStatus s) => switch (s) {
      PurchaseStatus.preorder => Icons.schedule_rounded,
      PurchaseStatus.awaitingShipment => Icons.inventory_2_rounded,
      PurchaseStatus.shipped => Icons.local_shipping_rounded,
      PurchaseStatus.ordered => Icons.shopping_bag_rounded,
      PurchaseStatus.delivered => Icons.check_circle_rounded,
      PurchaseStatus.cancelled => Icons.block_rounded,
    };

enum _OrdersFilter { all, pending, overdue }

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  final _search = TextEditingController();
  _OrdersFilter filter = _OrdersFilter.all;
  PurchaseOrderKind? kindFilter;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<PurchaseOrderView> _apply(List<PurchaseOrderView> orders) {
    final q = _search.text.trim().toLowerCase();
    return orders.where((o) {
      if (kindFilter != null && o.orderKind != kindFilter) return false;
      if (filter == _OrdersFilter.pending && !o.isPending) return false;
      if (filter == _OrdersFilter.overdue && !purchaseIsOverdue(o.expectedAt, o.status)) return false;
      if (q.isEmpty) return true;
      final hay = '${o.title} ${o.platform} ${o.orderNumber ?? ''} ${o.sellerName ?? ''}'.toLowerCase();
      return hay.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(purchaseOrdersProvider);
    final l10n = context.l10n;
    final c = context.colors;
    final hide = ref.watch(preferencesProvider).valueOrNull?.hideAmounts == true;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.orders),
        actions: [
          IconButton(
            tooltip: l10n.addOrderTitle,
            onPressed: () => context.push('/orders/add'),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: AppPage(
        child: async.when(
          loading: () => const Padding(padding: EdgeInsets.only(top: 24), child: SkeletonBlock(height: 80)),
          error: (e, _) => Text('$e'),
          data: (_) {
            final orders = _apply(ref.watch(scopedPurchaseOrdersProvider));
            final pending = orders.where((o) => o.isPending).toList();
            final done = orders.where((o) => !o.isPending).toList();
            return ListView(
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              children: [
                const ProfileSwitcher(compact: true),
                const SizedBox(height: 12),
                TextField(
                  controller: _search,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: l10n.ordersSearchHint,
                    prefixIcon: const Icon(Icons.search_rounded),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: Text(l10n.ordersFilterAll),
                      selected: filter == _OrdersFilter.all,
                      onSelected: (_) => setState(() => filter = _OrdersFilter.all),
                    ),
                    ChoiceChip(
                      label: Text(l10n.ordersFilterPending),
                      selected: filter == _OrdersFilter.pending,
                      onSelected: (_) => setState(() => filter = _OrdersFilter.pending),
                    ),
                    ChoiceChip(
                      label: Text(l10n.ordersFilterOverdue),
                      selected: filter == _OrdersFilter.overdue,
                      onSelected: (_) => setState(() => filter = _OrdersFilter.overdue),
                    ),
                    for (final k in PurchaseOrderKind.values)
                      ChoiceChip(
                        label: Text(l10n.orderKindLabel(k)),
                        selected: kindFilter == k,
                        onSelected: (on) => setState(() => kindFilter = on ? k : null),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (orders.isEmpty)
                  EmptyNote(
                    icon: Icons.local_shipping_rounded,
                    title: l10n.noOrders,
                    body: l10n.noOrdersBody,
                    action: () => context.push('/orders/add'),
                    actionLabel: l10n.addOrderTitle,
                  )
                else ...[
                  SurfaceCard(
                    child: Row(
                      children: [
                        IconBadge(icon: Icons.pending_actions_rounded, color: c.warning, size: 44),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            l10n.pendingOrdersCount(pending.length),
                            style: AppTypography.title(c.textPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (pending.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    SectionHeader(l10n.pendingOrders),
                    ...pending.map((o) => _OrderTile(order: o, hide: hide, onTap: () => context.push('/orders/${o.id}'))),
                  ],
                  if (done.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    SectionHeader(l10n.completedOrders),
                    ...done.map((o) => _OrderTile(order: o, hide: hide, onTap: () => context.push('/orders/${o.id}'))),
                  ],
                ],
              ],
            );
          },
        ),
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
    final tone = purchaseTone(order.status, c);
    final overdue = purchaseIsOverdue(order.expectedAt, order.status);
    final days = purchaseDaysUntil(order.expectedAt);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SurfaceCard(
        padding: const EdgeInsets.all(14),
        onTap: onTap,
        child: Row(
          children: [
            IconBadge(icon: purchaseIcon(order.status), color: tone, size: 44),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body(order.isPending ? c.textPrimary : c.textMuted)
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    [
                      l10n.orderKindLabel(order.orderKind),
                      order.platform,
                      if (order.quantity > 1) '×${order.quantity}',
                      if (order.expectedAt != null) '${l10n.expectedAt} ${l10n.shortDate(order.expectedAt!)}',
                      if (overdue) l10n.ordersFilterOverdue,
                      if (days != null && days > 0 && order.isPending) l10n.actionDays(days),
                    ].join(' · '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption(overdue ? c.danger : c.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (order.totalAmount != null) ...[
                  Text(
                    hide ? '••••' : MoneyMath.format(order.totalAmount!, order.currency ?? 'TWD'),
                    style: AppTypography.amount(c.textPrimary, size: 14),
                  ),
                  const SizedBox(height: 4),
                ],
                StatusMark(l10n.purchaseStatusLabel(order.status), tone: tone),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
