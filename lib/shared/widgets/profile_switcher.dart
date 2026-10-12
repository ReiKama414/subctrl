import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/l10n/app_localizations.dart';

class ProfileSwitcher extends ConsumerWidget {
  const ProfileSwitcher({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profilesProvider).valueOrNull ?? [];
    final activeId = ref.watch(activeProfileIdProvider);
    final l10n = context.l10n;
    if (profiles.isEmpty) return const SizedBox.shrink();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ChoiceChip(
            label: Text(compact ? 'ALL' : l10n.allProfiles),
            selected: activeId == null,
            onSelected: (_) async {
              await ref.read(settingsRepoProvider).patch(
                    const UserPreferencesCompanion(activeProfileId: Value(null)),
                  );
            },
          ),
          const SizedBox(width: 6),
          for (final p in profiles) ...[
            ChoiceChip(
              label: Text(p.name),
              selected: activeId == p.id,
              onSelected: (_) async {
                await ref.read(settingsRepoProvider).patch(
                      UserPreferencesCompanion(activeProfileId: Value(p.id)),
                    );
              },
            ),
            const SizedBox(width: 6),
          ],
        ],
      ),
    );
  }
}

class ProfileSectionLabel extends ConsumerWidget {
  const ProfileSectionLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(activeProfileIdProvider);
    final profiles = ref.watch(profilesProvider).valueOrNull ?? [];
    final l10n = context.l10n;
    final name = id == null
        ? l10n.allProfiles
        : profiles.where((p) => p.id == id).map((p) => p.name).firstOrNull ?? l10n.profile;
    return Text(name, style: AppTypography.label(context.colors.textMuted));
  }
}
