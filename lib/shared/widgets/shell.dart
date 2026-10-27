import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/app_info.dart';
import 'package:subctrl/core/utils/notification_prompt.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ensureNotificationPermission(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationShell = widget.navigationShell;
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(bottom: false, child: navigationShell),
      bottomNavigationBar: GlassBar(
        child: SafeArea(
          top: false,
          child: Align(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppInfo.maxContentWidth),
              child: SizedBox(
                height: 68,
                child: Row(
                  children: [
                    _tab(context, 0, Icons.home_outlined, Icons.home_rounded, l10n.navHome),
                    _tab(context, 1, Icons.layers_outlined, Icons.layers_rounded, l10n.navSubs),
                    const _AddButton(),
                    _tab(context, 2, Icons.pie_chart_outline_rounded, Icons.pie_chart_rounded, l10n.navData),
                    _tab(context, 3, Icons.calendar_month_outlined, Icons.calendar_month_rounded, l10n.navCal),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tab(BuildContext context, int index, IconData icon, IconData activeIcon, String label) {
    final navigationShell = widget.navigationShell;
    final selected = navigationShell.currentIndex == index;
    final c = context.colors;
    final color = selected ? c.textPrimary : c.textMuted;
    return Expanded(
      child: Semantics(
        selected: selected,
        button: true,
        label: label,
        child: InkResponse(
          onTap: () => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
          radius: 36,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: AppMotion.normal,
                curve: Curves.easeOut,
                width: selected ? 56 : 40,
                height: 30,
                decoration: BoxDecoration(
                  color: selected ? c.accent.withValues(alpha: 0.18) : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Icon(selected ? activeIcon : icon, size: 22, color: selected ? c.accent : color),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.label(color).copyWith(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Tooltip(
        message: context.l10n.createNew,
        child: Material(
          color: c.accent,
          shape: const CircleBorder(),
          elevation: 0,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => showCreateSheet(context),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: c.accent.withValues(alpha: 0.35), blurRadius: 18, offset: const Offset(0, 6))],
              ),
              child: Icon(Icons.add_rounded, color: c.onAccent, size: 28),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showCreateSheet(BuildContext context) async {
  final l10n = context.l10n;
  final choice = await showModalBottomSheet<String>(
    context: context,
    builder: (ctx) {
      final c = ctx.colors;
      Widget option(String id, IconData icon, Color tone, String title, [String? subtitle]) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SurfaceCard(
            color: c.surfaceHigh,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            onTap: () => Navigator.pop(ctx, id),
            child: Row(
              children: [
                IconBadge(icon: icon, color: tone, size: 44),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.title(c.textPrimary).copyWith(fontSize: 15)),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(subtitle, style: AppTypography.caption(c.textMuted)),
                      ],
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: c.textMuted),
              ],
            ),
          ),
        );
      }

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.createNew, style: AppTypography.title(c.textPrimary).copyWith(fontSize: 20)),
              const SizedBox(height: 16),
              option('sub', Icons.autorenew_rounded, c.accent, l10n.addSubscriptionTitle),
              option('order', Icons.local_shipping_rounded, AppPalette.swatches[1], l10n.addOrderTitle, l10n.addOrderSubtitle),
              option('orders', Icons.receipt_long_rounded, AppPalette.swatches[0], l10n.orders),
            ],
          ),
        ),
      );
    },
  );
  if (!context.mounted || choice == null) return;
  switch (choice) {
    case 'sub':
      context.push('/add');
    case 'order':
      context.push('/orders/add');
    case 'orders':
      context.push('/orders');
  }
}
