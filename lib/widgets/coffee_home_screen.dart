import 'package:flutter/material.dart';
import '../theme/coffee_theme.dart';
import '../widgets/coffee_app_bar.dart';
import '../widgets/coffee_icon.dart';
import '../widgets/coffee_button.dart';
import '../widgets/coffee_text_field.dart';
import '../widgets/coffee_card.dart';

class CoffeeHomeScreen extends StatefulWidget {
  final Function(int) onNavigateToOrderDetails;

  const CoffeeHomeScreen({
    Key? key,
    required this.onNavigateToOrderDetails,
  }) : super(key: key);

  @override
  State<CoffeeHomeScreen> createState() => _CoffeeHomeScreenState();
}

class _CoffeeHomeScreenState extends State<CoffeeHomeScreen> {
  final TextEditingController _orderIdController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Set default order ID for testing
    _orderIdController.text = '120';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoffeeTheme.coffeeBackground,
      appBar: CoffeeAppBar(
        title: 'Order Management',
        hasGradient: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Coffee icon with animation
            _buildHeroSection(),
            SizedBox(height: 40),
            // Order input section
            _buildOrderInputSection(),
            SizedBox(height: 30),
            // Quick actions section
            _buildQuickActionsSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      children: [
        CoffeeIcon(size: 120),
        SizedBox(height: 24),
        Text(
          'Coffee Order Manager',
          style: CoffeeTheme.titleLarge.copyWith(
            fontSize: 26,
            color: CoffeeTheme.coffeeDark,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Enter an order ID to view detailed information',
          style: CoffeeTheme.bodyMedium.copyWith(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOrderInputSection() {
    return CoffeeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.search,
                color: CoffeeTheme.coffeeMain,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Find Your Order',
                style: CoffeeTheme.titleMedium.copyWith(
                  color: CoffeeTheme.coffeeDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          CoffeeTextField(
            controller: _orderIdController,
            labelText: 'Order ID',
            hintText: 'Enter your order number (e.g., 120)',
            prefixIcon: Icons.receipt_long,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an order ID';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          CoffeeButton(
            text: 'View Order Details',
            icon: Icons.visibility,
            isLoading: _isLoading,
            onPressed: _handleViewOrderDetails,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Quick Actions',
            style: CoffeeTheme.titleMedium.copyWith(
              color: CoffeeTheme.coffeeDark,
            ),
          ),
        ),
        SizedBox(height: 16),
        CoffeeInfoCard(
          title: 'Test API Connection',
          subtitle: 'Verify server connectivity',
          icon: Icons.wifi_tethering,
          iconColor: Colors.green[600],
          onTap: _showApiTestDialog,
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 16,
          ),
        ),
        SizedBox(height: 8),
        CoffeeInfoCard(
          title: 'Sample Orders',
          subtitle: 'Try order IDs: 120, 121, 122',
          icon: Icons.list_alt,
          iconColor: Colors.blue[600],
          onTap: _showSampleOrders,
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 16,
          ),
        ),
        SizedBox(height: 8),
        CoffeeInfoCard(
          title: 'About',
          subtitle: 'App version and information',
          icon: Icons.info_outline,
          iconColor: Colors.purple[600],
          onTap: _showAboutDialog,
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 16,
          ),
        ),
      ],
    );
  }

  void _handleViewOrderDetails() async {
    final orderIdText = _orderIdController.text.trim();
    if (orderIdText.isEmpty) {
      _showErrorSnackBar('Please enter an order ID');
      return;
    }

    final orderId = int.tryParse(orderIdText);
    if (orderId == null) {
      _showErrorSnackBar('Please enter a valid order ID');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Add a small delay for better UX
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      _isLoading = false;
    });

    widget.onNavigateToOrderDetails(orderId);
  }

  void _showApiTestDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        ),
        title: Row(
          children: [
            Icon(Icons.wifi_tethering, color: CoffeeTheme.coffeeMain),
            SizedBox(width: 12),
            Text('API Connection Test'),
          ],
        ),
        content: Text(
          'This will test the connection to the SOSME API server to ensure everything is working properly.',
          style: CoffeeTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          CoffeeButton(
            text: 'Test Connection',
            width: 140,
            height: 40,
            onPressed: () async {
              Navigator.pop(context);
              await _performApiTest();
            },
          ),
        ],
      ),
    );
  }

  void _showSampleOrders() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        ),
        title: Row(
          children: [
            Icon(Icons.list_alt, color: CoffeeTheme.coffeeMain),
            SizedBox(width: 12),
            Text('Sample Orders'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Try these sample order IDs:',
              style: CoffeeTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            _buildSampleOrderItem('120', 'Complete order with items'),
            _buildSampleOrderItem('121', 'Processing order'),
            _buildSampleOrderItem('122', 'Delivered order'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleOrderItem(String orderId, String description) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        _orderIdController.text = orderId;
        _handleViewOrderDetails();
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: CoffeeTheme.coffeeMain.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  orderId,
                  style: TextStyle(
                    color: CoffeeTheme.coffeeMain,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #$orderId',
                    style: CoffeeTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: CoffeeTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        ),
        title: Row(
          children: [
            CoffeeIcon(size: 32),
            SizedBox(width: 12),
            Text('About'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coffee Order Manager',
              style: CoffeeTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'Version 1.0.0',
              style: CoffeeTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Text(
              'A modern Flutter application for managing and viewing order details with a beautiful coffee-themed design.',
              style: CoffeeTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _performApiTest() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CoffeeCard(
          margin: EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(CoffeeTheme.coffeeMain),
              ),
              SizedBox(height: 16),
              Text(
                'Testing API connection...',
                style: CoffeeTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );

    try {
      // Simulate API test
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context); // Close loading

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('API connection successful!'),
            ],
          ),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoffeeTheme.smallRadius),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      Navigator.pop(context); // Close loading
      _showErrorSnackBar('API connection failed: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CoffeeTheme.smallRadius),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _orderIdController.dispose();
    super.dispose();
  }
}
