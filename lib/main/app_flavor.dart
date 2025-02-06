enum Flavor { prod, dev }

class AppConfig {
  // Private constructor to enforce the use of the factory
  AppConfig._internal({
    required this.appName,
    required this.baseUrl,
    required this.authBaseUrl,
    required this.storageURL,
    required this.webdeSyncDbUrl,
    required this.deeplinkSchemaShareCard,
    required this.deeplinkSchemaShareStack,
    required this.deeplinkSchemaShareNews,
    required this.deeplinkShareHighlights,
    required this.deeplinkSchemaShareFeeds,
    required this.cardPrviewBaseUrl,
    required this.plugit,
    required this.shareContentlink,
    required this.flavor,
    required this.storageURLBanner,
  });

  // Factory constructor to create instances based on flavor
  factory AppConfig.create({Flavor flavor = Flavor.dev}) {
    switch (flavor) {
      case Flavor.dev:
        return AppConfig._internal(
            appName: 'Plugilo_dev',
            baseUrl: 'https://api.dev.plugilo.com/',
            authBaseUrl: 'https://auth.dev.plugilo.com/',
            storageURL:
                'https://wtcimageresizer.webtradecenter.com/remote/wtcdev.blob.core.windows.net/plugilo/',
            webdeSyncDbUrl: 'https://webde.sync.db.dev.plugilo.com/',
            deeplinkSchemaShareCard:
                'https://web.dev.plugilo.com/content/{contentId}',
            deeplinkSchemaShareStack: 'https://web.dev.plugilo.de/share/stacks',
            deeplinkSchemaShareNews: 'https://web.dev.plugilo.de/share/news',
            deeplinkShareHighlights:
                'https://web.dev.plugilo.de/share/highlights',
            deeplinkSchemaShareFeeds: 'https://web.dev.plugilo.de/share/feeds',
            cardPrviewBaseUrl:
                'https://preview.dev.plugilo.com/contentPreview/',
            plugit: 'https://api.dev.plugilo.com/plugit/api',
            shareContentlink:
                'https://light.plugilo.com/content/671a2f038e6878b2ee03d00f',
            flavor: flavor,
            storageURLBanner: "https://wtcimageresizer.webtradecenter.com");
      case Flavor.prod:
        return AppConfig._internal(
            appName: 'Plugilo',
            baseUrl: 'https://light.api.plugilo.com/v2/',
            authBaseUrl: 'https://auth.plugilo.com/',
            storageURL: 'https://storagedciinfo.azureedge.net/plugilo/',
            webdeSyncDbUrl: 'https://webde.sync.db.prod.plugilo.com/',
            deeplinkSchemaShareCard:
                'https://light.plugilo.com/content/{contentId}',
            deeplinkSchemaShareStack:
                'https://light.plugilo.com/content/{contentId}',
            deeplinkSchemaShareNews: 'https://plugilo.com/share/news',
            deeplinkShareHighlights: 'https://plugilo.com/share/highlights',
            deeplinkSchemaShareFeeds: 'https://plugilo.com/share/feeds',
            cardPrviewBaseUrl: 'https://preview.plugilo.com/contentPreview/',
            plugit: 'https://light.api.plugilo.com/mobile/api',
            shareContentlink:
                'https://light.plugilo.com/content/671a2f038e6878b2ee03d00f',
            flavor: flavor,
            storageURLBanner: "https://storagedciinfo.azureedge.net");
    }
  }

  final String appName;
  final String baseUrl;
  final String authBaseUrl;
  final String storageURL;
  final String webdeSyncDbUrl;
  final String deeplinkSchemaShareCard;
  final String deeplinkSchemaShareStack;
  final String deeplinkSchemaShareNews;
  final String deeplinkShareHighlights;
  final String deeplinkSchemaShareFeeds;
  final String cardPrviewBaseUrl;
  final String plugit;
  final String shareContentlink;
  final String storageURLBanner;

  final Flavor flavor;
  bool get isDevelopment => flavor == Flavor.dev;

  // Shared singleton instance
  static late final AppConfig shared;
}
