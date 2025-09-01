import 'package:flutter/material.dart';
import '../theme/coffee_theme.dart';

class CoffeeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool hasGradient;
  final double elevation;

  const CoffeeAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.hasGradient = true,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: hasGradient
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CoffeeTheme.coffeeMain,
                  CoffeeTheme.coffeeDark,
                ],
              ),
            )
          : null,
      child: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor:
            hasGradient ? Colors.transparent : CoffeeTheme.coffeeMain,
        foregroundColor: Colors.white,
        centerTitle: centerTitle,
        elevation: elevation,
        leading: leading,
        actions: actions,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
