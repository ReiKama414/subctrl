import 'package:flutter/material.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/l10n/app_localizations.dart';

Future<Color?> showThemeColorPicker(
  BuildContext context, {
  required Color initial,
  required String title,
}) async {
  final l10n = context.l10n;
  return showDialog<Color>(
    context: context,
    builder: (ctx) {
      var color = initial;
      final c = ctx.colors;
      return StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final sw in AppPalette.swatches)
                        InkWell(
                          onTap: () => setState(() => color = sw),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: sw,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: color == sw ? c.textPrimary : c.border,
                                width: color == sw ? 2.5 : 1,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(l10n.customThemeChannelRed, style: AppTypography.caption(c.textMuted)),
                  Slider(
                    value: color.red / 255,
                    onChanged: (v) => setState(() => color = Color.fromARGB(255, (v * 255).round(), color.green, color.blue)),
                  ),
                  Text(l10n.customThemeChannelGreen, style: AppTypography.caption(c.textMuted)),
                  Slider(
                    value: color.green / 255,
                    onChanged: (v) => setState(() => color = Color.fromARGB(255, color.red, (v * 255).round(), color.blue)),
                  ),
                  Text(l10n.customThemeChannelBlue, style: AppTypography.caption(c.textMuted)),
                  Slider(
                    value: color.blue / 255,
                    onChanged: (v) => setState(() => color = Color.fromARGB(255, color.red, color.green, (v * 255).round())),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: c.border),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
              FilledButton(onPressed: () => Navigator.pop(ctx, color), child: Text(l10n.save)),
            ],
          );
        },
      );
    },
  );
}
