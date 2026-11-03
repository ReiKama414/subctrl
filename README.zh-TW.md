# SUB//CTRL

[English](README.md)

**SUB//CTRL**（Subscription Control Center）是訂閱與預購帳本 App  
資料預設存在本機  
此 repo 不開源  
對外只透過 **GitHub Releases** 發 **local** APK  
維護者另建 **account** APK 自用（不上 Release）

## 兩種 APK

| 建置 | 檔名 | 對象 | 取得方式 |
| --- | --- | --- | --- |
| **Local** | `subctrl-local-release.apk` | 一般使用者 | GitHub Releases（tag `v*`）或你網站下載頁 |
| **Account** | `subctrl-account-release.apk` | 僅維護者本人 | 僅能在有 `dart_defines.json` 的本機執行腳本產生；**不在 GitHub、不在 Releases、不在 repo** |

## Local 版（公開）

- 進 App 不需登入（訪客／本機 session）
- 無雲端備份
- CI 建置不含 Google／LINE／Firebase 金鑰
- 匯率可在 App 內手動更新，來源為 [open.er-api.com](https://open.er-api.com)（免 API key）
- 備份與匯出：設定 → 資料（JSON／檔案），資料留在裝置

推送 **版本 tag** 後 GitHub Actions 會跑測試、建 APK 並掛到該 Release

**私人 repo 注意**  
未登入或無 repo 權限時，GitHub 的 Release 頁可能顯示 404  
若要在網站公開給路人下載，請在個人站 CMS「作品」填 APK 直連（可放 CDN 或公開託管），路徑例如 `/works/subctrl`  
GitHub 資產 URL 在 private repo 下通常無法給匿名使用者下載

## Account 版（僅維護者本機）

**外人無法下載此 APK**  
GitHub Actions 只建 **local** 版  
`build/` 整目錄已 gitignore，**任何 APK 都不會被 push 到 GitHub**  
Account 版必須在你電腦上跑腳本才會出現，且需要本機才有的 `dart_defines.json` 與 `google-services.json`

1. 複製 `dart_defines.example.json` → `dart_defines.json`（已 gitignore，**切勿 commit**）
2. 設定 `APP_AUTH_MODE=account` 以及 `GOOGLE_SERVER_CLIENT_ID` 等
3. 放入 `android/app/google-services.json`（你的 Firebase 專案）
4. 部署 Firestore 規則（雲端備份必備）  
   - **Console**：Firebase Console → Firestore → Rules，貼上 `firestore.rules` 後發布  
   - **CLI**（repo 內含 `firebase.json`）：

```bash
firebase login
firebase use YOUR_PROJECT_ID
firebase deploy --only firestore:rules
```

   App 寫入 `users/{uid}/meta/backup`  
   規則僅允許已登入使用者讀寫自己的 `users/{uid}/**`

5. 以 **Google** 登入後，設定內可雲端上傳／還原帳本
6. 建置（Windows 建議 clone 到 ASCII 路徑，例如 `C:\Users\you\subctrl-apk`）：

```powershell
.\scripts\build-account-apk.ps1
```

建置完成後，APK 只存在你電腦的 `build/account/subctrl-account-release.apk`（本機路徑說明，**不是下載連結**）  
用 USB／adb 等方式裝在自己的裝置即可  
**勿**上傳到 Release、網站 CMS 或任何公開 URL

本機建 **local** APK（與 CI 相同，非 account）：

```powershell
flutter build apk --release --dart-define=APP_AUTH_MODE=local
copy build\app\outputs\flutter-apk\app-release.apk build\local\subctrl-local-release.apk
```

## 開發

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter run --dart-define=APP_AUTH_MODE=local
```

含私有 define：專案根目錄有 `dart_defines.json` 時可執行 `.\scripts\run.ps1`

Windows 若路徑含非 ASCII 字元導致 Flutter 失敗，請改 clone 到英文路徑

## 技術（App）

Flutter · Dart · Drift · SQLite · Riverpod · go_router  
flutter_local_notifications · local_auth · fl_chart · http · intl  
Account 版：Firebase Auth · Firestore · Google Sign-In · LINE SDK

## 發行 tag

視需要更新 `pubspec.yaml` 的 `version`，然後：

```bash
git tag v1.0.1
git push origin v1.0.1
```

Actions 只上傳 **`subctrl-local-release.apk`** 到對應 Release

## 版權聲明

Copyright © 2026 ReiKama414  
保留一切權利  

本 repo 與 SUB//CTRL 應用程式（含原始碼、素材、品牌與文件）均屬專有作品  
除著作權人書面同意外，禁止複製、改作、散布或衍生利用  

經作者指定管道發布之 **local** APK（例如 GitHub Releases 或個人網站下載）不表示本程式碼以開源授權釋出
