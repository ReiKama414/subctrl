import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/app/router.dart';
import 'package:subctrl/app/theme/app_theme.dart';
import 'package:subctrl/app/theme/presets.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/app_info.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class SubCtrlApp extends ConsumerWidget {
  const SubCtrlApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final prefs = ref.watch(preferencesProvider).valueOrNull;
    final tokens = _tokens(prefs);
    final unlocked = ref.watch(unlockedProvider);
    final locale = ref.watch(appLocaleProvider);
    return MaterialApp.router(
      title: AppInfo.name,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.fromTokens(tokens, reduceMotion: prefs?.reduceMotion ?? false),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (device, supported) {
        if (locale != null) return locale;
        if (device == null) return const Locale('en');
        for (final s in supported) {
          if (s.languageCode == device.languageCode) {
            if (s.languageCode == 'zh') return const Locale('zh', 'TW');
            return s;
          }
        }
        return const Locale('en');
      },
      routerConfig: router,
      builder: (context, child) {
        Widget body = child ?? const SizedBox.shrink();
        if (prefs?.biometricLock == true && !unlocked) {
          body = Stack(children: [body, const _LockGate()]);
        }
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: MediaQuery.of(context).textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.4),
          ),
          child: body,
        );
      },
    );
  }

  ThemeTokens _tokens(PreferenceView? prefs) {
    if (prefs == null) return ThemePresets.voidTheme;
    final preset = ThemePreset.values.firstWhere(
      (e) => e.name == prefs.themePreset,
      orElse: () => ThemePreset.voidTheme,
    );
    var tokens = ThemePresets.byPreset(preset);
    if (preset == ThemePreset.custom && prefs.customThemeJson != null) {
      tokens = ThemeTokens.fromCustomJson(
        jsonDecode(prefs.customThemeJson!) as Map<String, dynamic>,
        ThemePresets.voidTheme,
      );
    }
    return tokens;
  }
}

class _LockGate extends ConsumerStatefulWidget {
  const _LockGate();

  @override
  ConsumerState<_LockGate> createState() => _LockGateState();
}

class _LockGateState extends ConsumerState<_LockGate> {
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryUnlock());
  }

  Future<void> _tryUnlock() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final l10n = context.l10n;
    final ok = await ref.read(securityServiceProvider).unlock(
          reason: l10n.unlockReason,
          cancelButton: l10n.unlockCancel,
        );
    if (!mounted) return;
    if (ok) {
      ref.read(unlockedProvider.notifier).state = true;
      return;
    }
    setState(() {
      _busy = false;
      _error = l10n.biometricUnlockFailed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: context.colors.background.withValues(alpha: 0.96),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SectionLabel(l10n.locked),
                const SizedBox(height: 8),
                Text(
                  l10n.lockedHint,
                  textAlign: TextAlign.center,
                  style: AppTypography.body(context.colors.textMuted),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: AppTypography.caption(context.colors.danger),
                  ),
                ],
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _busy ? null : _tryUnlock,
                  child: Text(_busy ? '…' : l10n.unlock),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
