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
import 'package:subctrl/core/utils/notification_prompt.dart';
import 'package:subctrl/shared/widgets/theme_color_picker.dart';
import 'package:subctrl/core/services/auth_service.dart';
import 'package:subctrl/core/services/export_service.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/seed/demo_seed.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  leading: const Icon(Icons.person_add_alt_rounded),
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
                  secondary: const Icon(Icons.motion_photos_off_rounded),
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
                  leading: const Icon(Icons.currency_exchange_rounded),
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
                  leading: const Icon(Icons.tune_rounded),
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
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.notificationsEnabled),
                  value: prefs.notificationsEnabled,
                  onChanged: (v) async {
                    await ref.read(settingsRepoProvider).patch(
                          UserPreferencesCompanion(notificationsEnabled: Value(v)),
                        );
                    if (v && context.mounted) {
                      await ensureNotificationPermission(context, ref);
                    }
                    await resyncAllNotifications(ref, enabled: v);
                  },
                ),
              ],
            ),
            SettingsBlock(
              label: l10n.security,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.fingerprint_rounded),
                  title: Text(l10n.biometricLock),
                  subtitle: Text(l10n.securityBiometricHint),
                  value: prefs.biometricLock,
                  onChanged: (v) => ref.read(settingsRepoProvider).patch(
                        UserPreferencesCompanion(biometricLock: Value(v)),
                      ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.visibility_off_rounded),
                  title: Text(l10n.hideAmounts),
                  subtitle: Text(l10n.securityHideAmountsHint),
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
                    leading: Icon(p == 'guest' ? Icons.person_outline_rounded : Icons.account_circle_rounded),
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
                              if (context.mounted &&
                                  (ref.read(preferencesProvider).valueOrNull?.cloudAutoDownload ?? true)) {
                                await _cloudDownload(context, ref);
                              }
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
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.cloudAutoDownload),
                  value: prefs.cloudAutoDownload,
                  onChanged: (v) => ref.read(settingsRepoProvider).patch(
                        UserPreferencesCompanion(cloudAutoDownload: Value(v)),
                      ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.cloudAutoUpload),
                  value: prefs.cloudAutoUpload,
                  onChanged: (v) => ref.read(settingsRepoProvider).patch(
                        UserPreferencesCompanion(cloudAutoUpload: Value(v)),
                      ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.cloud_sync_rounded),
                  title: Text(l10n.sync),
                  subtitle: FutureBuilder(
                    future: ref.read(syncServiceProvider).status(l10n),
                    builder: (_, s) => Text(s.data ?? '…'),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.cloud_upload_rounded),
                  title: Text(l10n.cloudUpload),
                  onTap: () => _cloudUpload(context, ref),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.cloud_download_rounded),
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
                  leading: const Icon(Icons.data_object_rounded),
                  title: Text(l10n.exportJson),
                  onTap: () => ref.read(exportServiceProvider).shareJson(),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.table_chart_rounded),
                  title: Text(l10n.exportCsv),
                  onTap: () => ref.read(exportServiceProvider).shareCsv(),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.save_rounded),
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
                  leading: const Icon(Icons.settings_backup_restore_rounded),
                  title: Text(l10n.restoreBackup),
                  onTap: () => _restoreFromBackup(context, ref),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.content_paste_rounded),
                  title: Text(l10n.restorePaste),
                  onTap: () => _restoreFromPaste(context, ref),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.science_rounded),
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
                  leading: const Icon(Icons.credit_card_rounded),
                  title: Text(l10n.paymentMethods),
                  onTap: () => context.push('/methods'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.savings_rounded),
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
                  leading: const Icon(Icons.info_outline_rounded),
                  title: Text(l10n.version),
                  subtitle: Text(AppInfo.version),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person_outline_rounded),
                  title: Text(l10n.author),
                  subtitle: const Text(AppInfo.authorName),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.language_rounded),
                  title: Text(l10n.authorSite),
                  subtitle: const Text(AppInfo.authorSite),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                  onTap: () => launchUrl(
                    Uri.parse(AppInfo.authorSite),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.code_rounded),
                  title: Text(l10n.authorGithub),
                  subtitle: const Text(AppInfo.authorGithub),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                  onTap: () => launchUrl(
                    Uri.parse(AppInfo.authorGithub),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: Text(l10n.privacy),
                  subtitle: Text(l10n.privacyBody),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.description_outlined),
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
    final l10n = context.l10n;
    final map = <String, dynamic>{
      ...?jsonDecode(prefs?.customThemeJson ?? '{}') as Map<String, dynamic>?,
    };
    Color read(String key, Color fallback) {
      final v = map[key];
      if (v is int) return Color(v);
      return fallback;
    }

    final slots = [
      ('accent', l10n.customThemeAccent, const Color(0xFF5EEAD4)),
      ('background', l10n.customThemeBackground, const Color(0xFF0D0E12)),
      ('surface', l10n.customThemeSurface, const Color(0xFF17191F)),
      ('border', l10n.customThemeBorder, const Color(0xFF3A3F4A)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.customThemeHelp, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 12),
        for (final slot in slots)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(slot.$2),
              trailing: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: read(slot.$1, slot.$3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: context.colors.border),
                ),
              ),
              onTap: () async {
                final picked = await showThemeColorPicker(
                  context,
                  initial: read(slot.$1, slot.$3),
                  title: slot.$2,
                );
                if (picked == null) return;
                final next = <String, dynamic>{...map, slot.$1: picked.toARGB32()};
                await ref.read(settingsRepoProvider).patch(
                      UserPreferencesCompanion(customThemeJson: Value(jsonEncode(next))),
                    );
              },
            ),
          ),
      ],
    );
  }
}
