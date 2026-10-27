import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Persists whether we already showed the in-app notification explainer (survives restarts).
class NotificationPromptStore {
  static Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/.subctrl_notif_prompt_v1');
  }

  static Future<bool> wasShown() async {
    if (kIsWeb) return true;
    try {
      return await (await _file()).exists();
    } catch (_) {
      return false;
    }
  }

  static Future<void> markShown() async {
    if (kIsWeb) return;
    try {
      await (await _file()).writeAsString('1');
    } catch (_) {}
  }
}
