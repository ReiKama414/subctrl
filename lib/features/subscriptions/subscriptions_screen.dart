import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
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
    final logos = ref.watch(logoResolverProvider);
    final l10n = context.l10n;
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(l10n.subscriptions),
          const SizedBox(height: 8),
          const ProfileSwitcher(compact: true),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(hintText: l10n.search),
            onChanged: (v) => ref.read(subListQueryProvider.notifier).state = query.copyWith(search: v),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final f in SubFilter.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ChoiceChip(
                      label: Text(f.name.toUpperCase()),
                      selected: query.filter == f,
                      onSelected: (_) => ref.read(subListQueryProvider.notifier).state = query.copyWith(filter: f),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ChoiceChip(
                  label: Text(l10n.allCats),
                  selected: query.category == null,
                  onSelected: (_) => ref.read(subListQueryProvider.notifier).state = query.copyWith(clearCategory: true),
                ),
                const SizedBox(width: 6),
                for (final cat in CategorySlug.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ChoiceChip(
                      label: Text(cat.label),
                      selected: query.category == cat.name,
                      onSelected: (_) =>
                          ref.read(subListQueryProvider.notifier).state = query.copyWith(category: cat.name),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          DropdownButton<SubscriptionSort>(
            value: query.sort,
            isExpanded: true,
            items: [
              for (final s in SubscriptionSort.values)
                DropdownMenuItem(value: s, child: Text(s.name.replaceAll(RegExp(r'([A-Z])'), ' \$1').toUpperCase())),
            ],
            onChanged: (v) {
              if (v != null) ref.read(subListQueryProvider.notifier).state = query.copyWith(sort: v);
            },
          ),
          Expanded(
            child: async.when(
              loading: () => const ListTile(title: SkeletonBlock()),
              error: (e, _) => Text('$e'),
              data: (_) {
                final list = _apply(ref.watch(scopedSubscriptionsProvider), query);
                if (list.isEmpty) {
                  return EmptyNote(
                    title: l10n.noSubscriptions,
                    body: l10n.noSubscriptionsBody,
                    action: () => context.push('/add'),
                  );
                }
                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final s = list[i];
                    return SurfaceCard(
                      onTap: () => context.push('/subs/${s.id}'),
                      child: Row(
                        children: [
                          InitialsMark(logos.initials(s.serviceName)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(s.serviceName, style: AppTypography.title(context.colors.textPrimary).copyWith(fontSize: 16)),
                                Text(
                                  '${s.status.label} · ${s.categorySlug.toUpperCase()}',
                                  style: AppTypography.label(context.colors.textMuted),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(MoneyMath.format(s.currentPrice, s.currency), style: AppTypography.mono.copyWith(color: context.colors.textPrimary)),
                              Text(
                                s.nextBillingDate?.toIso8601String().substring(5, 10) ?? '—',
                                style: AppTypography.mono.copyWith(fontSize: 11, color: context.colors.textMuted),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
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
