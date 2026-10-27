import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:subctrl/core/constants/enums.dart';

export 'enum_l10n.dart';

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
    'deleteSubscription': 'Delete subscription',
    'deleteSubscriptionBody': 'Permanently remove "{0}" and all its history on this device?',
    'editSubscription': 'Edit subscription',
    'planName': 'Plan name',
    'notes': 'Notes',
    'pricePhases': 'Price phases',
    'addPhase': 'Add phase',
    'editPhase': 'Edit phase',
    'regularPriceAfterOffer': 'Regular price after offer',
    'promoName': 'Promotion name',
    'regularPriceRequired': 'Enter the regular price (after trial / promo)',
    'selectProfileForSub': 'Profile for this subscription',
    'notificationsEnabled': 'Subscription reminders',
    'cloudAutoDownload': 'Download cloud backup when signing in',
    'cloudAutoUpload': 'Upload after subscription changes',
    'statusTitle': 'Status',
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
    'deleteCustomService': 'Delete custom service',
    'deleteCustomServiceBody': 'Remove this custom service from the list? Built-in services cannot be deleted.',
    'customServiceInUse': 'This service is used by a subscription and cannot be deleted.',
    'customNameRequired': 'Enter a service name',
    'purgeCustomDone': 'Removed {0} unused custom services',
    'selectPlan': 'SELECT PLAN',
    'billing': 'BILLING',
    'reminder': 'REMINDER',
    'back': 'BACK',
    'connected': 'Connected',
    'notConnected': 'Not connected',
    'link': 'Link',
    'version': 'Version',
    'author': 'Author',
    'authorSite': 'Website',
    'authorGithub': 'GitHub',
    'privacy': 'Privacy',
    'terms': 'Terms',
    'total': 'TOTAL',
    'cancelledSavings': 'Cancelled savings / month',
    'yearInReview': 'Year in review',
    'allCats': 'ALL CATS',
    'stepOf': 'STEP {0} / {1}',
    'noSuggestedPlans': 'No suggested plans. Enter your actual price below.',
    'planPriceHint': 'Catalogue prices are suggestions — enter what you actually pay (promos OK).',
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
    'allProfilesShort': 'ALL',
    'profilePersonal': 'Personal',
    'profileWork': 'Work',
    'profileFamily': 'Family',
    'providerGoogle': 'Google',
    'providerLine': 'LINE',
    'providerGuest': 'Guest',
    'customThemeHelp': 'CUSTOM uses VOID as the base. Accent / background / surface / border persist as JSON.',
    'weekdaySun': 'S',
    'weekdayMon': 'M',
    'weekdayTue': 'T',
    'weekdayWed': 'W',
    'weekdayThu': 'T',
    'weekdayFri': 'F',
    'weekdaySat': 'S',
    'syncLocalOnly': 'Local-only. Sign in with Google to enable cloud backup.',
    'syncReady': 'Cloud backup ready.',
    'cloudUpload': 'Upload backup to cloud',
    'cloudDownload': 'Restore from cloud backup',
    'syncNeedLogin': 'Sign in with Google first to use cloud backup.',
    'syncUploaded': 'Cloud backup uploaded.',
    'syncDownloaded': 'Cloud backup downloaded.',
    'syncNoCloudBackup': 'No cloud backup found for this account.',
    'themeVoid': 'Void',
    'themeTerminal': 'Terminal',
    'themeAkira': 'Akira',
    'themeIce': 'Ice',
    'themeLight': 'Light',
    'themeNoir': 'Noir',
    'themeSakura': 'Sakura',
    'themeMacaron': 'Macaron',
    'themeCustom': 'Custom',
    'customThemeAccent': 'Accent',
    'customThemeBackground': 'Background',
    'customThemeSurface': 'Surface',
    'customThemeBorder': 'Border',
    'customThemeChannelRed': 'Red',
    'customThemeChannelGreen': 'Green',
    'customThemeChannelBlue': 'Blue',
    'notificationPermissionTitle': 'Turn on notifications?',
    'notificationPermissionBody': 'SUB//CTRL can remind you before renewals and preorder arrivals.',
    'notNow': 'Not now',
    'enableNotifications': 'Enable',
    'jumpToToday': 'Jump to today',
    'pickYearMonth': 'Pick year & month',
    'ordersSearchHint': 'Search orders',
    'ordersFilterAll': 'All',
    'ordersFilterPending': 'Pending',
    'ordersFilterOverdue': 'Overdue',
    'orderKindPreorder': 'Preorder',
    'orderKindInstock': 'In stock',
    'orderKindProxy': 'Proxy buy',
    'orderTimeline': 'Timeline',
    'orderNextStep': 'Advance status',
    'editOrder': 'Edit order',
    'depositPaid': 'Deposit paid',
    'balanceDue': 'Balance due',
    'shippingFee': 'Shipping',
    'serviceFee': 'Service fee',
    'sellerName': 'Seller',
    'orderNumber': 'Order no.',
    'trackingNumber': 'Tracking no.',
    'forwarder': 'Forwarder',
    'paymentNote': 'Payment note',
    'eventOrderExpected': 'Expected arrival',
    'eventOrderReminder': 'Order reminder',
    'eventOrderDelivered': 'Delivered',
    'securityBiometricHint': 'Requires fingerprint / Face ID when opening the app.',
    'securityHideAmountsHint': 'Masks prices on home, lists, and calendar.',
    'statusActive': 'Active',
    'statusTrial': 'Trial',
    'statusPromo': 'Promo',
    'statusCancelled': 'Cancelled',
    'statusExpired': 'Expired',
    'statusPaused': 'Paused',
    'intentKeep': 'Keep',
    'intentReview': 'Review',
    'intentCancel': 'Cancel',
    'intentUndecided': 'Undecided',
    'usageDaily': 'Daily',
    'usageWeekly': 'Weekly',
    'usageMonthly': 'Monthly',
    'usageRarely': 'Rarely',
    'usageNotUsing': 'Not using',
    'cycleDaily': 'Daily',
    'cycleWeekly': 'Weekly',
    'cycleMonthly': 'Monthly',
    'cycleQuarterly': 'Quarterly',
    'cycleSemiannual': 'Every 6 months',
    'cycleYearly': 'Yearly',
    'cycleCustom': 'Custom',
    'phaseFree': 'Free',
    'phasePromo': 'Promo',
    'phaseRegular': 'Regular',
    'phaseCustom': 'Custom',
    'filterAll': 'All',
    'filterActive': 'Active',
    'filterTrial': 'Trial',
    'filterPromo': 'Promo',
    'filterCancelled': 'Cancelled',
    'filterExpired': 'Expired',
    'sortNextBilling': 'Next billing',
    'sortPrice': 'Price',
    'sortCategory': 'Category',
    'sortName': 'Name',
    'sortRecentlyAdded': 'Recently added',
    'sortStatusActiveFirst': 'Active first',
    'sortRenewalUrgency': 'Renewal urgency',
    'catAi': 'AI',
    'catVideo': 'Video',
    'catMusic': 'Music',
    'catGaming': 'Gaming',
    'catDelivery': 'Delivery',
    'catSoftware': 'Software',
    'catCloud': 'Cloud',
    'catSocial': 'Social',
    'catDating': 'Dating',
    'catShopping': 'Shopping',
    'catEducation': 'Education',
    'catFitness': 'Fitness',
    'catVpn': 'VPN',
    'catNews': 'News',
    'catDeveloper': 'Developer',
    'catOther': 'Other',
    'chart3m': '3M',
    'chart6m': '6M',
    'chart1y': '1Y',
    'chartAll': 'All',
    'chartNoHistory': 'Not enough price history for a chart yet.',
    'chartLegend': 'Official / Regular  ·  My actual cost',
    'eventPayment': 'Payment',
    'eventPromoEnd': 'Promo end',
    'eventTrialEnd': 'Trial end',
    'eventCancelDeadline': 'Cancel deadline',
    'eventPriceChange': 'Price change',
    'eventExpiry': 'Expiry',
    'payVisa': 'Visa',
    'payMastercard': 'Mastercard',
    'payAmex': 'Amex',
    'payApple': 'Apple',
    'payGooglePlay': 'Google Play',
    'payPaypal': 'PayPal',
    'payOther': 'Other',
    'labelNextBilling': 'Next billing',
    'labelTrialEnd': 'Trial end',
    'labelPromoEnd': 'Promo end',
    'labelCancelDeadline': 'Cancel deadline',
    'labelMyReminder': 'My reminder',
    'labelFirstCharge': 'First charge',
    'labelAccessUntil': 'Access until',
    'daysRemaining': '{0} days remaining',
    'autoRenew': 'Auto renew',
    'manualRenew': 'Manual',
    'last4': 'Last 4 digits',
    'offerNone': 'No offer',
    'offerFreePeriod': 'Free period / trial',
    'offerDiscount': 'Discount',
    'offerMultiStage': 'Multi-stage price',
    'offerCustom': 'Custom offer',
    'freeDays7': '7 days free',
    'freeDays14': '14 days free',
    'freeDays30': '30 days free',
    'freeDays60': '2 months free',
    'freeDays90': '3 months free',
    'freeDays180': '6 months free',
    'freeDays365': '1 year free',
    'freeDaysCustom': 'Free until a date',
    'offerAfterFree': 'Free until {0}, then {1} / {2}',
    'offerFreeKeepsRegular': 'The regular cycle stays the same. After the free period you can keep paying the original price.',
    'promoPrice': 'Promotional price',
    'reminderDays30': '30 days before',
    'reminderDays14': '14 days before',
    'reminderDays7': '7 days before',
    'reminderDays3': '3 days before',
    'reminderDays1': '1 day before',
    'reminderSameDay': 'Same day',
    'reminderCustom': 'Custom',
    'actionFreePeriod': 'Free period ending',
    'actionPriceReview': 'Adjust the price?',
    'priceReviewFreeBody': 'The free period has ended. Continue at {0} / {1}, or enter a new amount.',
    'priceReviewPromoBody': 'The promotion has ended. Continue at {0} / {1}, or enter a new amount.',
    'priceReviewLater': 'Later',
    'priceReviewConfirm': 'Confirm',
    'eventPriceReviewed': 'Price reviewed',
    'actionPromoEnds': 'Promo ending',
    'actionCancelDeadline': 'Cancel deadline',
    'actionRenews': 'Renews {0}',
    'actionFirstCharge': 'First charge',
    'actionCardExpiry': 'Payment method expiry',
    'actionDaysLeft': '{0} days left',
    'actionDays': '{0} days',
    'actionAfterTrial': 'After trial: {0} / {1}',
    'actionCancelBy': 'Cancel by: {0}',
    'actionCurrent': 'Current: {0}',
    'actionAfter': 'After: {0}',
    'actionReminder': 'Reminder: {0}',
    'eventCreated': 'Created',
    'eventPlanChanged': 'Plan changed',
    'eventPriceChanged': 'Price changed',
    'eventPromoStarted': 'Promo started',
    'eventPromoEnded': 'Promo ended',
    'eventTrialStarted': 'Trial started',
    'eventTrialEnded': 'Trial ended',
    'eventRenewed': 'Renewed',
    'eventPaused': 'Paused',
    'eventResumed': 'Resumed',
    'eventCancelRequested': 'Cancel requested',
    'eventCancelled': 'Cancelled',
    'eventExpired': 'Expired',
    'eventReactivated': 'Reactivated',
    'paymentLabel': 'Payment',
    'accessUntilDetail': 'Access until {0}',
    'lineWebUnsupported': 'LINE login is available on Android / iOS only. Use Google or Guest on the web.',
    'firestoreSetupHint': 'Enable Firestore in Firebase Console and paste the rules from README / firestore.rules.',
    'orders': 'ORDERS',
    'addOrder': '+ ADD ORDER',
    'addOrderTitle': 'ADD ORDER / PREORDER',
    'addOrderSubtitle': 'Shop & marketplace purchases',
    'noOrders': 'NO ORDERS',
    'noOrdersBody': 'Track Taobao, PLUSHSHOP, and other shop orders here so you do not forget pending deliveries.',
    'pendingOrders': 'PENDING / PREORDER',
    'completedOrders': 'COMPLETED',
    'pendingOrdersCount': '{0} pending',
    'orderItem': 'ITEM',
    'orderItemHint': 'e.g. Plush doll A',
    'platform': 'PLATFORM / SHOP',
    'platformCustomHint': 'Custom shop name',
    'purchaseStatus': 'STATUS',
    'orderedAt': 'Ordered',
    'expectedAt': 'Expected',
    'expectedAtOptional': 'Expected date (optional)',
    'deliveredAt': 'Delivered',
    'quantity': 'QUANTITY',
    'priceOptional': 'Price (optional)',
    'trackingUrlOptional': 'Tracking / order URL (optional)',
    'notesOptional': 'Notes (optional)',
    'orderDetail': 'ORDER',
    'orderNotFound': 'Order not found.',
    'openTracking': 'Open tracking / order page',
    'updateStatus': 'UPDATE STATUS',
    'deleteOrder': 'Delete order',
    'deleteOrderBody': 'Remove this order from your list?',
    'viewAll': 'VIEW ALL',
    'noPendingOrders': 'No pending preorders or shipments.',
    'subscriptionsTracked': 'SUBSCRIPTIONS',
    'pendingPreorders': 'PENDING ORDERS',
    'purchaseOrdered': 'Ordered',
    'purchasePreorder': 'Preorder',
    'purchaseAwaitingShipment': 'Awaiting shipment',
    'purchaseShipped': 'Shipped',
    'purchaseDelivered': 'Delivered',
    'purchaseCancelled': 'Cancelled',
    'greetingMorning': 'Good morning',
    'greetingAfternoon': 'Good afternoon',
    'greetingEvening': 'Good evening',
    'quickOrders': 'Orders',
    'activeSubsCount': '{0} active',
    'budgetUsage': '{0} of budget used',
    'dueToday': 'Today',
    'dueTomorrow': 'Tomorrow',
    'dueInDays': 'In {0} days',
    'spendingBreakdown': 'Spending breakdown',
    'quickAdd': 'Add',
    'quickSimulate': 'What-if',
    'quickReview': 'Review',
    'noUpcoming': 'No upcoming payments.',
    'allCaughtUp': 'All caught up — nothing needs attention.',
    'filterSort': 'Filter & sort',
    'sortBy': 'Sort by',
    'categoryTitle': 'Category',
    'monthTotal': 'Month total',
    'eventsCount': '{0} events',
    'tools': 'Tools',
    'createNew': 'Create',
    'insights': 'Insights',
    'resetFilters': 'Reset',
    'subsSummary': '{0} subscriptions',
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
    'deleteSubscription': '刪除訂閱',
    'deleteSubscriptionBody': '要永久移除「{0}」及本機所有相關紀錄嗎？',
    'editSubscription': '編輯訂閱',
    'planName': '方案名稱',
    'notes': '備註',
    'pricePhases': '價格階段',
    'addPhase': '新增階段',
    'editPhase': '編輯階段',
    'regularPriceAfterOffer': '優惠結束後牌價',
    'promoName': '優惠名稱',
    'regularPriceRequired': '請輸入正常價格（試用／優惠結束後）',
    'selectProfileForSub': '此訂閱所屬檔案',
    'notificationsEnabled': '訂閱提醒通知',
    'cloudAutoDownload': '登入時下載雲端備份',
    'cloudAutoUpload': '變更訂閱後自動上傳',
    'statusTitle': '狀態',
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
    'deleteCustomService': '刪除自訂服務',
    'deleteCustomServiceBody': '要從清單移除此自訂服務嗎？系統預設服務無法刪除。',
    'customServiceInUse': '此服務仍有訂閱使用中，無法刪除。',
    'customNameRequired': '請輸入服務名稱',
    'purgeCustomDone': '已清除 {0} 個未使用的自訂服務',
    'selectPlan': '選擇方案',
    'billing': '計費',
    'reminder': '提醒',
    'back': '返回',
    'connected': '已連結',
    'notConnected': '未連結',
    'link': '連結',
    'version': '版本',
    'author': '作者',
    'authorSite': '個人網站',
    'authorGithub': 'GitHub',
    'privacy': '隱私',
    'terms': '條款',
    'total': '合計',
    'cancelledSavings': '已取消節省／月',
    'yearInReview': '年度回顧',
    'allCats': '全部分類',
    'stepOf': '步驟 {0} / {1}',
    'noSuggestedPlans': '沒有建議方案，請在下方輸入實際價格。',
    'planPriceHint': '目錄價僅供參考，請輸入你實際支付的金額（優惠價也可）。',
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
    'allProfilesShort': '全部',
    'profilePersonal': '個人',
    'profileWork': '工作',
    'profileFamily': '家庭',
    'providerGoogle': 'Google',
    'providerLine': 'LINE',
    'providerGuest': '訪客',
    'customThemeHelp': '點選色塊可調整強調色與背景層級，變更會即時套用',
    'weekdaySun': '日',
    'weekdayMon': '一',
    'weekdayTue': '二',
    'weekdayWed': '三',
    'weekdayThu': '四',
    'weekdayFri': '五',
    'weekdaySat': '六',
    'syncLocalOnly': '僅本機。以 Google 登入後可使用雲端備份。',
    'syncReady': '雲端備份已就緒。',
    'cloudUpload': '上傳備份到雲端',
    'cloudDownload': '從雲端備份還原',
    'syncNeedLogin': '請先以 Google 登入才能使用雲端備份。',
    'syncUploaded': '雲端備份已上傳。',
    'syncDownloaded': '已下載雲端備份。',
    'syncNoCloudBackup': '此帳號尚無雲端備份。',
    'themeVoid': '虛空',
    'themeTerminal': '終端',
    'themeAkira': 'Akira',
    'themeIce': '冰晶',
    'themeLight': '明亮',
    'themeNoir': '黑紫',
    'themeSakura': '櫻花',
    'themeMacaron': '馬卡龍',
    'themeCustom': '自訂',
    'customThemeAccent': '強調色',
    'customThemeBackground': '背景',
    'customThemeSurface': '表面',
    'customThemeBorder': '邊框',
    'customThemeChannelRed': '紅',
    'customThemeChannelGreen': '綠',
    'customThemeChannelBlue': '藍',
    'notificationPermissionTitle': '開啟通知？',
    'notificationPermissionBody': '可在續訂扣款與預購到貨前提醒你',
    'notNow': '稍後',
    'enableNotifications': '開啟',
    'jumpToToday': '回到今天',
    'pickYearMonth': '選擇年月',
    'ordersSearchHint': '搜尋訂單',
    'ordersFilterAll': '全部',
    'ordersFilterPending': '待收',
    'ordersFilterOverdue': '逾期',
    'orderKindPreorder': '預購',
    'orderKindInstock': '現貨',
    'orderKindProxy': '代購',
    'orderTimeline': '時間軸',
    'orderNextStep': '推進狀態',
    'editOrder': '編輯訂單',
    'depositPaid': '已付訂金',
    'balanceDue': '待付尾款',
    'shippingFee': '運費',
    'serviceFee': '服務費',
    'sellerName': '賣家',
    'orderNumber': '訂單編號',
    'trackingNumber': '物流單號',
    'forwarder': '集運商',
    'paymentNote': '付款備註',
    'eventOrderExpected': '預計到貨',
    'eventOrderReminder': '訂單提醒',
    'eventOrderDelivered': '已收貨',
    'securityBiometricHint': '開啟 App 時需指紋或 Face ID',
    'securityHideAmountsHint': '首頁、列表與日曆的金額會顯示為 ••••',
    'statusActive': '進行中',
    'statusTrial': '試用',
    'statusPromo': '優惠',
    'statusCancelled': '已取消',
    'statusExpired': '已到期',
    'statusPaused': '已暫停',
    'intentKeep': '續訂',
    'intentReview': '再評估',
    'intentCancel': '取消',
    'intentUndecided': '未決定',
    'usageDaily': '每天',
    'usageWeekly': '每週',
    'usageMonthly': '每月',
    'usageRarely': '很少用',
    'usageNotUsing': '未使用',
    'cycleDaily': '日繳',
    'cycleWeekly': '週繳',
    'cycleMonthly': '月繳',
    'cycleQuarterly': '季繳',
    'cycleSemiannual': '半年繳',
    'cycleYearly': '年繳',
    'cycleCustom': '自訂',
    'phaseFree': '免費',
    'phasePromo': '優惠',
    'phaseRegular': '一般',
    'phaseCustom': '自訂',
    'filterAll': '全部',
    'filterActive': '進行中',
    'filterTrial': '試用',
    'filterPromo': '優惠',
    'filterCancelled': '已取消',
    'filterExpired': '已到期',
    'sortNextBilling': '下次扣款',
    'sortPrice': '價格',
    'sortCategory': '分類',
    'sortName': '名稱',
    'sortRecentlyAdded': '最近新增',
    'sortStatusActiveFirst': '有效優先',
    'sortRenewalUrgency': '續訂急迫',
    'catAi': 'AI',
    'catVideo': '影音',
    'catMusic': '音樂',
    'catGaming': '遊戲',
    'catDelivery': '外送',
    'catSoftware': '軟體',
    'catCloud': '雲端',
    'catSocial': '社群',
    'catDating': '交友',
    'catShopping': '購物',
    'catEducation': '教育',
    'catFitness': '健身／健康',
    'catVpn': 'VPN',
    'catNews': '新聞',
    'catDeveloper': '開發',
    'catOther': '其他',
    'chart3m': '3個月',
    'chart6m': '6個月',
    'chart1y': '1年',
    'chartAll': '全部',
    'chartNoHistory': '價格紀錄不足，尚無法繪製圖表。',
    'chartLegend': '官方／一般價  ·  我的實際花費',
    'eventPayment': '付款',
    'eventPromoEnd': '優惠結束',
    'eventTrialEnd': '試用結束',
    'eventCancelDeadline': '取消期限',
    'eventPriceChange': '價格變動',
    'eventExpiry': '到期',
    'payVisa': 'Visa',
    'payMastercard': 'Mastercard',
    'payAmex': 'Amex',
    'payApple': 'Apple',
    'payGooglePlay': 'Google Play',
    'payPaypal': 'PayPal',
    'payOther': '其他',
    'labelNextBilling': '下次扣款',
    'labelTrialEnd': '試用結束',
    'labelPromoEnd': '優惠結束',
    'labelCancelDeadline': '取消期限',
    'labelMyReminder': '我的提醒',
    'labelFirstCharge': '首次扣款',
    'labelAccessUntil': '可用至',
    'daysRemaining': '剩餘 {0} 天',
    'autoRenew': '自動續訂',
    'manualRenew': '手動',
    'last4': '卡號末四碼',
    'offerNone': '無優惠',
    'offerFreePeriod': '免費試用期',
    'offerDiscount': '折扣優惠',
    'offerMultiStage': '多階段價格',
    'offerCustom': '自訂優惠',
    'freeDays7': '免費 7 天',
    'freeDays14': '免費 14 天',
    'freeDays30': '免費 30 天',
    'freeDays60': '免費 2 個月',
    'freeDays90': '免費 3 個月',
    'freeDays180': '免費 6 個月',
    'freeDays365': '免費 1 年',
    'freeDaysCustom': '免費至指定日期',
    'offerAfterFree': '免費至 {0}，之後 {1}／{2}',
    'offerFreeKeepsRegular': '計費週期維持不變。免費期結束後可依原價繼續訂閱。',
    'promoPrice': '優惠價格',
    'reminderDays30': '提前 30 天',
    'reminderDays14': '提前 14 天',
    'reminderDays7': '提前 7 天',
    'reminderDays3': '提前 3 天',
    'reminderDays1': '提前 1 天',
    'reminderSameDay': '當天',
    'reminderCustom': '自訂',
    'actionFreePeriod': '免費期即將結束',
    'actionPriceReview': '是否需要調整價格？',
    'priceReviewFreeBody': '免費期已結束。將依 {0}／{1} 續訂，若實際價格不同請在下方修改。',
    'priceReviewPromoBody': '優惠已結束。將依 {0}／{1} 續訂，若實際價格不同請在下方修改。',
    'priceReviewLater': '稍後',
    'priceReviewConfirm': '確認',
    'eventPriceReviewed': '已確認價格',
    'actionPromoEnds': '優惠即將結束',
    'actionCancelDeadline': '取消期限',
    'actionRenews': '{0} 續訂',
    'actionFirstCharge': '首次扣款',
    'actionCardExpiry': '付款方式到期',
    'actionDaysLeft': '剩 {0} 天',
    'actionDays': '{0} 天',
    'actionAfterTrial': '試用後：{0}／{1}',
    'actionCancelBy': '請於 {0} 前取消',
    'actionCurrent': '目前：{0}',
    'actionAfter': '之後：{0}',
    'actionReminder': '提醒：{0}',
    'eventCreated': '已建立',
    'eventPlanChanged': '方案變更',
    'eventPriceChanged': '價格變更',
    'eventPromoStarted': '優惠開始',
    'eventPromoEnded': '優惠結束',
    'eventTrialStarted': '試用開始',
    'eventTrialEnded': '試用結束',
    'eventRenewed': '已續訂',
    'eventPaused': '已暫停',
    'eventResumed': '已恢復',
    'eventCancelRequested': '已申請取消',
    'eventCancelled': '已取消',
    'eventExpired': '已到期',
    'eventReactivated': '已重新啟用',
    'paymentLabel': '付款',
    'accessUntilDetail': '可用至 {0}',
    'lineWebUnsupported': 'LINE 登入僅支援 Android／iOS。網頁請用 Google 或訪客。',
    'firestoreSetupHint': '請在 Firebase Console 啟用 Firestore，並套用 README／firestore.rules 中的規則。',
    'orders': '訂單／預購',
    'addOrder': '+ 新增訂單',
    'addOrderTitle': '新增訂單／預購',
    'addOrderSubtitle': '商店與平台購買進度',
    'noOrders': '尚無訂單',
    'noOrdersBody': '可追蹤淘寶、PLUSHSHOP 等商店訂單，避免忘記預購與出貨進度。',
    'pendingOrders': '待收／預購中',
    'completedOrders': '已完成',
    'pendingOrdersCount': '待處理 {0} 筆',
    'orderItem': '品項',
    'orderItemHint': '例如：娃娃 A',
    'platform': '平台／商店',
    'platformCustomHint': '自訂商店名稱',
    'purchaseStatus': '狀態',
    'orderedAt': '下單日',
    'expectedAt': '預計到貨',
    'expectedAtOptional': '預計到貨（選填）',
    'deliveredAt': '已到貨',
    'quantity': '數量',
    'priceOptional': '價格（選填）',
    'trackingUrlOptional': '追蹤／訂單連結（選填）',
    'notesOptional': '備註（選填）',
    'orderDetail': '訂單明細',
    'orderNotFound': '找不到此訂單。',
    'openTracking': '開啟追蹤／訂單頁',
    'updateStatus': '更新狀態',
    'deleteOrder': '刪除訂單',
    'deleteOrderBody': '要從清單移除此訂單嗎？',
    'viewAll': '查看全部',
    'noPendingOrders': '目前沒有待收或預購中的品項。',
    'subscriptionsTracked': '訂閱中',
    'pendingPreorders': '待收／預購',
    'purchaseOrdered': '已下單',
    'purchasePreorder': '預購中',
    'purchaseAwaitingShipment': '待出貨',
    'purchaseShipped': '已出貨',
    'purchaseDelivered': '已到貨',
    'purchaseCancelled': '已取消',
    'greetingMorning': '早安',
    'greetingAfternoon': '午安',
    'greetingEvening': '晚安',
    'quickOrders': '訂單',
    'activeSubsCount': '{0} 個訂閱中',
    'budgetUsage': '已使用預算 {0}',
    'dueToday': '今天',
    'dueTomorrow': '明天',
    'dueInDays': '{0} 天後',
    'spendingBreakdown': '支出分布',
    'quickAdd': '新增',
    'quickSimulate': '試算',
    'quickReview': '回顧',
    'noUpcoming': '近期沒有扣款。',
    'allCaughtUp': '一切都在掌控中，目前沒有待處理事項。',
    'filterSort': '篩選與排序',
    'sortBy': '排序方式',
    'categoryTitle': '分類',
    'monthTotal': '本月合計',
    'eventsCount': '{0} 筆事件',
    'tools': '工具',
    'createNew': '新增',
    'insights': '洞察',
    'resetFilters': '重設',
    'subsSummary': '共 {0} 個訂閱',
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
    'deleteSubscription': 'サブスクを削除',
    'deleteSubscriptionBody': '「{0}」とこの端末の履歴を完全に削除しますか？',
    'editSubscription': 'サブスクを編集',
    'planName': 'プラン名',
    'notes': 'メモ',
    'pricePhases': '価格フェーズ',
    'addPhase': 'フェーズを追加',
    'editPhase': 'フェーズを編集',
    'regularPriceAfterOffer': 'オファー後の通常価格',
    'promoName': 'プロモ名',
    'regularPriceRequired': '通常価格（トライアル／プロモ後）を入力',
    'selectProfileForSub': 'このサブスクのプロファイル',
    'notificationsEnabled': 'サブスクリマインダー',
    'cloudAutoDownload': 'サインイン時にクラウドから取得',
    'cloudAutoUpload': '変更後に自動アップロード',
    'statusTitle': 'ステータス',
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
    'deleteCustomService': 'カスタムサービスを削除',
    'deleteCustomServiceBody': 'このカスタムサービスを一覧から削除しますか？組み込みサービスは削除できません。',
    'customServiceInUse': 'このサービスは契約で使用中のため削除できません。',
    'customNameRequired': 'サービス名を入力してください',
    'purgeCustomDone': '未使用のカスタムサービスを {0} 件削除しました',
    'selectPlan': 'プランを選択',
    'billing': '請求',
    'reminder': 'リマインダー',
    'back': '戻る',
    'connected': '連携済み',
    'notConnected': '未連携',
    'link': '連携',
    'version': 'バージョン',
    'author': '作者',
    'authorSite': 'ウェブサイト',
    'authorGithub': 'GitHub',
    'privacy': 'プライバシー',
    'terms': '利用規約',
    'total': '合計',
    'cancelledSavings': '解約による節約／月',
    'yearInReview': '年間レビュー',
    'allCats': '全カテゴリ',
    'stepOf': 'ステップ {0} / {1}',
    'noSuggestedPlans': '提案プランはありません。下に実際の価格を入力してください。',
    'planPriceHint': 'カタログ価格は参考です。実際に支払う金額を入力してください（割引可）。',
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
    'allProfilesShort': 'すべて',
    'profilePersonal': '個人',
    'profileWork': '仕事',
    'profileFamily': '家族',
    'providerGoogle': 'Google',
    'providerLine': 'LINE',
    'providerGuest': 'ゲスト',
    'customThemeHelp': 'CUSTOM は VOID をベースにします。アクセント／背景／サーフェス／枠線は JSON で保持されます。',
    'weekdaySun': '日',
    'weekdayMon': '月',
    'weekdayTue': '火',
    'weekdayWed': '水',
    'weekdayThu': '木',
    'weekdayFri': '金',
    'weekdaySat': '土',
    'syncLocalOnly': 'ローカルのみ。Google でサインインするとクラウドバックアップが使えます。',
    'syncReady': 'クラウドバックアップの準備完了。',
    'cloudUpload': 'クラウドにバックアップをアップロード',
    'cloudDownload': 'クラウドバックアップから復元',
    'syncNeedLogin': 'クラウドバックアップには先に Google サインインが必要です。',
    'syncUploaded': 'クラウドバックアップをアップロードしました。',
    'syncDownloaded': 'クラウドバックアップをダウンロードしました。',
    'syncNoCloudBackup': 'このアカウントのクラウドバックアップはありません。',
    'themeVoid': 'Void',
    'themeTerminal': 'Terminal',
    'themeAkira': 'Akira',
    'themeIce': 'Ice',
    'themeLight': 'Light',
    'themeNoir': 'Noir',
    'themeSakura': 'Sakura',
    'themeMacaron': 'Macaron',
    'themeCustom': 'Custom',
    'customThemeAccent': 'Accent',
    'customThemeBackground': 'Background',
    'customThemeSurface': 'Surface',
    'customThemeBorder': 'Border',
    'customThemeChannelRed': 'Red',
    'customThemeChannelGreen': 'Green',
    'customThemeChannelBlue': 'Blue',
    'notificationPermissionTitle': '通知をオンにしますか？',
    'notificationPermissionBody': '更新や予約商品の到着前にリマインドできます。',
    'notNow': 'あとで',
    'enableNotifications': 'オン',
    'jumpToToday': '今日へ',
    'pickYearMonth': '年月を選択',
    'ordersSearchHint': '注文を検索',
    'ordersFilterAll': 'すべて',
    'ordersFilterPending': '未完了',
    'ordersFilterOverdue': '期限超過',
    'orderKindPreorder': '予約',
    'orderKindInstock': '在庫',
    'orderKindProxy': '代行購入',
    'orderTimeline': 'タイムライン',
    'orderNextStep': '次のステータス',
    'editOrder': '注文を編集',
    'depositPaid': '内金',
    'balanceDue': '残額',
    'shippingFee': '送料',
    'serviceFee': '手数料',
    'sellerName': '出品者',
    'orderNumber': '注文番号',
    'trackingNumber': '追跡番号',
    'forwarder': '転送業者',
    'paymentNote': '支払いメモ',
    'eventOrderExpected': '到着予定',
    'eventOrderReminder': '注文リマインド',
    'eventOrderDelivered': '受取済み',
    'securityBiometricHint': '起動時に生体認証が必要です。',
    'securityHideAmountsHint': '金額をマスク表示します。',
    'statusActive': '有効',
    'statusTrial': 'トライアル',
    'statusPromo': 'プロモ',
    'statusCancelled': '解約済み',
    'statusExpired': '期限切れ',
    'statusPaused': '一時停止',
    'intentKeep': '継続',
    'intentReview': '見直し',
    'intentCancel': '解約',
    'intentUndecided': '未定',
    'usageDaily': '毎日',
    'usageWeekly': '毎週',
    'usageMonthly': '毎月',
    'usageRarely': 'たまに',
    'usageNotUsing': '未使用',
    'cycleDaily': '日額',
    'cycleWeekly': '週額',
    'cycleMonthly': '月額',
    'cycleQuarterly': '四半期',
    'cycleSemiannual': '半年',
    'cycleYearly': '年額',
    'cycleCustom': 'カスタム',
    'phaseFree': '無料',
    'phasePromo': 'プロモ',
    'phaseRegular': '通常',
    'phaseCustom': 'カスタム',
    'filterAll': 'すべて',
    'filterActive': '有効',
    'filterTrial': 'トライアル',
    'filterPromo': 'プロモ',
    'filterCancelled': '解約',
    'filterExpired': '期限切れ',
    'sortNextBilling': '次回請求',
    'sortPrice': '価格',
    'sortCategory': 'カテゴリ',
    'sortName': '名前',
    'sortRecentlyAdded': '最近追加',
    'sortStatusActiveFirst': '有効を先に',
    'sortRenewalUrgency': '更新の緊急度',
    'catAi': 'AI',
    'catVideo': '動画',
    'catMusic': '音楽',
    'catGaming': 'ゲーム',
    'catDelivery': 'デリバリー',
    'catSoftware': 'ソフト',
    'catCloud': 'クラウド',
    'catSocial': 'ソーシャル',
    'catDating': '出会い',
    'catShopping': 'ショッピング',
    'catEducation': '教育',
    'catFitness': 'フィットネス',
    'catVpn': 'VPN',
    'catNews': 'ニュース',
    'catDeveloper': '開発',
    'catOther': 'その他',
    'chart3m': '3か月',
    'chart6m': '6か月',
    'chart1y': '1年',
    'chartAll': 'すべて',
    'chartNoHistory': '価格履歴が足りず、グラフを表示できません。',
    'chartLegend': '公式／通常  ·  実際のコスト',
    'eventPayment': '支払い',
    'eventPromoEnd': 'プロモ終了',
    'eventTrialEnd': 'トライアル終了',
    'eventCancelDeadline': '解約期限',
    'eventPriceChange': '価格変更',
    'eventExpiry': '期限',
    'payVisa': 'Visa',
    'payMastercard': 'Mastercard',
    'payAmex': 'Amex',
    'payApple': 'Apple',
    'payGooglePlay': 'Google Play',
    'payPaypal': 'PayPal',
    'payOther': 'その他',
    'labelNextBilling': '次回請求',
    'labelTrialEnd': 'トライアル終了',
    'labelPromoEnd': 'プロモ終了',
    'labelCancelDeadline': '解約期限',
    'labelMyReminder': 'リマインダー',
    'labelFirstCharge': '初回請求',
    'labelAccessUntil': '利用可能期限',
    'daysRemaining': '残り {0} 日',
    'autoRenew': '自動更新',
    'manualRenew': '手動',
    'last4': '下4桁',
    'offerNone': 'オファーなし',
    'offerFreePeriod': '無料トライアル',
    'offerDiscount': '割引',
    'offerMultiStage': '段階価格',
    'offerCustom': 'カスタム',
    'freeDays7': '7日間無料',
    'freeDays14': '14日間無料',
    'freeDays30': '30日間無料',
    'freeDays60': '2か月無料',
    'freeDays90': '3か月無料',
    'freeDays180': '6か月無料',
    'freeDays365': '1年間無料',
    'freeDaysCustom': '指定日まで無料',
    'offerAfterFree': '{0}まで無料、その後 {1}／{2}',
    'offerFreeKeepsRegular': '通常の請求周期はそのままです。無料期間の終了後も元の価格で継続できます。',
    'promoPrice': 'プロモ価格',
    'reminderDays30': '30日前',
    'reminderDays14': '14日前',
    'reminderDays7': '7日前',
    'reminderDays3': '3日前',
    'reminderDays1': '1日前',
    'reminderSameDay': '当日',
    'reminderCustom': 'カスタム',
    'actionFreePeriod': '無料期間の終了',
    'actionPriceReview': '価格を見直しますか？',
    'priceReviewFreeBody': '無料期間が終了しました。{0}／{1} で継続するか、新しい金額を入力してください。',
    'priceReviewPromoBody': 'プロモが終了しました。{0}／{1} で継続するか、新しい金額を入力してください。',
    'priceReviewLater': 'あとで',
    'priceReviewConfirm': '確認',
    'eventPriceReviewed': '価格を確認',
    'actionPromoEnds': 'プロモ終了',
    'actionCancelDeadline': '解約期限',
    'actionRenews': '{0} に更新',
    'actionFirstCharge': '初回請求',
    'actionCardExpiry': '支払い方法の期限',
    'actionDaysLeft': '残り {0} 日',
    'actionDays': '{0} 日',
    'actionAfterTrial': 'トライアル後: {0} / {1}',
    'actionCancelBy': '{0} までに解約',
    'actionCurrent': '現在: {0}',
    'actionAfter': '以降: {0}',
    'actionReminder': 'リマインダー: {0}',
    'eventCreated': '作成',
    'eventPlanChanged': 'プラン変更',
    'eventPriceChanged': '価格変更',
    'eventPromoStarted': 'プロモ開始',
    'eventPromoEnded': 'プロモ終了',
    'eventTrialStarted': 'トライアル開始',
    'eventTrialEnded': 'トライアル終了',
    'eventRenewed': '更新',
    'eventPaused': '一時停止',
    'eventResumed': '再開',
    'eventCancelRequested': '解約申請',
    'eventCancelled': '解約',
    'eventExpired': '期限切れ',
    'eventReactivated': '再有効化',
    'paymentLabel': '支払い',
    'accessUntilDetail': '{0} まで利用可',
    'lineWebUnsupported': 'LINE ログインは Android / iOS のみ。Web では Google かゲストを使ってください。',
    'firestoreSetupHint': 'Firebase Console で Firestore を有効にし、README / firestore.rules のルールを適用してください。',
    'orders': '注文／予約',
    'addOrder': '+ 注文を追加',
    'addOrderTitle': '注文／予約を追加',
    'addOrderSubtitle': 'ショップ・マーケットの購入進捗',
    'noOrders': '注文なし',
    'noOrdersBody': 'Taobao や PLUSHSHOP などの注文を追跡し、未着・予約を忘れないようにします。',
    'pendingOrders': '未着／予約中',
    'completedOrders': '完了',
    'pendingOrdersCount': '未処理 {0} 件',
    'orderItem': '商品',
    'orderItemHint': '例：ぬいぐるみ A',
    'platform': 'プラットフォーム／ショップ',
    'platformCustomHint': 'ショップ名を入力',
    'purchaseStatus': 'ステータス',
    'orderedAt': '注文日',
    'expectedAt': '到着予定',
    'expectedAtOptional': '到着予定（任意）',
    'deliveredAt': '到着済み',
    'quantity': '数量',
    'priceOptional': '価格（任意）',
    'trackingUrlOptional': '追跡／注文 URL（任意）',
    'notesOptional': 'メモ（任意）',
    'orderDetail': '注文詳細',
    'orderNotFound': '注文が見つかりません。',
    'openTracking': '追跡／注文ページを開く',
    'updateStatus': 'ステータス更新',
    'deleteOrder': '注文を削除',
    'deleteOrderBody': 'この注文を一覧から削除しますか？',
    'viewAll': 'すべて見る',
    'noPendingOrders': '未着・予約中の品はありません。',
    'subscriptionsTracked': '契約中',
    'pendingPreorders': '未着／予約',
    'purchaseOrdered': '注文済み',
    'purchasePreorder': '予約中',
    'purchaseAwaitingShipment': '発送待ち',
    'purchaseShipped': '発送済み',
    'purchaseDelivered': '到着済み',
    'purchaseCancelled': 'キャンセル',
    'greetingMorning': 'おはようございます',
    'greetingAfternoon': 'こんにちは',
    'greetingEvening': 'こんばんは',
    'quickOrders': '注文',
    'activeSubsCount': '{0} 件契約中',
    'budgetUsage': '予算の {0} を使用',
    'dueToday': '今日',
    'dueTomorrow': '明日',
    'dueInDays': '{0} 日後',
    'spendingBreakdown': '支出の内訳',
    'quickAdd': '追加',
    'quickSimulate': '試算',
    'quickReview': '振り返り',
    'noUpcoming': '今後の支払いはありません。',
    'allCaughtUp': 'すべて対応済みです。',
    'filterSort': '絞り込みと並べ替え',
    'sortBy': '並べ替え',
    'categoryTitle': 'カテゴリ',
    'monthTotal': '今月の合計',
    'eventsCount': '{0} 件',
    'tools': 'ツール',
    'createNew': '新規作成',
    'insights': 'インサイト',
    'resetFilters': 'リセット',
    'subsSummary': '{0} 件のサブスク',
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
  String get deleteSubscription => t('deleteSubscription');
  String deleteSubscriptionBody(String name) => _fmt('deleteSubscriptionBody', [name]);
  String get editSubscription => t('editSubscription');
  String get planName => t('planName');
  String get notes => t('notes');
  String get pricePhases => t('pricePhases');
  String get addPhase => t('addPhase');
  String get editPhase => t('editPhase');
  String get regularPriceAfterOffer => t('regularPriceAfterOffer');
  String get promoName => t('promoName');
  String get regularPriceRequired => t('regularPriceRequired');
  String get selectProfileForSub => t('selectProfileForSub');
  String get notificationsEnabled => t('notificationsEnabled');
  String get cloudAutoDownload => t('cloudAutoDownload');
  String get cloudAutoUpload => t('cloudAutoUpload');
  String get statusTitle => t('statusTitle');
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
  String get deleteCustomService => t('deleteCustomService');
  String get deleteCustomServiceBody => t('deleteCustomServiceBody');
  String get customServiceInUse => t('customServiceInUse');
  String get customNameRequired => t('customNameRequired');
  String purgeCustomDone(int n) => _fmt('purgeCustomDone', ['$n']);
  String get selectPlan => t('selectPlan');
  String get billing => t('billing');
  String get reminder => t('reminder');
  String get back => t('back');
  String get connected => t('connected');
  String get notConnected => t('notConnected');
  String get link => t('link');
  String get version => t('version');
  String get author => t('author');
  String get authorSite => t('authorSite');
  String get authorGithub => t('authorGithub');
  String get privacy => t('privacy');
  String get terms => t('terms');
  String get total => t('total');
  String get cancelledSavings => t('cancelledSavings');
  String get yearInReview => t('yearInReview');
  String get allCats => t('allCats');
  String stepOf(int step, int total) => _fmt('stepOf', ['$step', '$total']);
  String get noSuggestedPlans => t('noSuggestedPlans');
  String get planPriceHint => t('planPriceHint');
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
  String get allProfilesShort => t('allProfilesShort');
  String get profilePersonal => t('profilePersonal');
  String get profileWork => t('profileWork');
  String get profileFamily => t('profileFamily');
  String get providerGoogle => t('providerGoogle');
  String get providerLine => t('providerLine');
  String get providerGuest => t('providerGuest');
  String get customThemeHelp => t('customThemeHelp');
  String get customThemeAccent => t('customThemeAccent');
  String get customThemeBackground => t('customThemeBackground');
  String get customThemeSurface => t('customThemeSurface');
  String get customThemeBorder => t('customThemeBorder');
  String get customThemeChannelRed => t('customThemeChannelRed');
  String get customThemeChannelGreen => t('customThemeChannelGreen');
  String get customThemeChannelBlue => t('customThemeChannelBlue');
  String get notificationPermissionTitle => t('notificationPermissionTitle');
  String get notificationPermissionBody => t('notificationPermissionBody');
  String get notNow => t('notNow');
  String get enableNotifications => t('enableNotifications');
  String get jumpToToday => t('jumpToToday');
  String get pickYearMonth => t('pickYearMonth');
  String get ordersSearchHint => t('ordersSearchHint');
  String get ordersFilterAll => t('ordersFilterAll');
  String get ordersFilterPending => t('ordersFilterPending');
  String get ordersFilterOverdue => t('ordersFilterOverdue');
  String get orderTimeline => t('orderTimeline');
  String get orderNextStep => t('orderNextStep');
  String get editOrder => t('editOrder');
  String get depositPaid => t('depositPaid');
  String get balanceDue => t('balanceDue');
  String get shippingFee => t('shippingFee');
  String get serviceFee => t('serviceFee');
  String get sellerName => t('sellerName');
  String get orderNumber => t('orderNumber');
  String get trackingNumber => t('trackingNumber');
  String get forwarder => t('forwarder');
  String get paymentNote => t('paymentNote');
  String get securityBiometricHint => t('securityBiometricHint');
  String get securityHideAmountsHint => t('securityHideAmountsHint');
  String orderKindLabel(PurchaseOrderKind k) => switch (k) {
        PurchaseOrderKind.preorder => t('orderKindPreorder'),
        PurchaseOrderKind.instock => t('orderKindInstock'),
        PurchaseOrderKind.proxy => t('orderKindProxy'),
      };
  String get weekdaySun => t('weekdaySun');
  String get weekdayMon => t('weekdayMon');
  String get weekdayTue => t('weekdayTue');
  String get weekdayWed => t('weekdayWed');
  String get weekdayThu => t('weekdayThu');
  String get weekdayFri => t('weekdayFri');
  String get weekdaySat => t('weekdaySat');
  List<String> get weekdayLabels => [
        weekdaySun,
        weekdayMon,
        weekdayTue,
        weekdayWed,
        weekdayThu,
        weekdayFri,
        weekdaySat,
      ];
  String get syncLocalOnly => t('syncLocalOnly');
  String get syncReady => t('syncReady');
  String get cloudUpload => t('cloudUpload');
  String get cloudDownload => t('cloudDownload');
  String get syncNeedLogin => t('syncNeedLogin');
  String get syncUploaded => t('syncUploaded');
  String get syncDownloaded => t('syncDownloaded');
  String get syncNoCloudBackup => t('syncNoCloudBackup');
  String get orders => t('orders');
  String get addOrder => t('addOrder');
  String get addOrderTitle => t('addOrderTitle');
  String get addOrderSubtitle => t('addOrderSubtitle');
  String get noOrders => t('noOrders');
  String get noOrdersBody => t('noOrdersBody');
  String get pendingOrders => t('pendingOrders');
  String get completedOrders => t('completedOrders');
  String pendingOrdersCount(int n) => _fmt('pendingOrdersCount', ['$n']);
  String get orderItem => t('orderItem');
  String get orderItemHint => t('orderItemHint');
  String get platform => t('platform');
  String get platformCustomHint => t('platformCustomHint');
  String get purchaseStatus => t('purchaseStatus');
  String get orderedAt => t('orderedAt');
  String get expectedAt => t('expectedAt');
  String get expectedAtOptional => t('expectedAtOptional');
  String get deliveredAt => t('deliveredAt');
  String get quantity => t('quantity');
  String get priceOptional => t('priceOptional');
  String get trackingUrlOptional => t('trackingUrlOptional');
  String get notesOptional => t('notesOptional');
  String get orderDetail => t('orderDetail');
  String get orderNotFound => t('orderNotFound');
  String get openTracking => t('openTracking');
  String get updateStatus => t('updateStatus');
  String get deleteOrder => t('deleteOrder');
  String get deleteOrderBody => t('deleteOrderBody');
  String get viewAll => t('viewAll');
  String get noPendingOrders => t('noPendingOrders');
  String get subscriptionsTracked => t('subscriptionsTracked');
  String get pendingPreorders => t('pendingPreorders');
  String get quickOrders => t('quickOrders');
  String activeSubsCount(int n) => _fmt('activeSubsCount', ['$n']);
  String budgetUsage(String pct) => _fmt('budgetUsage', [pct]);
  String get spendingBreakdown => t('spendingBreakdown');
  String get quickAdd => t('quickAdd');
  String get quickSimulate => t('quickSimulate');
  String get quickReview => t('quickReview');
  String get noUpcoming => t('noUpcoming');
  String get allCaughtUp => t('allCaughtUp');
  String get filterSort => t('filterSort');
  String get sortBy => t('sortBy');
  String get categoryTitle => t('categoryTitle');
  String get monthTotal => t('monthTotal');
  String eventsCount(int n) => _fmt('eventsCount', ['$n']);
  String get tools => t('tools');
  String get createNew => t('createNew');
  String get insights => t('insights');
  String get resetFilters => t('resetFilters');
  String subsSummary(int n) => _fmt('subsSummary', ['$n']);

  String greeting(DateTime now) => switch (now.hour) {
        < 5 => t('greetingEvening'),
        < 12 => t('greetingMorning'),
        < 18 => t('greetingAfternoon'),
        _ => t('greetingEvening'),
      };

  String get dueToday => t('dueToday');

  String dueIn(int days) => switch (days) {
        <= 0 => t('dueToday'),
        1 => t('dueTomorrow'),
        _ => _fmt('dueInDays', ['$days']),
      };

  String longDate(DateTime d) {
    return switch (locale.languageCode) {
      'zh' || 'ja' => '${d.month}月${d.day}日（${weekdayLabels[d.weekday % 7]}）',
      _ => DateFormat.MMMEd('en').format(d),
    };
  }

  String monthTitle(int year, int month) => switch (locale.languageCode) {
        'zh' || 'ja' => '$year年$month月',
        _ => '$year-${month.toString().padLeft(2, '0')}',
      };

  String shortDate(DateTime d) => switch (locale.languageCode) {
        'zh' || 'ja' => '${d.month}/${d.day}',
        _ => '${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}',
      };

  String profileDisplayName(String type, String fallbackName) => switch (type) {
        'personal' => profilePersonal,
        'work' => profileWork,
        'family' => profileFamily,
        _ => fallbackName,
      };

  String providerLabel(String id) => switch (id) {
        'google' => providerGoogle,
        'line' => providerLine,
        'guest' => providerGuest,
        _ => id,
      };

  String themePresetLabel(String name) => switch (name) {
        'voidTheme' => t('themeVoid'),
        'terminal' => t('themeTerminal'),
        'akira' => t('themeAkira'),
        'ice' => t('themeIce'),
        'light' => t('themeLight'),
        'noir' => t('themeNoir'),
        'sakura' => t('themeSakura'),
        'macaron' => t('themeMacaron'),
        'custom' => t('themeCustom'),
        _ => name,
      };

  String get labelNextBilling => t('labelNextBilling');
  String get labelTrialEnd => t('labelTrialEnd');
  String get labelPromoEnd => t('labelPromoEnd');
  String get labelCancelDeadline => t('labelCancelDeadline');
  String get labelMyReminder => t('labelMyReminder');
  String get labelFirstCharge => t('labelFirstCharge');
  String get labelAccessUntil => t('labelAccessUntil');
  String get chartNoHistory => t('chartNoHistory');
  String get chartLegend => t('chartLegend');
  String get autoRenew => t('autoRenew');
  String get manualRenew => t('manualRenew');
  String get last4 => t('last4');
  String get offerNone => t('offerNone');
  String get offerFreePeriod => t('offerFreePeriod');
  String get offerDiscount => t('offerDiscount');
  String get offerMultiStage => t('offerMultiStage');
  String get offerCustom => t('offerCustom');
  String get promoPrice => t('promoPrice');
  String get paymentLabel => t('paymentLabel');
  String get lineWebUnsupported => t('lineWebUnsupported');
  String get firestoreSetupHint => t('firestoreSetupHint');
  String actionRenews(String date) => _fmt('actionRenews', [date]);
  String actionDaysLeft(int n) => _fmt('actionDaysLeft', ['$n']);
  String actionDays(int n) => _fmt('actionDays', ['$n']);
  String actionAfterTrial(String price, String cycle) => _fmt('actionAfterTrial', [price, cycle]);
  String actionCancelBy(String date) => _fmt('actionCancelBy', [date]);
  String actionCurrent(String price) => _fmt('actionCurrent', [price]);
  String actionAfter(String price) => _fmt('actionAfter', [price]);
  String actionReminder(String date) => _fmt('actionReminder', [date]);
  String accessUntilDetail(String date) => _fmt('accessUntilDetail', [date]);
  String freeDaysLabel(int days) => switch (days) {
        7 => t('freeDays7'),
        14 => t('freeDays14'),
        30 => t('freeDays30'),
        60 => t('freeDays60'),
        90 => t('freeDays90'),
        180 => t('freeDays180'),
        365 => t('freeDays365'),
        -1 => t('freeDaysCustom'),
        _ => t('freeDays14'),
      };
  String offerAfterFree(String date, String price, String cycle) =>
      _fmt('offerAfterFree', [date, price, cycle]);
  String get offerFreeKeepsRegular => t('offerFreeKeepsRegular');
  String priceReviewFreeBody(String price, String cycle) =>
      _fmt('priceReviewFreeBody', [price, cycle]);
  String priceReviewPromoBody(String price, String cycle) =>
      _fmt('priceReviewPromoBody', [price, cycle]);
  String get priceReviewLater => t('priceReviewLater');
  String get priceReviewConfirm => t('priceReviewConfirm');
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
