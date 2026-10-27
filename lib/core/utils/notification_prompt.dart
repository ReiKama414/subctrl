import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/services/notification_service.dart';
import 'package:subctrl/l10n/app_localizations.dart';

/// Asks OS permission once when user enables reminders or adds a subscription.
Future<void> ensureNotificationPermission(BuildContext context, WidgetRef ref) async {
  final prefs = ref.read(preferencesProvider).valueOrNull;
  if (prefs?.notificationsEnabled != true) return;
  final asked = ref.read(notificationPermissionAskedProvider);
  if (asked) {
    await ref.read(notificationServiceProvider).requestPermission();
    return;
  }
  final l10n = context.l10n;
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.notificationPermissionTitle),
      content: Text(l10n.notificationPermissionBody),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.notNow)),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.enableNotifications)),
      ],
    ),
  );
  ref.read(notificationPermissionAskedProvider.notifier).state = true;
  if (ok == true) {
    await ref.read(notificationServiceProvider).requestPermission();
  }
}

final notificationPermissionAskedProvider = StateProvider<bool>((ref) => false);
