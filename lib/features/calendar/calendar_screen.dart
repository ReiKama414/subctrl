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
    _goToday();
  }

  void _goToday() {
    final n = DateTime.now();
    month = DateTime(n.year, n.month);
    selected = DateTime(n.year, n.month, n.day);
  }

  Future<void> _pickYearMonth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: month,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked == null) return;
    setState(() {
      month = DateTime(picked.year, picked.month);
      selected = DateTime(picked.year, picked.month, picked.day);
    });
  }

  bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final subs = ref.watch(scopedSubscriptionsProvider);
    final orders = ref.watch(scopedPurchaseOrdersProvider);
    final fx = ref.watch(currencyEngineProvider);
    final hide = ref.watch(preferencesProvider).valueOrNull?.hideAmounts == true;
    String money(double v) => hide ? '••••' : MoneyMath.format(v, fx.baseCurrency);
    final events = [
      ...CalendarEngine.events(subs, fx, month: month),
      ...CalendarEngine.orderEvents(orders, fx, month: month),
    ]..sort((a, b) => a.date.compareTo(b.date));
    final c = context.colors;
    final l10n = context.l10n;
    final first = DateTime(month.year, month.month, 1);
    final startWeekday = first.weekday % 7; // Sunday = 0
    final days = DateTime(month.year, month.month + 1, 0).day;
    final today = DateTime.now();
    final monthTotal = events.fold<double>(0, (p, e) => p + e.amountBase);
    final selectedEvents = selected == null
        ? const <CalendarDayEvent>[]
        : events.where((e) => _sameDay(e.date, selected!)).toList();
    final dayTotal = selectedEvents.fold<double>(0, (p, e) => p + e.amountBase);

    return AppPage(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          PageHeader(
            title: l10n.calendar,
            subtitle: l10n.eventsCount(events.length),
            actions: [
              HeaderIconButton(
                tooltip: l10n.jumpToToday,
                icon: Icons.today_rounded,
                onPressed: () => setState(_goToday),
              ),
              HeaderIconButton(
                tooltip: l10n.settings,
                icon: Icons.settings_rounded,
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),
          const ProfileSwitcher(compact: true),
          const SizedBox(height: 16),
          SurfaceCard(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => month = DateTime(month.year, month.month - 1)),
                      icon: const Icon(Icons.chevron_left_rounded),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: _pickYearMonth,
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(l10n.monthTitle(month.year, month.month), style: AppTypography.title(c.textPrimary)),
                                  const SizedBox(width: 4),
                                  Icon(Icons.arrow_drop_down_rounded, color: c.textMuted, size: 22),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${l10n.monthTotal}  ${money(monthTotal)}',
                                style: AppTypography.caption(c.textMuted),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() => month = DateTime(month.year, month.month + 1)),
                      icon: const Icon(Icons.chevron_right_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    for (var i = 0; i < 7; i++)
                      Expanded(
                        child: Text(
                          l10n.weekdayLabels[i],
                          textAlign: TextAlign.center,
                          style: AppTypography.caption(i == 0 || i == 6 ? c.textMuted.withValues(alpha: 0.7) : c.textMuted)
                              .copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: startWeekday + days,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisExtent: 50,
                  ),
                  itemBuilder: (_, i) {
                    if (i < startWeekday) return const SizedBox.shrink();
                    final day = i - startWeekday + 1;
                    final date = DateTime(month.year, month.month, day);
                    final dayEvents = events.where((e) => e.date.day == day).toList();
                    final sel = selected != null && _sameDay(selected!, date);
                    final isToday = _sameDay(today, date);
                    return InkResponse(
                      radius: 24,
                      onTap: () => setState(() => selected = date),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: AppMotion.fast,
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: sel ? c.accent : (isToday ? c.accent.withValues(alpha: 0.14) : Colors.transparent),
                            ),
                            child: Text(
                              '$day',
                              style: AppTypography.amount(
                                sel ? c.onAccent : (isToday ? c.accent : c.textPrimary),
                                size: 14,
                                weight: sel || isToday ? FontWeight.w800 : FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: 6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (final e in dayEvents.take(3))
                                  Container(
                                    width: 5,
                                    height: 5,
                                    margin: const EdgeInsets.symmetric(horizontal: 1),
                                    decoration: BoxDecoration(color: _color(e.kind, c), shape: BoxShape.circle),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (selected != null) ...[
            SectionHeader(
              l10n.longDate(selected!),
              trailing: Text(money(dayTotal), style: AppTypography.amount(c.textPrimary, size: 16)),
            ),
            if (selectedEvents.isEmpty)
              SurfaceCard(
                child: Row(
                  children: [
                    IconBadge(icon: Icons.event_available_rounded, color: c.textMuted, size: 36, iconSize: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.noEvents, style: AppTypography.label(c.textPrimary)),
                          const SizedBox(height: 2),
                          Text(l10n.noEventsBody, style: AppTypography.caption(c.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              ...selectedEvents.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SurfaceCard(
                    padding: const EdgeInsets.all(14),
                    onTap: () {
                      final oid = e.orderId;
                      if (oid != null && oid.isNotEmpty) {
                        context.push('/orders/$oid');
                      } else {
                        context.push('/subs/${e.subscriptionId}');
                      }
                    },
                    child: Row(
                      children: [
                        ServiceAvatar(e.title, size: 42),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title,
                                style: AppTypography.body(c.textPrimary).copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              const SizedBox(height: 4),
                              StatusMark(l10n.calendarEventKindLabel(e.kind), tone: _color(e.kind, c)),
                            ],
                          ),
                        ),
                        if (e.amountBase != 0)
                          Text(money(e.amountBase), style: AppTypography.amount(c.textPrimary, size: 15)),
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
      'promoEnd' => AppPalette.swatches[4],
      'priceChange' => AppPalette.swatches[5],
      'expiry' => c.textMuted,
      'orderExpected' => c.warning,
      'orderReminder' => AppPalette.swatches[2],
      'orderDelivered' => c.success,
      _ => c.textSecondary,
    };
  }
}
