import 'package:flutter/material.dart';
import '../theme/coffee_theme.dart';

class CoffeeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final double? width;
  final double? height;

  const CoffeeButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.width,
    this.height = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: isOutlined
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CoffeeTheme.coffeeMain,
                  CoffeeTheme.coffeeDark,
                ],
              ),
        border: isOutlined
            ? Border.all(
                color: CoffeeTheme.coffeeMain,
                width: 2,
              )
            : null,
        borderRadius: BorderRadius.circular(CoffeeTheme.buttonRadius),
        boxShadow: isOutlined ? null : CoffeeTheme.buttonShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(CoffeeTheme.buttonRadius),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        isOutlined ? CoffeeTheme.coffeeMain : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                ],
                if (icon != null && !isLoading) ...[
                  Icon(
                    icon,
                    color: isOutlined ? CoffeeTheme.coffeeMain : Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isOutlined ? CoffeeTheme.coffeeMain : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
