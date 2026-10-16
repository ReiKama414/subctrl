import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/core/constants/app_info.dart';
import 'package:subctrl/core/constants/currencies.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/services/auth_service.dart';
import 'package:subctrl/core/services/export_service.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/seed/demo_seed.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider).valueOrNull;
    final identities = ref.watch(identitiesProvider).valueOrNull ?? [];
    final fx = ref.watch(currencyEngineProvider);
    final rates = ref.watch(ratesProvider).valueOrNull ?? {};
    final l10n = context.l10n;
    if (prefs == null) {
      return const Scaffold(body: Center(child: SkeletonBlock(height: 24, width: 80)));
    }
    final localeCode = prefs.localeCode;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: AppPage(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 48),
          children: [
            SettingsBlock(
              label: l10n.language,
              top: 8,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final opt in [
                      ('system', l10n.languageSystem),
                      ('en', l10n.languageEn),
                      ('zh_TW', l10n.languageZh),
                      ('ja', l10n.languageJa),
                    ])
                      ChoiceChip(
                        label: Text(opt.$2),
                        selected: localeCode == opt.$1,
                        onSelected: (_) => ref.read(settingsRepoProvider).patch(
                              UserPreferencesCompanion(localeCode: Value(opt.$1)),
                            ),
                      ),
                  ],
                ),
              ],
            ),
            SettingsBlock(
              label: l10n.profiles,
              children: [
                const ProfileSwitcher(),
                const SizedBox(height: 4),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.addCustomProfile),
                  trailing: const Icon(Icons.add),
                  onTap: () => _addProfile(context, ref),
                ),
              ],
            ),
            SettingsBlock(
              label: l10n.appearance,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final p in ThemePreset.values)
                      ChoiceChip(
                        label: Text(l10n.themePresetLabel(p.name)),
                        selected: prefs.themePreset == p.name,
                        onSelected: (_) => ref.read(settingsRepoProvider).patch(
                              UserPreferencesCompanion(themePreset: Value(p.name)),
                            ),
                      ),
                  ],
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.reduceMotion),
                  value: prefs.reduceMotion,
                  onChanged: (v) => ref.read(settingsRepoProvider).patch(
                        UserPreferencesCompanion(reduceMotion: Value(v)),
                      ),
                ),
                if (prefs.themePreset == ThemePreset.custom.name) const _CustomThemeEditor(),
              ],
            ),
            SettingsBlock(
              label: l10n.currency,
              children: [
                DropdownButtonFormField<String>(
                  key: ValueKey('currency-${prefs.baseCurrency}'),
                  initialValue: prefs.baseCurrency,
                  decoration: const InputDecoration(border: UnderlineInputBorder()),
                  items: [
                    for (final c in AppCurrencies.featured)
                      DropdownMenuItem(value: c.code, child: Text('${c.code}  ${c.symbol}')),
                  ],
                  onChanged: (v) {
                    if (v != null) {
                      ref.read(settingsRepoProvider).patch(UserPreferencesCompanion(baseCurrency: Value(v)));
                    }
                  },
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<double>(
                  key: ValueKey('fee-${prefs.foreignFeePercent}'),
                  initialValue: [0.0, 1.0, 1.5, 2.0].contains(prefs.foreignFeePercent) ? prefs.foreignFeePercent : 0,
                  decoration: const InputDecoration(border: UnderlineInputBorder()),
                  items: [
                    DropdownMenuItem(value: 0.0, child: Text(l10n.foreignFeeOption('0'))),
                    DropdownMenuItem(value: 1.0, child: Text(l10n.foreignFeeOption('1'))),
                    DropdownMenuItem(value: 1.5, child: Text(l10n.foreignFeeOption('1.5'))),
                    DropdownMenuItem(value: 2.0, child: Text(l10n.foreignFeeOption('2'))),
                  ],
                  onChanged: (v) {
                    if (v != null) {
                      ref.read(settingsRepoProvider).patch(UserPreferencesCompanion(foreignFeePercent: Value(v)));
                    }
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.updateRates),
                  subtitle: Text([
                    if (fx.updatedAt != null) '${l10n.lastUpdated}: ${fx.updatedAt}',
                    if (fx.lastError != null) fx.lastError!,
                    if (fx.lastError != null && fx.updatedAt != null) l10n.usingLastKnownRate,
                  ].join('\n')),
                  onTap: () async {
                    final r = await ref.read(fxServiceProvider).refresh();
                    ref.invalidate(ratesProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            r.ok ? l10n.ratesUpdated : '${r.message}\n${l10n.usingLastKnownRate}',
                          ),
                        ),
                      );
                    }
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.manualFx),
                  subtitle: Text(l10n.manualFxSubtitle),
                  onTap: () => _manualFx(context, ref, rates),
                ),
                if (rates.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'USD → TWD ${(rates['TWD'] ?? AppCurrencies.usdFallbacks['TWD']!).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
            SettingsBlock(
              label: l10n.notifications,
              children: [
                Text(l10n.notificationsBody, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            SettingsBlock(
              label: l10n.security,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.biometricLock),
                  value: prefs.biometricLock,
                  onChanged: (v) => ref.read(settingsRepoProvider).patch(
                        UserPreferencesCompanion(biometricLock: Value(v)),
                      ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.hideAmounts),
                  value: prefs.hideAmounts,
                  onChanged: (v) => ref.read(settingsRepoProvider).patch(
                        UserPreferencesCompanion(hideAmounts: Value(v)),
                      ),
                ),
              ],
            ),
            SettingsBlock(
              label: l10n.account,
              children: [
                Text(l10n.accountOptionalNote, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text(l10n.firestoreSetupHint, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                ...[
                  'google',
                  if (!kIsWeb) 'line',
                  'guest',
                ].map((p) {
                  final linked = identities.any((i) => i.provider == p);
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.providerLabel(p)),
                    subtitle: Text(linked ? l10n.connected : l10n.notConnected),
                    trailing: linked ? null : Text(l10n.link),
                    onTap: linked
                        ? null
                        : () async {
                            try {
                              final id = await ref.read(authServiceProvider).byId(p).signIn();
                              await ref.read(settingsRepoProvider).linkIdentity(
                                    provider: id.provider,
                                    providerUserId: id.providerUserId,
                                    email: id.email,
                                    displayName: id.displayName,
                                  );
                              ref.invalidate(identitiesProvider);
                            } on AuthException catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
                              }
                            }
                          },
                  );
                }),
                if (kIsWeb)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(l10n.lineWebUnsupported, style: Theme.of(context).textTheme.bodySmall),
                  ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.sync),
                  subtitle: FutureBuilder(
                    future: ref.read(syncServiceProvider).status(l10n),
                    builder: (_, s) => Text(s.data ?? '…'),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.cloudUpload),
                  onTap: () => _cloudUpload(context, ref),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.cloudDownload),
                  onTap: () => _cloudDownload(context, ref),
                ),
              ],
            ),
            SettingsBlock(
              label: l10n.data,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.exportJson),
                  onTap: () => ref.read(exportServiceProvider).shareJson(),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.exportCsv),
                  onTap: () => ref.read(exportServiceProvider).shareCsv(),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.backup),
                  onTap: () async {
                    final path = await ref.read(exportServiceProvider).backupFile();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.backupWritten(path))));
                    }
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.restoreBackup),
                  onTap: () => _restoreFromBackup(context, ref),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.restorePaste),
                  onTap: () => _restoreFromPaste(context, ref),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(prefs.demoSeedEnabled ? l10n.clearDemo : l10n.loadDemo),
                  onTap: () async {
                    final repo = ref.read(subscriptionRepoProvider);
                    if (prefs.demoSeedEnabled) {
                      await repo.deleteDemo();
                      await ref.read(settingsRepoProvider).patch(
                            const UserPreferencesCompanion(demoSeedEnabled: Value(false)),
                          );
                    } else {
                      await DemoSeed(ref.read(databaseProvider), repo).load();
                    }
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.paymentMethods),
                  onTap: () => context.push('/methods'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.budget),
                  onTap: () => context.push('/budget'),
                ),
              ],
            ),
            SettingsBlock(
              label: l10n.about,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.version),
                  subtitle: Text(AppInfo.version),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.privacy),
                  subtitle: Text(l10n.privacyBody),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.terms),
                  subtitle: Text(l10n.termsBody),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cloudUpload(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    try {
      await ref.read(syncServiceProvider).upload(l10n);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.syncUploaded)));
      }
    } on SyncException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  Future<void> _cloudDownload(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    try {
      final raw = await ref.read(syncServiceProvider).download(l10n);
      if (raw == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.syncNoCloudBackup)));
        }
        return;
      }
      if (!context.mounted) return;
      await _confirmAndRestore(context, ref, raw);
    } on SyncException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  Future<void> _addProfile(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final ctrl = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.customProfileTitle),
        content: TextField(controller: ctrl, decoration: InputDecoration(hintText: l10n.addCustomProfile)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: Text(l10n.create),
          ),
        ],
      ),
    );
    ctrl.dispose();
    if (name == null || name.isEmpty) return;
    final id = await ref.read(settingsRepoProvider).createCustomProfile(name);
    await ref.read(settingsRepoProvider).setActiveProfile(id);
    ref.invalidate(profilesProvider);
  }

  Future<void> _manualFx(BuildContext context, WidgetRef ref, Map<String, double> rates) async {
    final l10n = context.l10n;
    var code = 'TWD';
    final ctrl = TextEditingController(text: (rates['TWD'] ?? AppCurrencies.usdFallbacks['TWD']!).toString());
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(l10n.manualFx),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: code,
                isExpanded: true,
                items: [
                  for (final c in AppCurrencies.iso)
                    DropdownMenuItem(value: c, child: Text('$c (units per 1 USD)')),
                ],
                onChanged: (v) {
                  if (v == null) return;
                  setLocal(() {
                    code = v;
                    ctrl.text = (rates[v] ?? AppCurrencies.usdFallbacks[v] ?? 1).toString();
                  });
                },
              ),
              TextField(
                controller: ctrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: l10n.manualFxSubtitle),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.save)),
          ],
        ),
      ),
    );
    final value = double.tryParse(ctrl.text.trim());
    ctrl.dispose();
    if (ok != true || value == null || value <= 0) return;
    await ref.read(fxServiceProvider).overrideRate(code, value);
    ref.invalidate(ratesProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.manualRateSaved(value.toString(), code))),
      );
    }
  }

  Future<void> _restoreFromBackup(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final raw = await ref.read(exportServiceProvider).readLocalBackup();
    if (raw == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.noLocalBackup)),
        );
      }
      return;
    }
    if (!context.mounted) return;
    await _confirmAndRestore(context, ref, raw);
  }

  Future<void> _restoreFromPaste(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final ctrl = TextEditingController();
    final raw = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.restorePaste),
        content: SizedBox(
          width: 420,
          child: TextField(
            controller: ctrl,
            maxLines: 12,
            decoration: const InputDecoration(hintText: '{ "subscriptions": [...] }'),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          FilledButton(onPressed: () => Navigator.pop(ctx, ctrl.text), child: Text(l10n.continueAction)),
        ],
      ),
    );
    ctrl.dispose();
    if (raw == null || raw.trim().isEmpty) return;
    if (!context.mounted) return;
    await _confirmAndRestore(context, ref, raw);
  }

  Future<void> _confirmAndRestore(BuildContext context, WidgetRef ref, String raw) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.restoreConfirmTitle),
        content: Text(l10n.restoreConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.overwriteRestore),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      final result = await ref.read(exportServiceProvider).restoreFromJson(raw, confirmedOverwrite: true);
      ref.invalidate(budgetsProvider);
      ref.invalidate(paymentMethodsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.restoreSuccess(result.subscriptionCount))),
        );
      }
    } on RestoreFormatError catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.restoreFailed('$e'))));
      }
    }
  }
}

class _CustomThemeEditor extends ConsumerWidget {
  const _CustomThemeEditor();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider).valueOrNull;
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(context.l10n.customThemeHelp),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _swatch(ref, prefs, 'accent', const Color(0xFF5EEAD4)),
            _swatch(ref, prefs, 'background', const Color(0xFF0B0C0E)),
            _swatch(ref, prefs, 'surface', const Color(0xFF14161A)),
            _swatch(ref, prefs, 'border', const Color(0xFF2A2E35)),
          ],
        ),
      ],
    );
  }

  Widget _swatch(WidgetRef ref, dynamic prefs, String key, Color fallback) {
    return OutlinedButton(
      onPressed: () async {
        final next = key == 'accent' ? const Color(0xFFE11D2A) : fallback;
        final map = <String, dynamic>{
          ...?jsonDecode(prefs?.customThemeJson ?? '{}') as Map<String, dynamic>?,
          key: next.toARGB32(),
        };
        await ref.read(settingsRepoProvider).patch(
              UserPreferencesCompanion(customThemeJson: Value(jsonEncode(map))),
            );
      },
      child: Text(key),
    );
  }
}
