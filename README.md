# SUB//CTRL

Subscription Control Center — a local-first ledger for digital subscriptions, trials, promotions, renewals, and foreign-currency spend.

## Run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Guest mode works without an account. Google and LINE sign-in require native credentials (see below).

Demo sample data is **off** by default. Enable it from Settings → Load demo data.

## Configuration still required

| Integration | Dart define / native files |
| --- | --- |
| Google Sign-In | `--dart-define=GOOGLE_SERVER_CLIENT_ID=...` plus Android `google-services.json` / iOS `GoogleService-Info.plist` |
| LINE Login | `--dart-define=LINE_CHANNEL_ID=...` plus LINE SDK channel settings |
| FX rates | Uses `https://open.er-api.com/v6/latest/USD` (no key). Manual override lives in Settings |
| Cloud sync | Architecture only. Data stays on-device until a backend is wired |

Payment methods store brand, last 4 digits, and expiry. Full card numbers and CVV are never stored.

## Tests

```bash
flutter analyze
flutter test
```
