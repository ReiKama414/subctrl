import 'package:subctrl/data/seed/catalog.dart';

/// Resolves service mark initials and logo candidates (bundled asset first).
class ServiceLogoResolver {
  const ServiceLogoResolver();

  /// Dashboard Icons (PNG) slug overrides — network fallback only.
  static const _iconSlug = <String, String>{
    'chatgpt': 'chatgpt',
    'claude': 'anthropic',
    'gemini': 'google-gemini',
    'perplexity': 'perplexity',
    'midjourney': 'midjourney',
    'copilot': 'github-copilot',
    'notion-ai': 'notion',
    'elevenlabs': 'eleven-labs',
    'grok': 'x',
    'netflix': 'netflix',
    'disney': 'disney-plus',
    'youtube': 'youtube',
    'ytmusic': 'youtube-music',
    'prime': 'amazon-prime',
    'amazonprime': 'amazon-prime',
    'twitch': 'twitch',
    'max': 'max',
    'appletv': 'apple-tv-plus',
    'spotify': 'spotify',
    'applemusic': 'apple-music',
    'discord': 'discord',
    'xbox': 'xbox',
    'psplus': 'playstation',
    'nso': 'nintendo-switch',
    'eaplay': 'electronic-arts',
    'adobe': 'adobe',
    'm365': 'microsoft-365',
    'googleone': 'google-one',
    'dropbox': 'dropbox',
    'figma': 'figma',
    'jetbrains': 'jetbrains-toolbox',
    'notion': 'notion',
    'icloud': 'icloud',
    'onedrive': 'microsoft-onedrive',
    'github': 'github',
    'vercel': 'vercel',
    'cloudflare': 'cloudflare',
    'domain': 'cloudflare',
    'vps': 'hetzner',
    'nordvpn': 'nordvpn',
    'expressvpn': 'expressvpn',
    'duolingo': 'duolingo',
    'instagram': 'instagram',
    'xpremium': 'x',
    'patreon': 'patreon',
    'costco': 'costco',
    'openai': 'openai',
  };

  /// Catalog ids that ship under `assets/logos/{id}.png`.
  static const bundledKeys = <String>{
    '1password', 'adobe', 'amazonprime', 'applemusic', 'appletv', 'bahamut',
    'bumble', 'calm', 'canva', 'chatgpt', 'claude', 'cloudflare', 'cmb',
    'copilot', 'costco', 'crunchyroll', 'cursor', 'deliveroo', 'discord',
    'disney', 'domain', 'dropbox', 'duolingo', 'eaplay', 'economist',
    'elevenlabs', 'evernote', 'expressvpn', 'fanbox', 'feeld', 'figma',
    'foodpanda', 'gemini', 'github', 'googleone', 'grammarly', 'grindr',
    'grok', 'happn', 'headspace', 'her', 'hinge',     'hulu', 'icloud', 'iqiyi',
    'instagram', 'ipair', 'jetbrains', 'joox', 'kkbox', 'lastpass', 'leonardo',
    'linkedin', 'linemusic', 'linepremium', 'linestamp', 'm365', 'match', 'max',
    'midjourney', 'momo', 'myfitnesspal', 'netflix', 'nike', 'nordvpn', 'notion',
    'notion-ai', 'nso', 'nytimes', 'okcupid', 'onedrive', 'onlyfans', 'openai',
    'pairs', 'paramount', 'patreon', 'peloton', 'perplexity', 'pof', 'prime',
    'psplus', 'reddit', 'runway', 'shopeevip', 'skillshare', 'slack', 'snapchat',
    'soga', 'spotify', 'strava', 'sweetring', 'tantan', 'threads', 'tidal',
    'tiktok', 'tinder', 'todoist', 'twitch', 'ubereats', 'uberone', 'vercel',
    'viu', 'vps', 'wetv', 'whoop', 'with', 'xbox', 'xpremium', 'youtube',
    'ytmusic', 'zoe', 'zoom', 'badoo',
  };

  /// Extra CDN slugs for new brands when bundled asset is missing.
  static const _extraSlug = <String, String>{
    'tinder': 'tinder',
    'bumble': 'bumble',
    'spotify': 'spotify',
    'linkedin': 'linkedin',
    'reddit': 'reddit',
    'tiktok': 'tiktok',
    'snapchat': 'snapchat',
    'slack': 'slack',
    'zoom': 'zoom',
    'strava': 'strava',
    'hulu': 'hulu',
    'crunchyroll': 'crunchyroll',
    'grammarly': 'grammarly',
    'todoist': 'todoist',
    'evernote': 'evernote',
    'badoo': 'badoo',
    'line': 'line',
    'linepremium': 'line',
    'linestamp': 'line',
    'linemusic': 'line',
    'hinge': 'hinge',
  };

  static String _host(String site) => Uri.parse(site).host.replaceFirst(RegExp(r'^www\.'), '');

  String initials(String name) {
    final parts = name.replaceAll(RegExp(r'[^A-Za-z0-9 ]'), ' ').trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '??';
    if (parts.length == 1) {
      final s = parts.first.toUpperCase();
      return s.length >= 2 ? s.substring(0, 2) : s.padRight(2);
    }
    return (parts[0].isNotEmpty ? parts[0][0] : '') + (parts[1].isNotEmpty ? parts[1][0] : '');
  }

  /// Asset path if we ship a bundled mark for this key (e.g. `assets/logos/chatgpt.png`).
  String? assetPath({String? logoKey, String? name}) {
    final key = (logoKey ?? _keyFromName(name))?.toLowerCase().trim();
    if (key == null || key.isEmpty) return null;
    // Catalog ids always try the asset path; missing files fall through via errorBuilder.
    final known = bundledKeys.contains(key) || catalogServices.any((s) => s.id == key);
    if (!known) return null;
    return 'assets/logos/$key.png';
  }

  /// Ordered remote candidates (jsDelivr first — CORS-safe on web).
  List<String> imageUrls({String? website, String? logoKey, String? name}) {
    final key = (logoKey ?? _keyFromName(name))?.toLowerCase().trim();
    final host = _hostFromUrl(website) ?? _hostFromKey(key) ?? _hostFromName(name);
    final out = <String>[];
    final seen = <String>{};

    void add(String? url) {
      if (url == null || url.isEmpty || !seen.add(url)) return;
      out.add(url);
    }

    final slug = key == null ? null : (_iconSlug[key] ?? _extraSlug[key]);
    if (slug != null && slug.isNotEmpty) {
      add('https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/$slug.png');
    }
    if (host != null && host.isNotEmpty) {
      // Google favicon often works on mobile; on web may fail CORS — asset covers catalog.
      add('https://www.google.com/s2/favicons?domain=${Uri.encodeComponent(host)}&sz=128');
    }
    return out;
  }

  String? imageUrl({String? website, String? logoKey, String? name}) {
    final urls = imageUrls(website: website, logoKey: logoKey, name: name);
    return urls.isEmpty ? null : urls.first;
  }

  String? _keyFromName(String? name) {
    if (name == null || name.isEmpty) return null;
    final n = name.toLowerCase().trim();
    for (final s in catalogServices) {
      final sn = s.name.toLowerCase();
      if (sn == n || n.startsWith(sn) || sn.startsWith(n)) return s.id;
    }
    for (final s in catalogServices) {
      if (s.id == n) return s.id;
    }
    for (final s in catalogServices) {
      if (n.contains(s.name.toLowerCase()) || n.contains(s.id)) return s.id;
    }
    return null;
  }

  String? _hostFromUrl(String? url) {
    if (url == null || url.isEmpty) return null;
    try {
      final uri = Uri.parse(url.contains('://') ? url : 'https://$url');
      final host = uri.host.replaceFirst(RegExp(r'^www\.'), '');
      return host.isEmpty ? null : host;
    } catch (_) {
      return null;
    }
  }

  String? _hostFromKey(String? key) {
    if (key == null || key.isEmpty) return null;
    final k = key.toLowerCase().trim();
    for (final s in catalogServices) {
      if (s.id == k) return _host(s.site);
    }
    return null;
  }

  String? _hostFromName(String? name) {
    return _hostFromKey(_keyFromName(name));
  }
}
