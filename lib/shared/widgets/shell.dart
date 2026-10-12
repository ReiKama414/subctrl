import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/app_info.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = context.l10n;
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppPage(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Row(
                  children: [
                    Text(AppInfo.mark, style: AppTypography.label(c.accent)),
                    const Spacer(),
                    IconButton(
                      tooltip: l10n.settings,
                      onPressed: () => context.push('/settings'),
                      icon: Icon(Icons.tune, color: c.textSecondary, size: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: GlassBar(
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                _tab(context, 0, Icons.grid_view_outlined, l10n.navHome),
                _tab(context, 1, Icons.view_list_outlined, l10n.navSubs),
                _add(context),
                _tab(context, 2, Icons.insights_outlined, l10n.navData),
                _tab(context, 3, Icons.calendar_today_outlined, l10n.navCal),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tab(BuildContext context, int index, IconData icon, String label) {
    final selected = navigationShell.currentIndex == index;
    final c = context.colors;
    return Expanded(
      child: InkWell(
        onTap: () => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: selected ? c.accent : c.textMuted),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.label(selected ? c.accent : c.textMuted).copyWith(fontSize: 9)),
          ],
        ),
      ),
    );
  }

  Widget _add(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () => context.push('/add'),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: c.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.r6),
            border: Border.all(color: c.accent.withValues(alpha: 0.5)),
          ),
          child: Icon(Icons.add, color: c.accent, size: 20),
        ),
      ),
    );
  }
}
