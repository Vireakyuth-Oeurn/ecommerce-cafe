import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../theme/coffee_theme.dart';
import '../utils/web_image_config.dart';
import '../utils/coffee_placeholders.dart';

class PlaceholderImage extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData icon;
  final String? text;
  final BorderRadius? borderRadius;

  const PlaceholderImage({
    Key? key,
    this.width,
    this.height,
    this.icon = Icons.image_outlined,
    this.text,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CoffeeTheme.coffeeLight.withOpacity(0.3),
            CoffeeTheme.coffeeCream.withOpacity(0.5),
          ],
        ),
        borderRadius:
            borderRadius ?? BorderRadius.circular(CoffeeTheme.smallRadius),
        border: Border.all(
          color: CoffeeTheme.coffeeLight.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: CoffeeTheme.coffeeMain.withOpacity(0.6),
            size: (width != null && width! < 80) ? 20 : 32,
          ),
          if (text != null) ...[
            SizedBox(height: 4),
            Text(
              text!,
              style: TextStyle(
                color: CoffeeTheme.coffeeMain.withOpacity(0.6),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class CoffeeNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? placeholderText;
  final IconData placeholderIcon;
  final String? productName; // New parameter for smart asset selection

  const CoffeeNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderText,
    this.placeholderIcon = Icons.local_cafe,
    this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If no image URL or empty, show asset-based placeholder if we have a product name
    if (imageUrl == null || imageUrl!.isEmpty) {
      if (productName != null) {
        final assetPath = CoffeePlaceholders.getAssetForProduct(productName!);
        return AssetPlaceholderImage(
          width: width,
          height: height,
          assetPath: assetPath,
          borderRadius: borderRadius,
        );
      }
      return PlaceholderImage(
        width: width,
        height: height,
        icon: placeholderIcon,
        text: placeholderText ?? 'No Image',
        borderRadius: borderRadius,
      );
    }

    // For web, show asset-based placeholder due to CORS issues
    if (kIsWeb && WebImageConfig.shouldShowPlaceholderForWeb) {
      if (productName != null) {
        final assetPath = CoffeePlaceholders.getAssetForProduct(productName!);
        return AssetPlaceholderImage(
          width: width,
          height: height,
          assetPath: assetPath,
          borderRadius: borderRadius,
        );
      }
      return PlaceholderImage(
        width: width,
        height: height,
        icon: placeholderIcon,
        text: placeholderText ?? 'Image preview\nunavailable on web',
        borderRadius: borderRadius,
      );
    }

    final webSafeUrl = WebImageConfig.getWebSafeImageUrl(imageUrl!);

    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.circular(CoffeeTheme.smallRadius),
      child: Image.network(
        webSafeUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: CoffeeTheme.coffeeCream.withOpacity(0.3),
              borderRadius: borderRadius,
            ),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(CoffeeTheme.coffeeMain),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          // Show asset-based placeholder when image fails to load
          if (productName != null) {
            final assetPath =
                CoffeePlaceholders.getAssetForProduct(productName!);
            return AssetPlaceholderImage(
              width: width,
              height: height,
              assetPath: assetPath,
              borderRadius: borderRadius,
            );
          }
          return PlaceholderImage(
            width: width,
            height: height,
            icon: placeholderIcon,
            text: placeholderText ?? 'Image unavailable',
            borderRadius: borderRadius,
          );
        },
      ),
    );
  }
}

class AssetPlaceholderImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String assetPath;
  final BorderRadius? borderRadius;

  const AssetPlaceholderImage({
    Key? key,
    this.width,
    this.height,
    required this.assetPath,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.circular(CoffeeTheme.smallRadius),
      child: Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return PlaceholderImage(
            width: width,
            height: height,
            icon: Icons.local_cafe,
            text: 'Coffee',
            borderRadius: borderRadius,
          );
        },
      ),
    );
  }
}
