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

  bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final subs = ref.watch(scopedSubscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final events = CalendarEngine.events(subs, fx, month: month);
    final c = context.colors;
    final l10n = context.l10n;
    final first = DateTime(month.year, month.month, 1);
    final startWeekday = first.weekday % 7; // Sunday = 0
    final days = DateTime(month.year, month.month + 1, 0).day;
    final today = DateTime.now();
    final selectedEvents = selected == null
        ? const <CalendarDayEvent>[]
        : events.where((e) => _sameDay(e.date, selected!)).toList();
    final dayTotal = selectedEvents.fold<double>(0, (p, e) => p + e.amountBase);

    return AppPage(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const SizedBox(height: 8),
          SectionLabel(l10n.calendar),
          const SizedBox(height: 12),
          const ProfileSwitcher(compact: true),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() => month = DateTime(month.year, month.month - 1)),
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  '${month.year}-${month.month.toString().padLeft(2, '0')}',
                  textAlign: TextAlign.center,
                  style: AppTypography.title(c.textPrimary),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => month = DateTime(month.year, month.month + 1)),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final label in l10n.weekdayLabels)
                Expanded(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: AppTypography.label(c.textMuted).copyWith(fontSize: 10, letterSpacing: 0.8),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: startWeekday + days,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 52,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (_, i) {
              if (i < startWeekday) return const SizedBox.shrink();
              final day = i - startWeekday + 1;
              final date = DateTime(month.year, month.month, day);
              final dayEvents = events.where((e) => e.date.day == day).toList();
              final sel = selected != null && _sameDay(selected!, date);
              final isToday = _sameDay(today, date);
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppRadius.r6),
                  onTap: () => setState(() => selected = date),
                  child: Container(
                    decoration: BoxDecoration(
                      color: sel ? c.accent.withValues(alpha: 0.12) : c.surface,
                      border: Border.all(
                        color: sel ? c.accent : (isToday ? c.textSecondary : c.border),
                        width: sel || isToday ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.r6),
                    ),
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      children: [
                        Text(
                          '$day',
                          style: AppTypography.mono.copyWith(
                            fontSize: 12,
                            fontWeight: isToday || sel ? FontWeight.w700 : FontWeight.w500,
                            color: sel ? c.accent : c.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        if (dayEvents.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (final e in dayEvents.take(3))
                                  Container(
                                    width: 5,
                                    height: 5,
                                    margin: const EdgeInsets.symmetric(horizontal: 1),
                                    decoration: BoxDecoration(
                                      color: _color(e.kind, c),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                if (dayEvents.length > 3)
                                  Text(
                                    '+${dayEvents.length - 3}',
                                    style: AppTypography.mono.copyWith(fontSize: 8, color: c.textMuted),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          if (selected != null) ...[
            Text(
              selected!.toIso8601String().substring(0, 10),
              style: AppTypography.label(c.textPrimary),
            ),
            const SizedBox(height: 8),
            SurfaceCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Text(l10n.total, style: AppTypography.body(c.textSecondary)),
                  const Spacer(),
                  Text(
                    MoneyMath.format(dayTotal, fx.baseCurrency),
                    style: AppTypography.mono.copyWith(fontSize: 16, color: c.textPrimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (selectedEvents.isEmpty)
              EmptyNote(title: l10n.noEvents, body: l10n.noEventsBody)
            else
              ...selectedEvents.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SurfaceCard(
                    onTap: () => context.push('/subs/${e.subscriptionId}'),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(color: _color(e.kind, c), shape: BoxShape.circle),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.title, style: AppTypography.body(c.textPrimary)),
                              const SizedBox(height: 2),
                              Text(
                                e.kind.replaceAll('_', ' ').toUpperCase(),
                                style: AppTypography.label(c.textMuted).copyWith(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          e.amountBase == 0
                              ? e.currencyLabel
                              : MoneyMath.format(e.amountBase, fx.baseCurrency),
                          style: AppTypography.mono.copyWith(fontSize: 13, color: c.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Color _color(String kind, AppColors c) {
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
