# SUB//CTRL

[繁體中文](README.zh-TW.md)

**SUB//CTRL** (Subscription Control Center) is a local-first ledger for subscriptions and preorders  
This repository is not open source  
Public distribution is the **local** APK via **GitHub Releases**  
The maintainer builds a separate **account** APK locally (never uploaded by CI)

## Two APK variants

| Build | Filename | Audience | How to get |
| --- | --- | --- | --- |
| **Local** | `subctrl-local-release.apk` | Everyone | GitHub Releases (tag `v*`) or your site download page |
| **Account** | `subctrl-account-release.apk` | Maintainer only | Built only on your machine with `dart_defines.json`; **not on GitHub, Releases, or in the repo** |

## Local (public) APK

- No login gate — guest / on-device session
- No cloud backup
- CI build has no Google / LINE / Firebase keys
- FX rates: manual refresh in-app via [open.er-api.com](https://open.er-api.com) (no API key)
- Backup/export: Settings → Data (JSON / file); data stays on device

Push a **version tag** to trigger GitHub Actions: tests, APK build, Release upload

**Private repository note**  
Release URLs may return GitHub 404 without repo access  
For anonymous downloads on your website, host the APK at a public HTTPS URL and set it in your site CMS (project fields); e.g. `/works/subctrl`  
GitHub release asset links usually fail for anonymous users on private repos

## Account (maintainer machine only)

**This APK is not downloadable by the public**  
GitHub Actions builds **local** only  
The entire `build/` tree is gitignored — **no APK is ever pushed to GitHub**  
Account builds require a local `dart_defines.json` and `google-services.json` that only you have

1. Copy `dart_defines.example.json` → `dart_defines.json` (gitignored — **never commit**)
2. Set `APP_AUTH_MODE=account`, `GOOGLE_SERVER_CLIENT_ID`, etc.
3. Add `android/app/google-services.json` from your Firebase project
4. Deploy Firestore rules (required for cloud backup)  
   - **Console:** Firebase Console → Firestore → Rules — paste `firestore.rules`, then **Publish**  
   - **CLI** (repo `firebase.json`):

```bash
firebase login
firebase use YOUR_PROJECT_ID
firebase deploy --only firestore:rules
```

   Backup path: `users/{uid}/meta/backup`  
   Rules allow each signed-in user read/write only under `users/{their uid}/**`

5. After **Google** sign-in, Settings offers cloud upload/restore
6. Build (on Windows prefer an ASCII clone path, e.g. `C:\Users\you\subctrl-apk`):

```powershell
.\scripts\build-account-apk.ps1
```

After the build, the file exists only on your PC at `build/account/subctrl-account-release.apk` (a **local path**, not a download URL)  
Install on your own devices via USB/adb/etc.  
**Do not** upload it to Releases, your site CMS, or any public URL

Build **local** APK locally (same as CI, not account):

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

Private defines: run `.\scripts\run.ps1` when `dart_defines.json` exists

If Flutter fails on non-ASCII paths on Windows, clone to an ASCII directory

## Stack (app)

Flutter · Dart · Drift · SQLite · Riverpod · go_router  
flutter_local_notifications · local_auth · fl_chart · http · intl  
Account build: Firebase Auth · Firestore · Google Sign-In · LINE SDK

## Release tag

Bump `version` in `pubspec.yaml` if needed, then:

```bash
git tag v1.0.1
git push origin v1.0.1
```

GitHub Actions uploads **only** `subctrl-local-release.apk` to that Release

## Copyright

Copyright © 2026 ReiKama414  
All rights reserved  

This repository and the SUB//CTRL application (including source code, assets, branding, and documentation) are proprietary  
No license is granted to copy, modify, distribute, or create derivative works except as explicitly allowed by the copyright holder  

Public **local** APK distribution via GitHub Releases or other channels named by the author does not constitute open-source licensing of the codebase
