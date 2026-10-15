# SUB//CTRL

Subscription Control Center — a local-first ledger for digital subscriptions, trials, promotions, renewals, and foreign-currency spend.

## Run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Google / LINE / Web Firebase credentials are **built in as defaults**.  
You can just `flutter run` or `flutter run -d chrome` — no extra `--dart-define` needed.

Optional overrides:

- `dart_defines.json` (used by VS Code / Cursor launch configs and `scripts/run.ps1`)
- or `--dart-define-from-file=dart_defines.json`

```powershell
.\scripts\run.ps1 -Device chrome
```

Guest mode works without an account. Demo sample data is **off** by default (Settings → Load demo data).

## Configuration

| Integration | Notes |
| --- | --- |
| Google Sign-In | Default Web client ID embedded; Android needs `google-services.json` |
| LINE Login | Default Channel ID `REDACTED_LINE_CHANNEL` (native only; not Web) |
| FX rates | `https://open.er-api.com/v6/latest/USD` (no key) |
| Cloud backup | **Cloud Firestore** (Spark free). Settings → Account after Google sign-in |

### Firestore rules (free Spark)

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

Do **not** enable Storage (needs Blaze). This app uses Firestore only.

## Tests

```bash
flutter analyze
flutter test
```
