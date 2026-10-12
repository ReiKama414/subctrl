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
    'continueGoogle': 'Continue with Google',
    'continueLine': 'Continue with LINE',
    'continueLocally': 'Continue locally',
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
    'continueGoogle': '使用 Google 繼續',
    'continueLine': '使用 LINE 繼續',
    'continueLocally': '本機繼續使用',
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
    'continueGoogle': 'Google で続行',
    'continueLine': 'LINE で続行',
    'continueLocally': 'ローカルで続行',
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
