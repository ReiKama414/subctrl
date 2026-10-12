class CatalogSeedItem {
  const CatalogSeedItem({
    required this.id,
    required this.name,
    required this.category,
    required this.site,
    required this.manage,
    this.plans = const [],
  });

  final String id;
  final String name;
  final String category;
  final String site;
  final String manage;
  final List<CatalogPlanSeed> plans;
}

class CatalogPlanSeed {
  const CatalogPlanSeed(this.name, this.cycle, this.price, this.currency);
  final String name;
  final String cycle;
  final double? price;
  final String? currency;
}

const catalogCategories = <(String, String, int)>[
  ('ai', 'AI', 0),
  ('video', 'VIDEO', 1),
  ('music', 'MUSIC', 2),
  ('gaming', 'GAMING', 3),
  ('delivery', 'DELIVERY', 4),
  ('software', 'SOFTWARE', 5),
  ('cloud', 'CLOUD', 6),
  ('social', 'SOCIAL', 7),
  ('shopping', 'SHOPPING', 8),
  ('education', 'EDUCATION', 9),
  ('vpn', 'VPN', 10),
  ('news', 'NEWS', 11),
  ('developer', 'DEVELOPER', 12),
  ('other', 'OTHER', 13),
];

final catalogServices = <CatalogSeedItem>[
  CatalogSeedItem(id: 'chatgpt', name: 'ChatGPT', category: 'ai', site: 'https://chatgpt.com', manage: 'https://chatgpt.com/#settings', plans: const [
    CatalogPlanSeed('Plus', 'monthly', 20, 'USD'),
    CatalogPlanSeed('Pro', 'monthly', 200, 'USD'),
  ]),
  CatalogSeedItem(id: 'claude', name: 'Claude', category: 'ai', site: 'https://claude.ai', manage: 'https://claude.ai/settings', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 20, 'USD'),
    CatalogPlanSeed('Max', 'monthly', 100, 'USD'),
  ]),
  CatalogSeedItem(id: 'gemini', name: 'Gemini', category: 'ai', site: 'https://gemini.google.com', manage: 'https://one.google.com', plans: const [
    CatalogPlanSeed('Google AI Pro', 'monthly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'perplexity', name: 'Perplexity', category: 'ai', site: 'https://www.perplexity.ai', manage: 'https://www.perplexity.ai/account', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 20, 'USD'),
  ]),
  CatalogSeedItem(id: 'midjourney', name: 'Midjourney', category: 'ai', site: 'https://www.midjourney.com', manage: 'https://www.midjourney.com/account', plans: const [
    CatalogPlanSeed('Standard', 'monthly', 30, 'USD'),
  ]),
  CatalogSeedItem(id: 'cursor', name: 'Cursor', category: 'ai', site: 'https://cursor.com', manage: 'https://cursor.com/dashboard', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 20, 'USD'),
  ]),
  CatalogSeedItem(id: 'copilot', name: 'GitHub Copilot', category: 'ai', site: 'https://github.com/features/copilot', manage: 'https://github.com/settings/billing', plans: const [
    CatalogPlanSeed('Individual', 'monthly', 10, 'USD'),
  ]),
  CatalogSeedItem(id: 'canva', name: 'Canva', category: 'ai', site: 'https://www.canva.com', manage: 'https://www.canva.com/settings', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 500, 'TWD'),
  ]),
  CatalogSeedItem(id: 'notion-ai', name: 'Notion AI', category: 'ai', site: 'https://www.notion.so', manage: 'https://www.notion.so/settings', plans: const [
    CatalogPlanSeed('Add-on', 'monthly', 10, 'USD'),
  ]),
  CatalogSeedItem(id: 'elevenlabs', name: 'ElevenLabs', category: 'ai', site: 'https://elevenlabs.io', manage: 'https://elevenlabs.io/app/subscription', plans: const [
    CatalogPlanSeed('Starter', 'monthly', 5, 'USD'),
  ]),
  CatalogSeedItem(id: 'runway', name: 'Runway', category: 'ai', site: 'https://runwayml.com', manage: 'https://app.runwayml.com', plans: const [
    CatalogPlanSeed('Standard', 'monthly', 15, 'USD'),
  ]),
  CatalogSeedItem(id: 'leonardo', name: 'Leonardo', category: 'ai', site: 'https://leonardo.ai', manage: 'https://app.leonardo.ai', plans: const [
    CatalogPlanSeed('Apprentice', 'monthly', 12, 'USD'),
  ]),
  CatalogSeedItem(id: 'grok', name: 'Grok', category: 'ai', site: 'https://x.ai', manage: 'https://x.com/settings', plans: const [
    CatalogPlanSeed('X Premium', 'monthly', 8, 'USD'),
  ]),
  CatalogSeedItem(id: 'netflix', name: 'Netflix', category: 'video', site: 'https://www.netflix.com', manage: 'https://www.netflix.com/account', plans: const [
    CatalogPlanSeed('Standard', 'monthly', 270, 'TWD'),
    CatalogPlanSeed('Premium', 'monthly', 390, 'TWD'),
  ]),
  CatalogSeedItem(id: 'disney', name: 'Disney+', category: 'video', site: 'https://www.disneyplus.com', manage: 'https://www.disneyplus.com/account', plans: const [
    CatalogPlanSeed('Standard', 'monthly', 270, 'TWD'),
  ]),
  CatalogSeedItem(id: 'youtube', name: 'YouTube Premium', category: 'video', site: 'https://www.youtube.com/premium', manage: 'https://www.youtube.com/paid_memberships', plans: const [
    CatalogPlanSeed('Individual', 'monthly', 179, 'TWD'),
    CatalogPlanSeed('Family', 'monthly', 269, 'TWD'),
  ]),
  CatalogSeedItem(id: 'ytmusic', name: 'YouTube Music', category: 'music', site: 'https://music.youtube.com', manage: 'https://www.youtube.com/paid_memberships', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 149, 'TWD'),
  ]),
  CatalogSeedItem(id: 'prime', name: 'Prime Video', category: 'video', site: 'https://www.primevideo.com', manage: 'https://www.amazon.com/gp/video', plans: const [
    CatalogPlanSeed('Monthly', 'monthly', 8.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'twitch', name: 'Twitch', category: 'video', site: 'https://www.twitch.tv', manage: 'https://www.twitch.tv/subscriptions', plans: const [
    CatalogPlanSeed('Turbo', 'monthly', 8.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'max', name: 'Max', category: 'video', site: 'https://www.max.com', manage: 'https://auth.max.com', plans: const [
    CatalogPlanSeed('Ad-Free', 'monthly', 16.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'appletv', name: 'Apple TV+', category: 'video', site: 'https://tv.apple.com', manage: 'https://tv.apple.com/settings', plans: const [
    CatalogPlanSeed('Monthly', 'monthly', 6.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'spotify', name: 'Spotify', category: 'music', site: 'https://www.spotify.com', manage: 'https://www.spotify.com/account', plans: const [
    CatalogPlanSeed('Individual', 'monthly', 149, 'TWD'),
    CatalogPlanSeed('Family', 'monthly', 249, 'TWD'),
  ]),
  CatalogSeedItem(id: 'applemusic', name: 'Apple Music', category: 'music', site: 'https://www.apple.com/apple-music', manage: 'https://music.apple.com', plans: const [
    CatalogPlanSeed('Individual', 'monthly', 150, 'TWD'),
  ]),
  CatalogSeedItem(id: 'kkbox', name: 'KKBOX', category: 'music', site: 'https://www.kkbox.com', manage: 'https://www.kkbox.com/account', plans: const [
    CatalogPlanSeed('Individual', 'monthly', 149, 'TWD'),
  ]),
  CatalogSeedItem(id: 'discord', name: 'Discord Nitro', category: 'gaming', site: 'https://discord.com', manage: 'https://discord.com/settings/subscriptions', plans: const [
    CatalogPlanSeed('Nitro', 'monthly', 9.99, 'USD'),
    CatalogPlanSeed('Nitro Basic', 'monthly', 2.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'xbox', name: 'Xbox Game Pass', category: 'gaming', site: 'https://www.xbox.com/game-pass', manage: 'https://account.microsoft.com/services', plans: const [
    CatalogPlanSeed('Ultimate', 'monthly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'psplus', name: 'PlayStation Plus', category: 'gaming', site: 'https://www.playstation.com', manage: 'https://www.playstation.com/acct', plans: const [
    CatalogPlanSeed('Essential', 'yearly', 79.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'nso', name: 'Nintendo Switch Online', category: 'gaming', site: 'https://www.nintendo.com', manage: 'https://accounts.nintendo.com', plans: const [
    CatalogPlanSeed('Individual', 'yearly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'eaplay', name: 'EA Play', category: 'gaming', site: 'https://www.ea.com/ea-play', manage: 'https://myaccount.ea.com', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 16.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'uberone', name: 'Uber One', category: 'delivery', site: 'https://www.uber.com', manage: 'https://www.uber.com/uber-one', plans: const [
    CatalogPlanSeed('Monthly', 'monthly', 9.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'foodpanda', name: 'foodpanda', category: 'delivery', site: 'https://www.foodpanda.com.tw', manage: 'https://www.foodpanda.com.tw', plans: const [
    CatalogPlanSeed('pro', 'monthly', 65, 'TWD'),
  ]),
  CatalogSeedItem(id: 'adobe', name: 'Adobe', category: 'software', site: 'https://www.adobe.com', manage: 'https://account.adobe.com', plans: const [
    CatalogPlanSeed('Creative Cloud All Apps', 'monthly', 54.99, 'USD'),
    CatalogPlanSeed('Photography', 'monthly', 9.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'm365', name: 'Microsoft 365', category: 'software', site: 'https://www.microsoft.com/microsoft-365', manage: 'https://account.microsoft.com/services', plans: const [
    CatalogPlanSeed('Personal', 'yearly', 69.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'googleone', name: 'Google One', category: 'cloud', site: 'https://one.google.com', manage: 'https://one.google.com', plans: const [
    CatalogPlanSeed('100 GB', 'monthly', 70, 'TWD'),
    CatalogPlanSeed('2 TB', 'monthly', 350, 'TWD'),
  ]),
  CatalogSeedItem(id: 'dropbox', name: 'Dropbox', category: 'cloud', site: 'https://www.dropbox.com', manage: 'https://www.dropbox.com/account', plans: const [
    CatalogPlanSeed('Plus', 'monthly', 9.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'figma', name: 'Figma', category: 'software', site: 'https://www.figma.com', manage: 'https://www.figma.com/settings', plans: const [
    CatalogPlanSeed('Professional', 'monthly', 15, 'USD'),
  ]),
  CatalogSeedItem(id: 'jetbrains', name: 'JetBrains', category: 'software', site: 'https://www.jetbrains.com', manage: 'https://account.jetbrains.com', plans: const [
    CatalogPlanSeed('All Products', 'yearly', 249, 'USD'),
  ]),
  CatalogSeedItem(id: 'notion', name: 'Notion', category: 'software', site: 'https://www.notion.so', manage: 'https://www.notion.so/settings', plans: const [
    CatalogPlanSeed('Plus', 'monthly', 10, 'USD'),
  ]),
  CatalogSeedItem(id: 'icloud', name: 'iCloud+', category: 'cloud', site: 'https://www.icloud.com', manage: 'https://www.icloud.com/settings', plans: const [
    CatalogPlanSeed('50 GB', 'monthly', 30, 'TWD'),
    CatalogPlanSeed('200 GB', 'monthly', 90, 'TWD'),
  ]),
  CatalogSeedItem(id: 'onedrive', name: 'OneDrive', category: 'cloud', site: 'https://onedrive.live.com', manage: 'https://account.microsoft.com/services', plans: const [
    CatalogPlanSeed('Standalone', 'monthly', 1.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'github', name: 'GitHub', category: 'developer', site: 'https://github.com', manage: 'https://github.com/settings/billing', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 4, 'USD'),
  ]),
  CatalogSeedItem(id: 'vercel', name: 'Vercel', category: 'developer', site: 'https://vercel.com', manage: 'https://vercel.com/account', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 20, 'USD'),
  ]),
  CatalogSeedItem(id: 'cloudflare', name: 'Cloudflare', category: 'developer', site: 'https://www.cloudflare.com', manage: 'https://dash.cloudflare.com', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 20, 'USD'),
  ]),
  CatalogSeedItem(id: 'domain', name: 'Domain', category: 'developer', site: 'https://www.cloudflare.com/products/registrar', manage: 'https://dash.cloudflare.com', plans: const [
    CatalogPlanSeed('Annual domain', 'yearly', 10, 'USD'),
  ]),
  CatalogSeedItem(id: 'vps', name: 'VPS', category: 'developer', site: 'https://www.hetzner.com', manage: 'https://console.hetzner.cloud', plans: const [
    CatalogPlanSeed('Cloud CX', 'monthly', 5, 'USD'),
  ]),
  CatalogSeedItem(id: 'nordvpn', name: 'NordVPN', category: 'vpn', site: 'https://nordvpn.com', manage: 'https://my.nordaccount.com', plans: const [
    CatalogPlanSeed('Plus', 'yearly', 99, 'USD'),
  ]),
  CatalogSeedItem(id: 'expressvpn', name: 'ExpressVPN', category: 'vpn', site: 'https://www.expressvpn.com', manage: 'https://www.expressvpn.com/subscriptions', plans: const [
    CatalogPlanSeed('Monthly', 'monthly', 12.95, 'USD'),
  ]),
  CatalogSeedItem(id: 'nytimes', name: 'New York Times', category: 'news', site: 'https://www.nytimes.com', manage: 'https://myaccount.nytimes.com', plans: const [
    CatalogPlanSeed('All Access', 'monthly', 25, 'USD'),
  ]),
  CatalogSeedItem(id: 'economist', name: 'The Economist', category: 'news', site: 'https://www.economist.com', manage: 'https://myaccount.economist.com', plans: const [
    CatalogPlanSeed('Digital', 'monthly', 19, 'USD'),
  ]),
  CatalogSeedItem(id: 'duolingo', name: 'Duolingo', category: 'education', site: 'https://www.duolingo.com', manage: 'https://www.duolingo.com/settings/super', plans: const [
    CatalogPlanSeed('Super', 'monthly', 6.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'skillshare', name: 'Skillshare', category: 'education', site: 'https://www.skillshare.com', manage: 'https://www.skillshare.com/settings', plans: const [
    CatalogPlanSeed('Premium', 'yearly', 99, 'USD'),
  ]),
  CatalogSeedItem(id: 'instagram', name: 'Instagram', category: 'social', site: 'https://www.instagram.com', manage: 'https://accountscenter.instagram.com', plans: const [
    CatalogPlanSeed('Verified', 'monthly', 11.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'xpremium', name: 'X Premium', category: 'social', site: 'https://x.com', manage: 'https://x.com/settings', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 8, 'USD'),
  ]),
  CatalogSeedItem(id: 'amazonprime', name: 'Amazon Prime', category: 'shopping', site: 'https://www.amazon.com/prime', manage: 'https://www.amazon.com/gp/primecentral', plans: const [
    CatalogPlanSeed('Monthly', 'monthly', 14.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'costco', name: 'Costco', category: 'shopping', site: 'https://www.costco.com.tw', manage: 'https://www.costco.com.tw', plans: const [
    CatalogPlanSeed('Gold Star', 'yearly', 1350, 'TWD'),
  ]),
  CatalogSeedItem(id: 'patreon', name: 'Patreon', category: 'other', site: 'https://www.patreon.com', manage: 'https://www.patreon.com/settings', plans: const [
    CatalogPlanSeed('Custom', 'monthly', null, 'USD'),
  ]),
  CatalogSeedItem(id: 'fanbox', name: 'pixiv FANBOX', category: 'other', site: 'https://www.fanbox.cc', manage: 'https://www.fanbox.cc/settings', plans: const [
    CatalogPlanSeed('Custom', 'monthly', null, 'JPY'),
  ]),
];
