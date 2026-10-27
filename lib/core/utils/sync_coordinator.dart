import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/services/export_service.dart';
import 'package:subctrl/l10n/app_localizations.dart';

/// Best-effort cloud backup after local edits when the user opted in.
Future<void> maybeCloudUpload(WidgetRef ref, AppLocalizations l10n) async {
  if (!ref.read(cloudSyncEnabledProvider)) return;
  final prefs = ref.read(preferencesProvider).valueOrNull;
  if (prefs?.cloudAutoUpload != true) return;
  try {
    await ref.read(syncServiceProvider).upload(l10n);
  } on SyncException {
    // Silent — user can upload manually from settings.
  } catch (_) {}
}
