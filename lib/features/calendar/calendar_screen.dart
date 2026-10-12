import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});
  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime month;
  DateTime? selected;

  @override
  void initState() {
    super.initState();
    final n = DateTime.now();
    month = DateTime(n.year, n.month);
    selected = DateTime(n.year, n.month, n.day);
  }

  @override
  Widget build(BuildContext context) {
    final subs = ref.watch(scopedSubscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final events = CalendarEngine.events(subs, fx, month: month);
    final c = context.colors;
    final l10n = context.l10n;
    final first = DateTime(month.year, month.month, 1);
    final startWeekday = first.weekday % 7;
    final days = DateTime(month.year, month.month + 1, 0).day;
    return AppPage(
      child: ListView(
        children: [
          SectionLabel(l10n.calendar),
          const SizedBox(height: 8),
          const ProfileSwitcher(compact: true),
          Row(
            children: [
              IconButton(onPressed: () => setState(() => month = DateTime(month.year, month.month - 1)), icon: const Icon(Icons.chevron_left)),
              Expanded(child: Text('${month.year}-${month.month.toString().padLeft(2, '0')}', textAlign: TextAlign.center)),
              IconButton(onPressed: () => setState(() => month = DateTime(month.year, month.month + 1)), icon: const Icon(Icons.chevron_right)),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: startWeekday + days,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisExtent: 44),
            itemBuilder: (_, i) {
              if (i < startWeekday) return const SizedBox.shrink();
              final day = i - startWeekday + 1;
              final date = DateTime(month.year, month.month, day);
              final dayEvents = events.where((e) => e.date.day == day).toList();
              final sel = selected?.day == day;
              return InkWell(
                onTap: () => setState(() => selected = date),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: sel ? c.accent : c.border),
                    borderRadius: BorderRadius.circular(AppRadius.r4),
                  ),
                  child: Column(
                    children: [
                      Text('$day', style: AppTypography.mono.copyWith(fontSize: 11, color: c.textPrimary)),
                      if (dayEvents.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (final e in dayEvents.take(3))
                              Container(width: 4, height: 4, margin: const EdgeInsets.all(1), decoration: BoxDecoration(color: _color(e.kind, c), shape: BoxShape.circle)),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          if (selected != null) ...[
            Text(selected!.toIso8601String().substring(0, 10), style: AppTypography.label(c.textPrimary)),
            ...events.where((e) => e.date.day == selected!.day).map((e) => ListTile(
                  title: Text(e.title),
                  subtitle: Text(e.kind.replaceAll('_', ' ').toUpperCase()),
                  trailing: Text(e.amountBase == 0 ? e.currencyLabel : MoneyMath.format(e.amountBase, fx.baseCurrency)),
                  onTap: () => context.push('/subs/${e.subscriptionId}'),
                )),
            Builder(builder: (_) {
              final total = events.where((e) => e.date.day == selected!.day).fold<double>(0, (p, e) => p + e.amountBase);
              return ListTile(title: Text(l10n.total), trailing: Text(MoneyMath.format(total, fx.baseCurrency)));
            }),
            if (events.where((e) => e.date.day == selected!.day).isEmpty)
              EmptyNote(title: l10n.noEvents, body: l10n.noEventsBody),
          ],
        ],
      ),
    );
  }

  Color _color(String kind, dynamic c) {
    return switch (kind) {
      'payment' => c.accent,
      'cancelDeadline' => c.danger,
      'trialEnd' => c.warning,
      'promoEnd' => c.warning,
      'expiry' => c.textMuted,
      _ => c.textSecondary,
    };
  }
}
