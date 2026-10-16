import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/billing_math.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class SubscriptionsScreen extends ConsumerWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(subListQueryProvider);
    final async = ref.watch(subscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final hide = ref.watch(preferencesProvider).valueOrNull?.hideAmounts == true;
    final scoped = ref.watch(scopedSubscriptionsProvider);
    final l10n = context.l10n;
    final c = context.colors;
    final monthly = scoped.fold<double>(0, (p, s) => p + fx.monthlyBase(s));
    final refined = query.category != null || query.sort != SubscriptionSort.nextBilling;
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: l10n.subscriptions,
            subtitle: '${l10n.subsSummary(scoped.length)} · '
                '${hide ? '••••' : MoneyMath.format(monthly, fx.baseCurrency)} ${l10n.perMonth}',
            actions: [
              HeaderIconButton(
                tooltip: l10n.settings,
                icon: Icons.settings_rounded,
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),
          const ProfileSwitcher(compact: true),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: l10n.search,
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: IconButton(
                tooltip: l10n.filterSort,
                onPressed: () => _openFilters(context),
                icon: Badge(
                  isLabelVisible: refined,
                  smallSize: 8,
                  backgroundColor: c.accent,
                  child: const Icon(Icons.tune_rounded),
                ),
              ),
            ),
            onChanged: (v) => ref.read(subListQueryProvider.notifier).state = query.copyWith(search: v),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final f in SubFilter.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(l10n.subFilterLabel(f)),
                      selected: query.filter == f,
                      onSelected: (_) => ref.read(subListQueryProvider.notifier).state = query.copyWith(filter: f),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: async.when(
              skipLoadingOnReload: true,
              skipLoadingOnRefresh: true,
              loading: () => const SkeletonBlock(height: 72),
              error: (e, _) => Text('$e'),
              data: (_) {
                final list = _apply(scoped, query);
                if (list.isEmpty) {
                  return ListView(
                    children: [
                      EmptyNote(
                        icon: Icons.layers_rounded,
                        title: l10n.noSubscriptions,
                        body: l10n.noSubscriptionsBody,
                        action: () => context.push('/add'),
                        actionLabel: l10n.addSubscriptionTitle,
                      ),
                    ],
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => _SubscriptionTile(sub: list[i], hide: hide),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openFilters(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _FilterSheet(),
    );
  }

  List<SubscriptionView> _apply(List<SubscriptionView> all, SubListQuery q) {
    var list = [...all];
    list = switch (q.filter) {
      SubFilter.all => list,
      SubFilter.active => list.where((s) => s.status == SubscriptionStatus.active).toList(),
      SubFilter.trial => list.where((s) => s.status == SubscriptionStatus.trial).toList(),
      SubFilter.promo => list.where((s) => s.status == SubscriptionStatus.promo).toList(),
      SubFilter.cancelled => list.where((s) => s.status == SubscriptionStatus.cancelled).toList(),
      SubFilter.expired => list.where((s) => s.status == SubscriptionStatus.expired).toList(),
    };
    if (q.category != null) list = list.where((s) => s.categorySlug == q.category).toList();
    if (q.search.trim().isNotEmpty) {
      final n = q.search.toLowerCase();
      list = list.where((s) => s.serviceName.toLowerCase().contains(n)).toList();
    }
    list.sort((a, b) {
      switch (q.sort) {
        case SubscriptionSort.name:
          return a.serviceName.compareTo(b.serviceName);
        case SubscriptionSort.price:
          return b.currentPrice.compareTo(a.currentPrice);
        case SubscriptionSort.category:
          return a.categorySlug.compareTo(b.categorySlug);
        case SubscriptionSort.recentlyAdded:
          return b.createdAt.compareTo(a.createdAt);
        case SubscriptionSort.renewalUrgency:
        case SubscriptionSort.nextBilling:
          return (a.nextBillingDate ?? DateTime(9999)).compareTo(b.nextBillingDate ?? DateTime(9999));
      }
    });
    return list;
  }
}

class _SubscriptionTile extends StatelessWidget {
  const _SubscriptionTile({required this.sub, required this.hide});
  final SubscriptionView sub;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = context.l10n;
    final s = sub;
    final inactive = s.status == SubscriptionStatus.cancelled ||
        s.status == SubscriptionStatus.expired ||
        s.status == SubscriptionStatus.paused;
    final cycle = BillingCycle.values.where((e) => e.name == s.billingCycle).firstOrNull;
    final statusTone = switch (s.status) {
      SubscriptionStatus.trial => c.warning,
      SubscriptionStatus.promo => AppPalette.swatches[4],
      SubscriptionStatus.cancelled || SubscriptionStatus.expired => c.danger,
      SubscriptionStatus.paused => c.textMuted,
      SubscriptionStatus.active => c.success,
    };
    final days = s.nextBillingDate == null ? null : BillingMath.daysUntil(s.nextBillingDate!, DateTime.now());
    return SurfaceCard(
      padding: const EdgeInsets.all(14),
      onTap: () => context.push('/subs/${s.id}'),
      child: Row(
        children: [
          ServiceAvatar(
            s.serviceName,
            size: 46,
            dimmed: inactive,
            logoKey: s.logoKey ?? s.serviceId,
            website: s.officialWebsiteUrl,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.serviceName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title(inactive ? c.textMuted : c.textPrimary).copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (s.status != SubscriptionStatus.active) ...[
                      StatusMark(l10n.subscriptionStatus(s.status), tone: statusTone),
                      const SizedBox(width: 6),
                    ],
                    Flexible(
                      child: Text(
                        [
                          if (s.planName != null && s.planName!.isNotEmpty) s.planName!,
                          l10n.categorySlugLabel(s.categorySlug),
                        ].join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption(c.textMuted),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                hide ? '••••' : MoneyMath.format(s.currentPrice, s.currency),
                style: AppTypography.amount(inactive ? c.textMuted : c.textPrimary, size: 15),
              ),
              const SizedBox(height: 4),
              Text(
                [
                  if (cycle != null) l10n.billingCycleLabel(cycle),
                  if (days != null && days >= 0 && !inactive) l10n.dueIn(days),
                ].join(' · '),
                style: AppTypography.caption(days != null && days <= 3 && days >= 0 && !inactive ? c.warning : c.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends ConsumerWidget {
  const _FilterSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(subListQueryProvider);
    final notifier = ref.read(subListQueryProvider.notifier);
    final l10n = context.l10n;
    final c = context.colors;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(l10n.filterSort, style: AppTypography.title(c.textPrimary).copyWith(fontSize: 20))),
                TextButton(
                  onPressed: () => notifier.state = query.copyWith(clearCategory: true, sort: SubscriptionSort.nextBilling),
                  child: Text(l10n.resetFilters),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionLabel(l10n.sortBy),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in SubscriptionSort.values)
                  ChoiceChip(
                    label: Text(l10n.subscriptionSortLabel(s)),
                    selected: query.sort == s,
                    onSelected: (_) => notifier.state = query.copyWith(sort: s),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            SectionLabel(l10n.categoryTitle),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: Text(l10n.allCats),
                  selected: query.category == null,
                  onSelected: (_) => notifier.state = query.copyWith(clearCategory: true),
                ),
                for (final cat in CategorySlug.values)
                  ChoiceChip(
                    avatar: Icon(
                      AppPalette.categoryIcon(cat.name),
                      size: 16,
                      color: query.category == cat.name ? c.onAccent : AppPalette.category(cat.name),
                    ),
                    label: Text(l10n.categoryLabel(cat)),
                    selected: query.category == cat.name,
                    onSelected: (_) => notifier.state = query.copyWith(category: cat.name),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(onPressed: () => Navigator.pop(context), child: Text(l10n.continueAction)),
            ),
          ],
        ),
      ),
    );
  }
}
