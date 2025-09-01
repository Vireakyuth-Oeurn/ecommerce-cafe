import 'package:flutter/foundation.dart' show kIsWeb;

class WebImageConfig {
  // For web deployment, you might want to use a CORS proxy
  static const String corsProxy = 'https://cors-anywhere.herokuapp.com/';
  static const bool useCorsProxy =
      false; // Set to true if you have a CORS proxy

  static String getWebSafeImageUrl(String originalUrl) {
    if (!kIsWeb) {
      return originalUrl;
    }

    if (useCorsProxy) {
      return '$corsProxy$originalUrl';
    }

    // For now, return original URL and let error handling take care of it
    return originalUrl;
  }

  static bool get shouldShowPlaceholderForWeb => kIsWeb;
}
