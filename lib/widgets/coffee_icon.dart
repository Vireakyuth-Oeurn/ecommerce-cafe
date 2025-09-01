import 'package:flutter/material.dart';
import '../theme/coffee_theme.dart';

class CoffeeIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const CoffeeIcon({
    Key? key,
    this.size = 80,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CoffeeTheme.coffeeMain,
            CoffeeTheme.coffeeDark,
          ],
        ),
        borderRadius: BorderRadius.circular(size * 0.2),
        boxShadow: [
          BoxShadow(
            color: CoffeeTheme.coffeeMain.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.local_cafe,
        size: size * 0.5,
        color: color ?? Colors.white,
      ),
    );
  }
}
