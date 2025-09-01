class CoffeePlaceholders {
  // Coffee-themed placeholder images using local assets
  static const Map<String, String> coffeeImages = {
    'coffee': 'lib/assets/coffee.webp',
    'hot_coffee': 'lib/assets/coffee-hot.webp',
    'cake': 'lib/assets/cake.webp',
    'latte': 'lib/assets/coffee-hot.webp',
    'cappuccino': 'lib/assets/coffee.webp',
    'default': 'lib/assets/coffee.webp',
  };

  static String getPlaceholderAsset(String type) {
    return coffeeImages[type.toLowerCase()] ?? coffeeImages['default']!;
  }

  static String getCoffeeTypeFromName(String productName) {
    final name = productName.toLowerCase();
    if (name.contains('latte')) {
      return 'latte';
    } else if (name.contains('cappuccino')) {
      return 'cappuccino';
    } else if (name.contains('hot') && name.contains('coffee')) {
      return 'hot_coffee';
    } else if (name.contains('cake') || name.contains('slice')) {
      return 'cake';
    } else if (name.contains('coffee')) {
      return 'coffee';
    }
    return 'default';
  }

  static String getAssetForProduct(String productName) {
    final type = getCoffeeTypeFromName(productName);
    return getPlaceholderAsset(type);
  }
}
