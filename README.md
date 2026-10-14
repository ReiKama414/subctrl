# SUB//CTRL

Subscription Control Center — a local-first ledger for digital subscriptions, trials, promotions, renewals, and foreign-currency spend.

## Run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run \
  --dart-define=GOOGLE_SERVER_CLIENT_ID=your-web-client-id.apps.googleusercontent.com \
  --dart-define=LINE_CHANNEL_ID=REDACTED_LINE_CHANNEL
```

Guest mode works without an account. Google and LINE sign-in require the dart-defines above.

Demo sample data is **off** by default. Enable it from Settings → Load demo data.

## Configuration

| Integration | Dart define / native files |
| --- | --- |
| Google Sign-In | `--dart-define=GOOGLE_SERVER_CLIENT_ID=...` plus Android `google-services.json` / iOS `GoogleService-Info.plist` |
| LINE Login | `--dart-define=LINE_CHANNEL_ID=REDACTED_LINE_CHANNEL` plus LINE Developers channel (LINE Login type) |
| FX rates | Uses `https://open.er-api.com/v6/latest/USD` (no key). Manual override lives in Settings |
| Cloud backup | **Cloud Firestore** (Spark free tier). Not Firebase Storage (Storage needs Blaze). Upload / restore from Settings → Account after Google sign-in |

For Web Google sign-in, also pass `--dart-define=FIREBASE_WEB_APP_ID=1:REDACTED_PROJECT_NUMBER:web:xxxxxxxxxxxxxxxx`.

### Firestore (free) — enable + rules

1. Firebase Console → **Build → Firestore Database** → Create database (production mode is fine)
2. Rules:

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

Do **not** enable Storage unless you upgrade to Blaze. This app no longer uses Storage.

Payment methods store brand, last 4 digits, and expiry. Full card numbers and CVV are never stored.

## Tests

```bash
flutter analyze
flutter test
```
