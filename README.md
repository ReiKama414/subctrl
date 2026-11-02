# SUB//CTRL

Subscription Control Center — local-first subscription and preorder ledger.

Distribution is **GitHub Releases only** (not open source). Two APK variants:

| APK | Who | How to get |
| --- | --- | --- |
| **Local** (`subctrl-local-release.apk`) | Everyone | GitHub Releases — tag `v*` |
| **Account** (`subctrl-account-release.apk`) | Maintainer only | Build on your machine (never uploaded by CI) |

## Public release (local APK)

- **No login screen** — opens onboarding / home directly (guest session)
- **No cloud backup**
- **No Google / LINE / Firebase / cloud** — no developer API keys in CI
- **FX refresh** uses public [open.er-api.com](https://open.er-api.com) when the user taps update rates (no key)
- Data stays on device; backup via Settings → Data (JSON / file)

CI builds this automatically when you push a version tag.

## Your private APK (account)

1. Copy `dart_defines.example.json` → `dart_defines.json` (gitignored)
2. Set `APP_AUTH_MODE` to `account` and your `GOOGLE_SERVER_CLIENT_ID`, etc.
3. Add `android/app/google-services.json` from your Firebase project
4. Deploy Firestore rules (required for cloud backup from the app):

   - **Console:** [Firestore → Rules](https://console.firebase.google.com/project/sub-ctrl/firestore/rules) — paste `firestore.rules`, then **Publish**.
   - **CLI** (uses repo `firebase.json`):

```bash
firebase login
firebase use sub-ctrl
firebase deploy --only firestore:rules
```

   App writes backup to `users/{uid}/meta/backup`. Rules allow each signed-in user to read/write only `users/{their uid}/**`. CMS content uses Admin SDK (separate env on your site), not these client rules.

5. Cloud backup appears in Settings after **Google** sign-in (Firebase Auth session)
6. Build (prefer an ASCII clone path on Windows, e.g. `C:\Users\you\subctrl-apk`):

```powershell
.\scripts\build-account-apk.ps1
```

Output: `build/account/subctrl-account-release.apk` — install manually; **do not** attach to public Releases.

To build the **local** APK locally (same as CI, not for account):

```powershell
flutter build apk --release --dart-define=APP_AUTH_MODE=local
copy build\app\outputs\flutter-apk\app-release.apk build\local\subctrl-local-release.apk
```

## Develop

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter run --dart-define=APP_AUTH_MODE=local
```

With private defines: `.\scripts\run.ps1` (uses `dart_defines.json` when present).

On Windows, use an ASCII path (e.g. `C:\Users\you\subctrl-apk`) if Flutter fails on non-ASCII project paths.

## Release tag

Bump `version` in `pubspec.yaml` if needed, then:

```bash
git tag v1.0.1
git push origin v1.0.1
```

GitHub Actions uploads **only** `subctrl-local-release.apk` to that Release.
