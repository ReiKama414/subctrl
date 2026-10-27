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
  ('dating', 'DATING', 8),
  ('shopping', 'SHOPPING', 9),
  ('education', 'EDUCATION', 10),
  ('fitness', 'FITNESS', 11),
  ('vpn', 'VPN', 12),
  ('news', 'NEWS', 13),
  ('developer', 'DEVELOPER', 14),
  ('other', 'OTHER', 15),
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
    CatalogPlanSeed('Plus', 'monthly', 60, 'USD'),
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
  CatalogSeedItem(id: 'hulu', name: 'Hulu', category: 'video', site: 'https://www.hulu.com', manage: 'https://www.hulu.com/account', plans: const [
    CatalogPlanSeed('With Ads', 'monthly', 7.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'paramount', name: 'Paramount+', category: 'video', site: 'https://www.paramountplus.com', manage: 'https://www.paramountplus.com/account', plans: const [
    CatalogPlanSeed('Essential', 'monthly', 7.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'crunchyroll', name: 'Crunchyroll', category: 'video', site: 'https://www.crunchyroll.com', manage: 'https://www.crunchyroll.com/account', plans: const [
    CatalogPlanSeed('Fan', 'monthly', 7.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'bahamut', name: '巴哈姆特動畫瘋', category: 'video', site: 'https://ani.gamer.com.tw', manage: 'https://ani.gamer.com.tw', plans: const [
    CatalogPlanSeed('月費', 'monthly', 99, 'TWD'),
  ]),
  CatalogSeedItem(id: 'viu', name: 'Viu', category: 'video', site: 'https://www.viu.com', manage: 'https://www.viu.com', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 120, 'TWD'),
  ]),
  CatalogSeedItem(id: 'iqiyi', name: 'iQIYI', category: 'video', site: 'https://www.iq.com', manage: 'https://www.iq.com', plans: const [
    CatalogPlanSeed('Gold', 'monthly', 210, 'TWD'),
  ]),
  CatalogSeedItem(id: 'wetv', name: 'WeTV', category: 'video', site: 'https://wetv.vip', manage: 'https://wetv.vip', plans: const [
    CatalogPlanSeed('VIP', 'monthly', 149, 'TWD'),
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
  CatalogSeedItem(id: 'joox', name: 'JOOX', category: 'music', site: 'https://www.joox.com', manage: 'https://www.joox.com', plans: const [
    CatalogPlanSeed('VIP', 'monthly', 149, 'TWD'),
  ]),
  CatalogSeedItem(id: 'tidal', name: 'Tidal', category: 'music', site: 'https://tidal.com', manage: 'https://tidal.com/account', plans: const [
    CatalogPlanSeed('HiFi', 'monthly', 10.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'linemusic', name: 'LINE MUSIC', category: 'music', site: 'https://music.line.me', manage: 'https://music.line.me', plans: const [
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
    CatalogPlanSeed('pro Annual', 'yearly', 780, 'TWD'),
  ]),
  CatalogSeedItem(id: 'ubereats', name: 'Uber Eats Pass', category: 'delivery', site: 'https://www.ubereats.com', manage: 'https://www.ubereats.com', plans: const [
    CatalogPlanSeed('Pass', 'monthly', 99, 'TWD'),
    CatalogPlanSeed('Pass Annual', 'yearly', 990, 'TWD'),
  ]),
  CatalogSeedItem(id: 'deliveroo', name: 'Deliveroo Plus', category: 'delivery', site: 'https://deliveroo.com', manage: 'https://deliveroo.com', plans: const [
    CatalogPlanSeed('Plus', 'monthly', 7.99, 'USD'),
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
  CatalogSeedItem(id: 'grammarly', name: 'Grammarly', category: 'software', site: 'https://www.grammarly.com', manage: 'https://account.grammarly.com', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 12, 'USD'),
  ]),
  CatalogSeedItem(id: '1password', name: '1Password', category: 'software', site: 'https://1password.com', manage: 'https://my.1password.com', plans: const [
    CatalogPlanSeed('Individual', 'monthly', 2.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'lastpass', name: 'LastPass', category: 'software', site: 'https://www.lastpass.com', manage: 'https://lastpass.com/account', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 3, 'USD'),
  ]),
  CatalogSeedItem(id: 'todoist', name: 'Todoist', category: 'software', site: 'https://todoist.com', manage: 'https://todoist.com/app/settings', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 5, 'USD'),
  ]),
  CatalogSeedItem(id: 'evernote', name: 'Evernote', category: 'software', site: 'https://evernote.com', manage: 'https://www.evernote.com/Settings.action', plans: const [
    CatalogPlanSeed('Personal', 'monthly', 14.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'zoom', name: 'Zoom', category: 'software', site: 'https://zoom.us', manage: 'https://zoom.us/account', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 15.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'slack', name: 'Slack', category: 'software', site: 'https://slack.com', manage: 'https://slack.com/account', plans: const [
    CatalogPlanSeed('Pro', 'monthly', 8.75, 'USD'),
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
  CatalogSeedItem(id: 'linkedin', name: 'LinkedIn Premium', category: 'social', site: 'https://www.linkedin.com', manage: 'https://www.linkedin.com/premium', plans: const [
    CatalogPlanSeed('Career', 'monthly', 29.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'reddit', name: 'Reddit Premium', category: 'social', site: 'https://www.reddit.com', manage: 'https://www.reddit.com/premium', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 5.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'threads', name: 'Threads', category: 'social', site: 'https://www.threads.net', manage: 'https://accountscenter.instagram.com', plans: const [
    CatalogPlanSeed('Verified', 'monthly', 11.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'snapchat', name: 'Snapchat+', category: 'social', site: 'https://www.snapchat.com', manage: 'https://accounts.snapchat.com', plans: const [
    CatalogPlanSeed('Plus', 'monthly', 3.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'tiktok', name: 'TikTok', category: 'social', site: 'https://www.tiktok.com', manage: 'https://www.tiktok.com/setting', plans: const [
    CatalogPlanSeed('TikTok One', 'monthly', 4.99, 'USD'),
  ]),

  // Dating
  CatalogSeedItem(id: 'tinder', name: 'Tinder', category: 'dating', site: 'https://tinder.com', manage: 'https://tinder.com/app/settings', plans: const [
    CatalogPlanSeed('Gold', 'monthly', 22.99, 'USD'),
    CatalogPlanSeed('Platinum', 'monthly', 32.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'bumble', name: 'Bumble', category: 'dating', site: 'https://bumble.com', manage: 'https://bumble.com/app', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 32.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'hinge', name: 'Hinge', category: 'dating', site: 'https://hinge.co', manage: 'https://hinge.co', plans: const [
    CatalogPlanSeed('Preferred', 'monthly', 29.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'okcupid', name: 'OkCupid', category: 'dating', site: 'https://www.okcupid.com', manage: 'https://www.okcupid.com/settings', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'match', name: 'Match', category: 'dating', site: 'https://www.match.com', manage: 'https://www.match.com/account', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 29.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'feeld', name: 'Feeld', category: 'dating', site: 'https://feeld.co', manage: 'https://feeld.co', plans: const [
    CatalogPlanSeed('Majestic', 'monthly', 17.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'her', name: 'HER', category: 'dating', site: 'https://weareher.com', manage: 'https://weareher.com', plans: const [
    CatalogPlanSeed('Plus', 'monthly', 14.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'grindr', name: 'Grindr', category: 'dating', site: 'https://www.grindr.com', manage: 'https://www.grindr.com', plans: const [
    CatalogPlanSeed('XTRA', 'monthly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'happn', name: 'happn', category: 'dating', site: 'https://www.happn.com', manage: 'https://www.happn.com', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'cmb', name: 'CMB (Coffee Meets Bagel)', category: 'dating', site: 'https://coffeemeetsbagel.com', manage: 'https://coffeemeetsbagel.com', plans: const [
    CatalogPlanSeed('Beans', 'monthly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'soga', name: 'Soga', category: 'dating', site: 'https://getsoga.com', manage: 'https://getsoga.com', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 990, 'TWD'),
  ]),
  CatalogSeedItem(id: 'badoo', name: 'Badoo', category: 'dating', site: 'https://badoo.com', manage: 'https://badoo.com', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'pof', name: 'Plenty of Fish', category: 'dating', site: 'https://www.pof.com', manage: 'https://www.pof.com', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'zoe', name: 'Zoe', category: 'dating', site: 'https://zoe.tw', manage: 'https://zoe.tw', plans: const [
    CatalogPlanSeed('VIP', 'monthly', 990, 'TWD'),
  ]),
  CatalogSeedItem(id: 'sweetring', name: 'SweetRing', category: 'dating', site: 'https://www.sweetring.com', manage: 'https://www.sweetring.com', plans: const [
    CatalogPlanSeed('VIP', 'monthly', 990, 'TWD'),
  ]),
  CatalogSeedItem(id: 'pairs', name: 'Pairs', category: 'dating', site: 'https://www.pairs.lv', manage: 'https://www.pairs.lv', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 1280, 'TWD'),
  ]),
  CatalogSeedItem(id: 'with', name: 'With', category: 'dating', site: 'https://with.app', manage: 'https://with.app', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 990, 'TWD'),
  ]),
  CatalogSeedItem(id: 'ipair', name: 'iPair', category: 'dating', site: 'https://www.ipair.com', manage: 'https://www.ipair.com', plans: const [
    CatalogPlanSeed('VIP', 'monthly', 990, 'TWD'),
  ]),
  CatalogSeedItem(id: 'tantan', name: 'Tantan', category: 'dating', site: 'https://tantanapp.com', manage: 'https://tantanapp.com', plans: const [
    CatalogPlanSeed('VIP', 'monthly', 990, 'TWD'),
  ]),
  CatalogSeedItem(id: 'linepremium', name: 'LINE Premium', category: 'social', site: 'https://line.me', manage: 'https://line.me', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 160, 'TWD'),
  ]),
  CatalogSeedItem(id: 'linestamp', name: 'LINE 貼圖／主題', category: 'other', site: 'https://store.line.me', manage: 'https://store.line.me', plans: const [
    CatalogPlanSeed('訂閱制貼圖', 'monthly', null, 'TWD'),
  ]),

  CatalogSeedItem(id: 'amazonprime', name: 'Amazon Prime', category: 'shopping', site: 'https://www.amazon.com/prime', manage: 'https://www.amazon.com/gp/primecentral', plans: const [
    CatalogPlanSeed('Monthly', 'monthly', 14.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'costco', name: 'Costco', category: 'shopping', site: 'https://www.costco.com.tw', manage: 'https://www.costco.com.tw', plans: const [
    CatalogPlanSeed('Gold Star', 'yearly', 1350, 'TWD'),
  ]),
  CatalogSeedItem(id: 'shopeevip', name: 'Shopee VIP', category: 'shopping', site: 'https://shopee.tw', manage: 'https://shopee.tw', plans: const [
    CatalogPlanSeed('VIP', 'monthly', 49, 'TWD'),
  ]),
  CatalogSeedItem(id: 'momo', name: 'momo', category: 'shopping', site: 'https://www.momoshop.com.tw', manage: 'https://www.momoshop.com.tw', plans: const [
    CatalogPlanSeed('momo幣方案', 'monthly', null, 'TWD'),
  ]),

  // Fitness / wellness
  CatalogSeedItem(id: 'strava', name: 'Strava', category: 'fitness', site: 'https://www.strava.com', manage: 'https://www.strava.com/settings/subscription', plans: const [
    CatalogPlanSeed('Subscriber', 'monthly', 11.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'peloton', name: 'Peloton', category: 'fitness', site: 'https://www.onepeloton.com', manage: 'https://www.onepeloton.com/membership', plans: const [
    CatalogPlanSeed('App', 'monthly', 12.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'calm', name: 'Calm', category: 'fitness', site: 'https://www.calm.com', manage: 'https://www.calm.com/account', plans: const [
    CatalogPlanSeed('Premium', 'yearly', 69.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'headspace', name: 'Headspace', category: 'fitness', site: 'https://www.headspace.com', manage: 'https://www.headspace.com/subscription', plans: const [
    CatalogPlanSeed('Annual', 'yearly', 69.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'myfitnesspal', name: 'MyFitnessPal', category: 'fitness', site: 'https://www.myfitnesspal.com', manage: 'https://www.myfitnesspal.com/account', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 19.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'nike', name: 'Nike Training Club', category: 'fitness', site: 'https://www.nike.com/ntc-app', manage: 'https://www.nike.com', plans: const [
    CatalogPlanSeed('Premium', 'monthly', 8.99, 'USD'),
  ]),
  CatalogSeedItem(id: 'whoop', name: 'WHOOP', category: 'fitness', site: 'https://www.whoop.com', manage: 'https://app.whoop.com', plans: const [
    CatalogPlanSeed('Membership', 'monthly', 30, 'USD'),
  ]),

  CatalogSeedItem(id: 'patreon', name: 'Patreon', category: 'other', site: 'https://www.patreon.com', manage: 'https://www.patreon.com/settings', plans: const [
    CatalogPlanSeed('Custom', 'monthly', null, 'USD'),
  ]),
  CatalogSeedItem(id: 'fanbox', name: 'pixiv FANBOX', category: 'other', site: 'https://www.fanbox.cc', manage: 'https://www.fanbox.cc/settings', plans: const [
    CatalogPlanSeed('Custom', 'monthly', null, 'JPY'),
  ]),
  CatalogSeedItem(id: 'onlyfans', name: 'OnlyFans', category: 'other', site: 'https://onlyfans.com', manage: 'https://onlyfans.com', plans: const [
    CatalogPlanSeed('Custom', 'monthly', null, 'USD'),
  ]),
];
