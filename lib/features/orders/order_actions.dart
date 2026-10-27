import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/l10n/app_localizations.dart';

/// Confirms and deletes a preorder / proxy / instock order (not subscriptions).
Future<bool> confirmAndDeleteOrder(
  BuildContext context,
  WidgetRef ref,
  String orderId,
) async {
  final l10n = context.l10n;
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.deleteOrder),
      content: Text(l10n.deleteOrderBody),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.deleteOrder)),
      ],
    ),
  );
  if (ok != true) return false;
  await ref.read(purchaseRepoProvider).delete(orderId);
  await resyncAllNotifications(ref);
  return true;
}
