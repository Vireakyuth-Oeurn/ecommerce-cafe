import 'package:flutter/material.dart';
import 'screens/order_details_screen.dart';
import 'widgets/coffee_home_screen.dart';
import 'theme/coffee_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Order Manager',
      theme: CoffeeTheme.themeData,
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CoffeeHomeScreen(
      onNavigateToOrderDetails: (orderId) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(orderId: orderId),
          ),
        );
      },
    );
  }
}
