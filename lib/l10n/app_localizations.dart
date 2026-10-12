import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [
    Locale('en'),
    Locale('zh', 'TW'),
    Locale('ja'),
  ];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const _en = <String, String>{
    'appTagline': 'Subscription Control Center',
    'language': 'Language',
    'languageSystem': 'System',
    'languageEn': 'English',
    'languageZh': '繁體中文',
    'languageJa': '日本語',
    'settings': 'SETTINGS',
    'profiles': 'PROFILES',
    'appearance': 'APPEARANCE',
    'currency': 'CURRENCY',
    'notifications': 'NOTIFICATIONS',
    'security': 'SECURITY',
    'account': 'ACCOUNT',
    'data': 'DATA',
    'about': 'ABOUT',
    'navHome': 'HOME',
    'navSubs': 'SUBS',
    'navData': 'DATA',
    'navCal': 'CAL',
    'controlCenter': 'CONTROL CENTER',
    'monthlyLoad': 'MONTHLY LOAD',
    'yearForecast': 'YEAR FORECAST',
    'actionRequired': 'ACTION REQUIRED',
    'upcomingPayments': 'UPCOMING PAYMENTS',
    'noUrgentDeadlines': 'No urgent deadlines in the next 30 days.',
    'subscriptions': 'SUBSCRIPTIONS',
    'noSubscriptions': 'NO SUBSCRIPTIONS',
    'noSubscriptionsBody': 'Add your first subscription to start tracking your spending.',
    'addSubscription': '+ ADD SUBSCRIPTION',
    'addSubscriptionTitle': 'ADD SUBSCRIPTION',
    'search': 'Search',
    'calendar': 'CALENDAR',
    'noEvents': 'NO EVENTS',
    'noEventsBody': 'Nothing scheduled on this date.',
    'continueGoogle': 'Link Google (optional)',
    'continueLine': 'Link LINE (optional)',
    'continueLocally': 'Continue on this device',
    'loginLead': 'Everything stays on this device.',
    'loginOptionalHint': 'Account link is optional — for future sync only. Not required to use the app.',
    'loginFooter': 'Your subscriptions.\nUnder your control.',
    'next': 'NEXT',
    'getStarted': 'GET STARTED',
    'onboard1a': 'ALL YOUR SUBSCRIPTIONS',
    'onboard1b': 'IN ONE PLACE',
    'onboard2a': 'KNOW WHAT',
    'onboard2b': "YOU'LL PAY NEXT",
    'onboard3a': "DON'T FORGET",
    'onboard3b': 'TO CANCEL',
    'locked': 'LOCKED',
    'unlock': 'Unlock',
    'reduceMotion': 'Reduce motion',
    'biometricLock': 'Biometric lock',
    'hideAmounts': 'Hide amounts',
    'updateRates': 'Update exchange rates',
    'manualFx': 'Manual FX override',
    'manualFxSubtitle': 'Set units per 1 USD for any currency',
    'exportJson': 'Export JSON',
    'exportCsv': 'Export CSV',
    'backup': 'Backup',
    'restoreBackup': 'Restore from last backup',
    'restorePaste': 'Restore from pasted JSON',
    'restoreConfirmTitle': 'Overwrite local data?',
    'restoreConfirmBody':
        'Restore will replace subscriptions, price phases, payments, events, reminders, payment methods, and budgets on this device. Builtin service catalog is kept. Auth tokens are never imported.',
    'overwriteRestore': 'OVERWRITE & RESTORE',
    'cancel': 'CANCEL',
    'save': 'SAVE',
    'create': 'CREATE',
    'continueAction': 'CONTINUE',
    'loadDemo': 'Load demo data',
    'clearDemo': 'Clear demo data',
    'paymentMethods': 'Payment methods',
    'budget': 'Budget',
    'allProfiles': 'ALL PROFILES',
    'addCustomProfile': 'Add custom profile',
    'foreign': 'FOREIGN',
    'actionRequiredCount': 'ACTION REQUIRED',
    'activeCount': 'ACTIVE',
    'overBudget': 'OVER BUDGET',
    'detail': 'DETAIL',
    'currentPrice': 'CURRENT PRICE',
    'priceGraph': 'PRICE GRAPH',
    'paymentHistory': 'PAYMENT HISTORY',
    'eventHistory': 'EVENT HISTORY',
    'recordPayment': '+ RECORD',
    'noPaymentsYet': 'No payments recorded yet.',
    'cancelKeepHistory': 'Cancel (keep history)',
    'renewalIntent': 'RENEWAL INTENT',
    'usage': 'USAGE',
    'profile': 'PROFILE',
    'monthlyCost': 'MONTHLY COST',
    'annualForecast': 'ANNUAL FORECAST',
    'categorySpending': 'CATEGORY SPENDING',
    'trend12': '12 MONTH TREND',
    'whatIf': 'WHAT-IF',
    'selectService': 'SELECT SERVICE',
    'customSubscription': '+ CUSTOM SUBSCRIPTION',
    'selectPlan': 'SELECT PLAN',
    'billing': 'BILLING',
    'reminder': 'REMINDER',
    'back': 'BACK',
    'connected': 'Connected',
    'notConnected': 'Not connected',
    'link': 'Link',
    'version': 'Version',
    'privacy': 'Privacy',
    'terms': 'Terms',
    'total': 'TOTAL',
    'cancelledSavings': 'Cancelled savings / month',
    'yearInReview': 'Year in review',
    'allCats': 'ALL CATS',
    'stepOf': 'STEP {0} / {1}',
    'noSuggestedPlans': 'No suggested plans. Set price on the next step.',
    'startDate': 'Start date',
    'nextBillingDate': 'Next billing date',
    'foreignFee': 'Foreign fee',
    'estimatedCharge': 'Estimated charge',
    'lastUpdated': 'Last updated',
    'ratesUpdated': 'Rates updated.',
    'usingLastKnownRate': 'Using last known rate.',
    'foreignFeeOption': 'Foreign fee {0}%',
    'sync': 'Sync',
    'backupWritten': 'Backup written: {0}',
    'noLocalBackup': 'No local backup found. Create a backup first.',
    'restoreSuccess': 'Restored {0} subscriptions.',
    'restoreFailed': 'Restore failed: {0}',
    'privacyBody':
        'Data stays on this device unless you export it. Card numbers beyond last 4, CVV, and account passwords are never stored.',
    'termsBody': 'Local-first subscription ledger. Third-party brands remain their owners\' trademarks.',
    'notificationsBody':
        'Renewal, trial, promo, cancel deadline, price change, and annual renewal use local notifications. No network required.',
    'current': 'CURRENT',
    'newValue': 'NEW',
    'saveLabel': 'SAVE',
    'simCancel': 'CANCEL TO COMPARE',
    'perMonth': '/ month',
    'perYear': '/ year',
    'addMethod': 'ADD METHOD',
    'expiry': 'Expiry',
    'saveTotal': 'SAVE TOTAL',
    'categoryBudgets': 'CATEGORY BUDGETS',
    'monthlyTotalBudget': 'Monthly total budget',
    'usesPerMonth': 'Uses / month',
    'officialWebsite': 'Official website',
    'manageSubscription': 'Manage subscription',
    'subscriptionNotFound': 'Subscription not found.',
    'manualRateSaved': 'Manual rate saved: 1 USD = {0} {1}',
    'accountOptionalNote': 'Optional identity link. App works fully offline as Guest.',
    'customProfileTitle': 'Custom profile',
    'totalSpent': 'TOTAL SPENT',
    'mostExpensive': 'MOST EXPENSIVE',
    'biggestIncrease': 'BIGGEST LOAD',
    'cancelledCount': 'CANCELLED',
    'foreignSpend': 'FOREIGN SPEND',
  };

  static const _zh = <String, String>{
    'appTagline': '訂閱控制中心',
    'language': '語言',
    'languageSystem': '跟隨系統',
    'languageEn': 'English',
    'languageZh': '繁體中文',
    'languageJa': '日本語',
    'settings': '設定',
    'profiles': '檔案',
    'appearance': '外觀',
    'currency': '貨幣',
    'notifications': '通知',
    'security': '安全',
    'account': '帳號',
    'data': '數據',
    'about': '關於',
    'navHome': '首頁',
    'navSubs': '訂閱',
    'navData': '數據',
    'navCal': '日曆',
    'controlCenter': '控制中心',
    'monthlyLoad': '每月負擔',
    'yearForecast': '年度預測',
    'actionRequired': '需要處理',
    'upcomingPayments': '即將付款',
    'noUrgentDeadlines': '未來 30 天內沒有緊急期限。',
    'subscriptions': '訂閱列表',
    'noSubscriptions': '尚無訂閱',
    'noSubscriptionsBody': '新增第一筆訂閱，開始追蹤你的支出。',
    'addSubscription': '+ 新增訂閱',
    'addSubscriptionTitle': '新增訂閱',
    'search': '搜尋',
    'calendar': '日曆',
    'noEvents': '沒有事件',
    'noEventsBody': '這天沒有排程。',
    'continueGoogle': '連結 Google（可選）',
    'continueLine': '連結 LINE（可選）',
    'continueLocally': '在本機繼續使用',
    'loginLead': '資料保存在這台裝置。',
    'loginOptionalHint': '帳號連結為可選，僅供之後同步；不是使用 App 的必要條件。',
    'loginFooter': '你的訂閱。\n由你掌控。',
    'next': '下一步',
    'getStarted': '開始使用',
    'onboard1a': '所有訂閱',
    'onboard1b': '集中一處',
    'onboard2a': '清楚知道',
    'onboard2b': '下一筆要付多少',
    'onboard3a': '別忘了',
    'onboard3b': '及時取消',
    'locked': '已鎖定',
    'unlock': '解鎖',
    'reduceMotion': '減少動態效果',
    'biometricLock': '生物辨識鎖定',
    'hideAmounts': '隱藏金額',
    'updateRates': '更新匯率',
    'manualFx': '手動覆寫匯率',
    'manualFxSubtitle': '設定每 1 USD 對應的當地幣數量',
    'exportJson': '匯出 JSON',
    'exportCsv': '匯出 CSV',
    'backup': '備份',
    'restoreBackup': '從上次備份還原',
    'restorePaste': '貼上 JSON 還原',
    'restoreConfirmTitle': '覆寫本機資料？',
    'restoreConfirmBody': '還原會取代本機的訂閱、價格階段、付款、事件、提醒、付款方式與預算。內建服務目錄會保留。不會匯入登入權杖。',
    'overwriteRestore': '覆寫並還原',
    'cancel': '取消',
    'save': '儲存',
    'create': '建立',
    'continueAction': '繼續',
    'loadDemo': '載入示範資料',
    'clearDemo': '清除示範資料',
    'paymentMethods': '付款方式',
    'budget': '預算',
    'allProfiles': '全部檔案',
    'addCustomProfile': '新增自訂檔案',
    'foreign': '外幣',
    'actionRequiredCount': '待處理',
    'activeCount': '進行中',
    'overBudget': '超出預算',
    'detail': '明細',
    'currentPrice': '目前價格',
    'priceGraph': '價格圖表',
    'paymentHistory': '付款紀錄',
    'eventHistory': '事件時間軸',
    'recordPayment': '+ 記錄付款',
    'noPaymentsYet': '尚無付款紀錄。',
    'cancelKeepHistory': '取消訂閱（保留歷史）',
    'renewalIntent': '續訂意向',
    'usage': '使用頻率',
    'profile': '檔案',
    'monthlyCost': '每月花費',
    'annualForecast': '年度預測',
    'categorySpending': '分類支出',
    'trend12': '12 個月趨勢',
    'whatIf': '假設模擬',
    'selectService': '選擇服務',
    'customSubscription': '+ 自訂訂閱',
    'selectPlan': '選擇方案',
    'billing': '計費',
    'reminder': '提醒',
    'back': '返回',
    'connected': '已連結',
    'notConnected': '未連結',
    'link': '連結',
    'version': '版本',
    'privacy': '隱私',
    'terms': '條款',
    'total': '合計',
    'cancelledSavings': '已取消節省／月',
    'yearInReview': '年度回顧',
    'allCats': '全部分類',
    'stepOf': '步驟 {0} / {1}',
    'noSuggestedPlans': '沒有建議方案，請在下一步設定價格。',
    'startDate': '開始日期',
    'nextBillingDate': '下次扣款日',
    'foreignFee': '外幣手續費',
    'estimatedCharge': '預估扣款',
    'lastUpdated': '上次更新',
    'ratesUpdated': '匯率已更新。',
    'usingLastKnownRate': '使用上次已知匯率。',
    'foreignFeeOption': '外幣手續費 {0}%',
    'sync': '同步',
    'backupWritten': '備份已寫入：{0}',
    'noLocalBackup': '找不到本機備份，請先建立備份。',
    'restoreSuccess': '已還原 {0} 筆訂閱。',
    'restoreFailed': '還原失敗：{0}',
    'privacyBody': '除非你主動匯出，資料都留在這台裝置。不會儲存完整卡號、CVV 或帳號密碼。',
    'termsBody': '本機優先的訂閱帳本。第三方品牌商標歸其權利人所有。',
    'notificationsBody': '續訂、試用、優惠、取消期限、價格變動與年度續訂使用本機通知，不需網路。',
    'current': '目前',
    'newValue': '模擬後',
    'saveLabel': '可節省',
    'simCancel': '勾選要取消的項目',
    'perMonth': '／月',
    'perYear': '／年',
    'addMethod': '新增付款方式',
    'expiry': '到期',
    'saveTotal': '儲存總預算',
    'categoryBudgets': '分類預算',
    'monthlyTotalBudget': '每月總預算',
    'usesPerMonth': '每月使用次數',
    'officialWebsite': '官方網站',
    'manageSubscription': '管理訂閱',
    'subscriptionNotFound': '找不到訂閱。',
    'manualRateSaved': '已儲存手動匯率：1 USD = {0} {1}',
    'accountOptionalNote': '可選身分連結。Guest 模式可完整離線使用。',
    'customProfileTitle': '自訂檔案',
    'totalSpent': '年度總支出',
    'mostExpensive': '最高花費',
    'biggestIncrease': '最高月額',
    'cancelledCount': '已取消',
    'foreignSpend': '外幣支出',
  };

  static const _ja = <String, String>{
    'appTagline': 'サブスクリプション管理センター',
    'language': '言語',
    'languageSystem': 'システム',
    'languageEn': 'English',
    'languageZh': '繁體中文',
    'languageJa': '日本語',
    'settings': '設定',
    'profiles': 'プロファイル',
    'appearance': '外観',
    'currency': '通貨',
    'notifications': '通知',
    'security': 'セキュリティ',
    'account': 'アカウント',
    'data': 'データ',
    'about': 'このアプリについて',
    'navHome': 'ホーム',
    'navSubs': '契約',
    'navData': 'データ',
    'navCal': 'カレンダー',
    'controlCenter': 'コントロールセンター',
    'monthlyLoad': '月額負担',
    'yearForecast': '年間予測',
    'actionRequired': '要対応',
    'upcomingPayments': '今後の支払い',
    'noUrgentDeadlines': '今後30日に緊急期限はありません。',
    'subscriptions': 'サブスクリプション',
    'noSubscriptions': '契約がありません',
    'noSubscriptionsBody': '最初のサブスクリプションを追加して支出を追跡しましょう。',
    'addSubscription': '+ 追加',
    'addSubscriptionTitle': 'サブスク追加',
    'search': '検索',
    'calendar': 'カレンダー',
    'noEvents': '予定なし',
    'noEventsBody': 'この日の予定はありません。',
    'continueGoogle': 'Google を連携（任意）',
    'continueLine': 'LINE を連携（任意）',
    'continueLocally': 'この端末で続ける',
    'loginLead': 'データはこの端末に保存されます。',
    'loginOptionalHint': 'アカウント連携は任意です。将来の同期用で、利用に必須ではありません。',
    'loginFooter': 'あなたの契約を。\nあなたの管理下に。',
    'next': '次へ',
    'getStarted': 'はじめる',
    'onboard1a': 'すべての契約を',
    'onboard1b': 'ひとつに',
    'onboard2a': '次に払う金額を',
    'onboard2b': '把握する',
    'onboard3a': '解約期限を',
    'onboard3b': '忘れない',
    'locked': 'ロック中',
    'unlock': '解除',
    'reduceMotion': 'モーションを減らす',
    'biometricLock': '生体認証ロック',
    'hideAmounts': '金額を隠す',
    'updateRates': '為替を更新',
    'manualFx': '為替の手動上書き',
    'manualFxSubtitle': '1 USD あたりのレートを設定',
    'exportJson': 'JSON を書き出し',
    'exportCsv': 'CSV を書き出し',
    'backup': 'バックアップ',
    'restoreBackup': '最新バックアップから復元',
    'restorePaste': 'JSON を貼り付けて復元',
    'restoreConfirmTitle': 'ローカルデータを上書きしますか？',
    'restoreConfirmBody': '復元すると、端末上の契約・価格段階・支払い・イベント・リマインダー・支払い方法・予算が置き換わります。組み込みサービス一覧は保持されます。認証トークンは取り込みません。',
    'overwriteRestore': '上書きして復元',
    'cancel': 'キャンセル',
    'save': '保存',
    'create': '作成',
    'continueAction': '続行',
    'loadDemo': 'デモデータを読み込む',
    'clearDemo': 'デモデータを削除',
    'paymentMethods': '支払い方法',
    'budget': '予算',
    'allProfiles': 'すべてのプロファイル',
    'addCustomProfile': 'カスタムプロファイルを追加',
    'foreign': '外貨',
    'actionRequiredCount': '要対応',
    'activeCount': '有効',
    'overBudget': '予算超過',
    'detail': '詳細',
    'currentPrice': '現在の価格',
    'priceGraph': '価格グラフ',
    'paymentHistory': '支払い履歴',
    'eventHistory': 'イベント履歴',
    'recordPayment': '+ 支払い記録',
    'noPaymentsYet': '支払い記録はまだありません。',
    'cancelKeepHistory': '解約（履歴は保持）',
    'renewalIntent': '更新意向',
    'usage': '利用頻度',
    'profile': 'プロファイル',
    'monthlyCost': '月額コスト',
    'annualForecast': '年間予測',
    'categorySpending': 'カテゴリ支出',
    'trend12': '12か月トレンド',
    'whatIf': 'What-If シミュレータ',
    'selectService': 'サービスを選択',
    'customSubscription': '+ カスタム契約',
    'selectPlan': 'プランを選択',
    'billing': '請求',
    'reminder': 'リマインダー',
    'back': '戻る',
    'connected': '連携済み',
    'notConnected': '未連携',
    'link': '連携',
    'version': 'バージョン',
    'privacy': 'プライバシー',
    'terms': '利用規約',
    'total': '合計',
    'cancelledSavings': '解約による節約／月',
    'yearInReview': '年間レビュー',
    'allCats': '全カテゴリ',
    'stepOf': 'ステップ {0} / {1}',
    'noSuggestedPlans': '提案プランはありません。次の画面で価格を設定してください。',
    'startDate': '開始日',
    'nextBillingDate': '次回請求日',
    'foreignFee': '外貨手数料',
    'estimatedCharge': '見積請求額',
    'lastUpdated': '最終更新',
    'ratesUpdated': '為替を更新しました。',
    'usingLastKnownRate': '前回のレートを使用します。',
    'foreignFeeOption': '外貨手数料 {0}%',
    'sync': '同期',
    'backupWritten': 'バックアップを書き込みました: {0}',
    'noLocalBackup': 'ローカルバックアップがありません。先にバックアップを作成してください。',
    'restoreSuccess': '{0} 件の契約を復元しました。',
    'restoreFailed': '復元に失敗しました: {0}',
    'privacyBody': '書き出さない限りデータはこの端末に残ります。カード番号（下4桁以外）、CVV、パスワードは保存しません。',
    'termsBody': 'ローカル優先のサブスク台帳です。第三者ブランドの商標は各権利者に帰属します。',
    'notificationsBody': '更新・トライアル・プロモ・解約期限・価格変更・年次更新は端末内通知を使用します。ネットワークは不要です。',
    'current': '現在',
    'newValue': '変更後',
    'saveLabel': '節約',
    'simCancel': '解約して比較',
    'perMonth': '／月',
    'perYear': '／年',
    'addMethod': '支払い方法を追加',
    'expiry': '有効期限',
    'saveTotal': '合計予算を保存',
    'categoryBudgets': 'カテゴリ予算',
    'monthlyTotalBudget': '月次合計予算',
    'usesPerMonth': '月あたり利用回数',
    'officialWebsite': '公式サイト',
    'manageSubscription': '契約を管理',
    'subscriptionNotFound': '契約が見つかりません。',
    'manualRateSaved': '手動レートを保存: 1 USD = {0} {1}',
    'accountOptionalNote': '任意の身分連携。Guest でもオフラインで完全に使えます。',
    'customProfileTitle': 'カスタムプロファイル',
    'totalSpent': '年間支出合計',
    'mostExpensive': '最大支出',
    'biggestIncrease': '最大月額',
    'cancelledCount': '解約済み',
    'foreignSpend': '外貨支出',
  };

  String t(String key) {
    final code = locale.languageCode;
    final map = switch (code) {
      'zh' => _zh,
      'ja' => _ja,
      _ => _en,
    };
    return map[key] ?? _en[key] ?? key;
  }

  String _fmt(String key, List<String> args) {
    var s = t(key);
    for (var i = 0; i < args.length; i++) {
      s = s.replaceAll('{$i}', args[i]);
    }
    return s;
  }

  String get appTagline => t('appTagline');
  String get language => t('language');
  String get languageSystem => t('languageSystem');
  String get languageEn => t('languageEn');
  String get languageZh => t('languageZh');
  String get languageJa => t('languageJa');
  String get settings => t('settings');
  String get profiles => t('profiles');
  String get appearance => t('appearance');
  String get currency => t('currency');
  String get notifications => t('notifications');
  String get security => t('security');
  String get account => t('account');
  String get data => t('data');
  String get about => t('about');
  String get navHome => t('navHome');
  String get navSubs => t('navSubs');
  String get navData => t('navData');
  String get navCal => t('navCal');
  String get controlCenter => t('controlCenter');
  String get monthlyLoad => t('monthlyLoad');
  String get yearForecast => t('yearForecast');
  String get actionRequired => t('actionRequired');
  String get upcomingPayments => t('upcomingPayments');
  String get noUrgentDeadlines => t('noUrgentDeadlines');
  String get subscriptions => t('subscriptions');
  String get noSubscriptions => t('noSubscriptions');
  String get noSubscriptionsBody => t('noSubscriptionsBody');
  String get addSubscription => t('addSubscription');
  String get addSubscriptionTitle => t('addSubscriptionTitle');
  String get search => t('search');
  String get calendar => t('calendar');
  String get noEvents => t('noEvents');
  String get noEventsBody => t('noEventsBody');
  String get continueGoogle => t('continueGoogle');
  String get continueLine => t('continueLine');
  String get continueLocally => t('continueLocally');
  String get loginLead => t('loginLead');
  String get loginOptionalHint => t('loginOptionalHint');
  String get loginFooter => t('loginFooter');
  String get next => t('next');
  String get getStarted => t('getStarted');
  String get onboard1a => t('onboard1a');
  String get onboard1b => t('onboard1b');
  String get onboard2a => t('onboard2a');
  String get onboard2b => t('onboard2b');
  String get onboard3a => t('onboard3a');
  String get onboard3b => t('onboard3b');
  String get locked => t('locked');
  String get unlock => t('unlock');
  String get reduceMotion => t('reduceMotion');
  String get biometricLock => t('biometricLock');
  String get hideAmounts => t('hideAmounts');
  String get updateRates => t('updateRates');
  String get manualFx => t('manualFx');
  String get manualFxSubtitle => t('manualFxSubtitle');
  String get exportJson => t('exportJson');
  String get exportCsv => t('exportCsv');
  String get backup => t('backup');
  String get restoreBackup => t('restoreBackup');
  String get restorePaste => t('restorePaste');
  String get restoreConfirmTitle => t('restoreConfirmTitle');
  String get restoreConfirmBody => t('restoreConfirmBody');
  String get overwriteRestore => t('overwriteRestore');
  String get cancel => t('cancel');
  String get save => t('save');
  String get create => t('create');
  String get continueAction => t('continueAction');
  String get loadDemo => t('loadDemo');
  String get clearDemo => t('clearDemo');
  String get paymentMethods => t('paymentMethods');
  String get budget => t('budget');
  String get allProfiles => t('allProfiles');
  String get addCustomProfile => t('addCustomProfile');
  String get foreign => t('foreign');
  String get actionRequiredCount => t('actionRequiredCount');
  String get activeCount => t('activeCount');
  String get overBudget => t('overBudget');
  String get detail => t('detail');
  String get currentPrice => t('currentPrice');
  String get priceGraph => t('priceGraph');
  String get paymentHistory => t('paymentHistory');
  String get eventHistory => t('eventHistory');
  String get recordPayment => t('recordPayment');
  String get noPaymentsYet => t('noPaymentsYet');
  String get cancelKeepHistory => t('cancelKeepHistory');
  String get renewalIntent => t('renewalIntent');
  String get usage => t('usage');
  String get profile => t('profile');
  String get monthlyCost => t('monthlyCost');
  String get annualForecast => t('annualForecast');
  String get categorySpending => t('categorySpending');
  String get trend12 => t('trend12');
  String get whatIf => t('whatIf');
  String get selectService => t('selectService');
  String get customSubscription => t('customSubscription');
  String get selectPlan => t('selectPlan');
  String get billing => t('billing');
  String get reminder => t('reminder');
  String get back => t('back');
  String get connected => t('connected');
  String get notConnected => t('notConnected');
  String get link => t('link');
  String get version => t('version');
  String get privacy => t('privacy');
  String get terms => t('terms');
  String get total => t('total');
  String get cancelledSavings => t('cancelledSavings');
  String get yearInReview => t('yearInReview');
  String get allCats => t('allCats');
  String stepOf(int step, int total) => _fmt('stepOf', ['$step', '$total']);
  String get noSuggestedPlans => t('noSuggestedPlans');
  String get startDate => t('startDate');
  String get nextBillingDate => t('nextBillingDate');
  String get foreignFee => t('foreignFee');
  String get estimatedCharge => t('estimatedCharge');
  String get lastUpdated => t('lastUpdated');
  String get ratesUpdated => t('ratesUpdated');
  String get usingLastKnownRate => t('usingLastKnownRate');
  String foreignFeeOption(String pct) => _fmt('foreignFeeOption', [pct]);
  String get sync => t('sync');
  String backupWritten(String path) => _fmt('backupWritten', [path]);
  String get noLocalBackup => t('noLocalBackup');
  String restoreSuccess(int count) => _fmt('restoreSuccess', ['$count']);
  String restoreFailed(String err) => _fmt('restoreFailed', [err]);
  String get privacyBody => t('privacyBody');
  String get termsBody => t('termsBody');
  String get notificationsBody => t('notificationsBody');
  String get current => t('current');
  String get newValue => t('newValue');
  String get saveLabel => t('saveLabel');
  String get simCancel => t('simCancel');
  String get perMonth => t('perMonth');
  String get perYear => t('perYear');
  String get addMethod => t('addMethod');
  String get expiry => t('expiry');
  String get saveTotal => t('saveTotal');
  String get categoryBudgets => t('categoryBudgets');
  String get monthlyTotalBudget => t('monthlyTotalBudget');
  String get usesPerMonth => t('usesPerMonth');
  String get officialWebsite => t('officialWebsite');
  String get manageSubscription => t('manageSubscription');
  String get subscriptionNotFound => t('subscriptionNotFound');
  String manualRateSaved(String value, String code) => _fmt('manualRateSaved', [value, code]);
  String get accountOptionalNote => t('accountOptionalNote');
  String get customProfileTitle => t('customProfileTitle');
  String get totalSpent => t('totalSpent');
  String get mostExpensive => t('mostExpensive');
  String get biggestIncrease => t('biggestIncrease');
  String get cancelledCount => t('cancelledCount');
  String get foreignSpend => t('foreignSpend');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'zh', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
