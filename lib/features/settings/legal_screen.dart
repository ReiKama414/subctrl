import 'package:flutter/material.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

enum LegalKind { privacy, terms }

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key, required this.kind});
  final LegalKind kind;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = kind == LegalKind.privacy ? l10n.privacy : l10n.terms;
    final body = kind == LegalKind.privacy ? l10n.privacyFull : l10n.termsFull;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AppPage(
        child: ListView(
          padding: const EdgeInsets.only(top: 8, bottom: 48),
          children: [
            Text(body, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.45)),
          ],
        ),
      ),
    );
  }
}
