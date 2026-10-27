import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _page = PageController();
  int _index = 0;
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = context.l10n;
    final pages = [
      (l10n.onboard1a, l10n.onboard1b, Icons.layers_rounded, c.accent),
      (l10n.onboard2a, l10n.onboard2b, Icons.insights_rounded, AppPalette.swatches[0]),
      (l10n.onboard3a, l10n.onboard3b, Icons.notifications_active_rounded, AppPalette.swatches[1]),
    ];
    return Scaffold(
      body: SafeArea(
        child: AppPage(
          child: Column(
            children: [
              const SizedBox(height: 48),
              Expanded(
                child: PageView.builder(
                  controller: _page,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemCount: 3,
                  itemBuilder: (_, i) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: pages[i].$4.withValues(alpha: 0.12),
                        ),
                        child: Center(child: IconBadge(icon: pages[i].$3, color: pages[i].$4, size: 104, iconSize: 52)),
                      ),
                      const SizedBox(height: 40),
                      Text(pages[i].$1, textAlign: TextAlign.center, style: AppTypography.label(c.textMuted).copyWith(fontSize: 14)),
                      const SizedBox(height: 10),
                      Text(
                        pages[i].$2,
                        textAlign: TextAlign.center,
                        style: AppTypography.headline(c.textPrimary).copyWith(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 3; i++)
                    Container(
                      width: i == _index ? 16 : 6,
                      height: 6,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: i == _index ? c.accent : c.border,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                ],
              ),
              if (_index == 2) ...[
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _agreed,
                  onChanged: (v) => setState(() => _agreed = v == true),
                  title: Text(l10n.agreeTermsLabel, style: Theme.of(context).textTheme.bodySmall),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Row(
                  children: [
                    TextButton(onPressed: () => context.push('/legal/privacy'), child: Text(l10n.privacy)),
                    TextButton(onPressed: () => context.push('/legal/terms'), child: Text(l10n.terms)),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (_index < 2) {
                      _page.nextPage(duration: AppMotion.normal, curve: Curves.easeOut);
                      return;
                    }
                    if (!_agreed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.agreeTermsRequired)),
                      );
                      return;
                    }
                    await ref.read(settingsRepoProvider).patch(
                          const UserPreferencesCompanion(onboardingComplete: Value(true)),
                        );
                    if (context.mounted) context.go('/home');
                  },
                  child: Text(_index < 2 ? l10n.next : l10n.getStarted),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
