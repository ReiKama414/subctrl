import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/notification_prompt_store.dart';
import 'package:subctrl/l10n/app_localizations.dart';

/// In-app explainer, then OS notification permission when user opts in.
Future<void> ensureNotificationPermission(
  BuildContext context,
  WidgetRef ref, {
  bool requireNotificationsEnabled = true,
}) async {
  final prefs = ref.read(preferencesProvider).valueOrNull;
  if (requireNotificationsEnabled && prefs?.notificationsEnabled != true) return;

  final shown = await NotificationPromptStore.wasShown();
  if (shown) {
    if (prefs?.notificationsEnabled == true) {
      await ref.read(notificationServiceProvider).requestPermission();
    }
    return;
  }

  if (!context.mounted) return;
  final l10n = context.l10n;
  final ok = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.notificationPermissionTitle),
      content: Text(l10n.notificationPermissionBody),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.notNow)),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.enableNotifications)),
      ],
    ),
  );
  await NotificationPromptStore.markShown();
  if (ok == true) {
    await ref.read(notificationServiceProvider).requestPermission();
  }
}
