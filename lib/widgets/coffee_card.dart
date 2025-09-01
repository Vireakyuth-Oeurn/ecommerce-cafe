import 'package:flutter/material.dart';
import '../theme/coffee_theme.dart';

class CoffeeCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final bool hasBorder;
  final Color? borderColor;
  final double borderWidth;

  const CoffeeCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.boxShadow,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: padding ?? EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius:
            BorderRadius.circular(borderRadius ?? CoffeeTheme.cardRadius),
        boxShadow: boxShadow ?? CoffeeTheme.cardShadow,
        border: hasBorder
            ? Border.all(
                color: borderColor ?? CoffeeTheme.coffeeLight,
                width: borderWidth,
              )
            : null,
      ),
      child: child,
    );
  }
}

class CoffeeInfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const CoffeeInfoCard({
    Key? key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.trailing,
    this.onTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CoffeeCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (iconColor ?? CoffeeTheme.coffeeMain).withOpacity(0.1),
                borderRadius: BorderRadius.circular(CoffeeTheme.smallRadius),
              ),
              child: Icon(
                icon,
                color: iconColor ?? CoffeeTheme.coffeeMain,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CoffeeTheme.titleMedium.copyWith(fontSize: 16),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: CoffeeTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
