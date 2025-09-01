import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order_models.dart';
import '../services/api_service.dart';
import '../theme/coffee_theme.dart';
import '../widgets/coffee_app_bar.dart';
import '../widgets/coffee_network_image.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  OrderDetail? orderDetail;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadOrderDetails();
  }

  Future<void> loadOrderDetails() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final detail = await ApiService.getOrderDetail(widget.orderId);
      setState(() {
        orderDetail = detail;
        isLoading = false;
        if (detail == null) {
          error = 'Failed to load order details';
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        error = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoffeeTheme.coffeeBackground,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(child: _buildBody()),
        ],
      ),
      bottomNavigationBar: orderDetail != null ? _buildBottomActions() : null,
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      leading: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(CoffeeTheme.smallRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(CoffeeTheme.smallRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.share_outlined,
                size: 20, color: CoffeeTheme.coffeeMain),
            onPressed: () {
              // Share functionality
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 8, 16, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(CoffeeTheme.smallRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.refresh, size: 20, color: CoffeeTheme.coffeeMain),
            onPressed: loadOrderDetails,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: orderDetail != null
            ? Text(
                'Order ${orderDetail!.purchaseNumber}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              )
            : Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                CoffeeTheme.coffeeBackground,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Container(
        height: MediaQuery.of(context).size.height - 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(CoffeeTheme.coffeeMain),
              ),
              SizedBox(height: 16),
              Text(
                'Loading order details...',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (error != null) {
      return Container(
        height: MediaQuery.of(context).size.height - 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                error!,
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: loadOrderDetails,
                icon: Icon(Icons.refresh),
                label: Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoffeeTheme.coffeeMain,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(CoffeeTheme.smallRadius),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (orderDetail == null) {
      return Container(
        height: MediaQuery.of(context).size.height - 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No order details found',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        _buildOrderStatusCard(),
        _buildOrderSummaryCard(),
        _buildOrderItemsCard(),
        _buildShippingCard(),
        _buildCustomerCard(),
        _buildPaymentCard(),
        _buildOrderTrackingCard(),
        SizedBox(height: 100), // Bottom padding for actions
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(CoffeeTheme.cardRadius),
          topRight: Radius.circular(CoffeeTheme.cardRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Track order functionality
                },
                icon: Icon(Icons.local_shipping_outlined),
                label: Text('Track Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoffeeTheme.coffeeMain,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(CoffeeTheme.buttonRadius),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Reorder functionality
                },
                icon: Icon(Icons.refresh),
                label: Text('Reorder'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: CoffeeTheme.coffeeMain,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(CoffeeTheme.buttonRadius),
                  ),
                  side: BorderSide(color: CoffeeTheme.coffeeMain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusCard() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CoffeeTheme.coffeeMain,
            CoffeeTheme.coffeeDark,
          ],
        ),
        borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        boxShadow: [
          BoxShadow(
            color: CoffeeTheme.coffeeMain.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Status',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      orderDetail!.status,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius:
                        BorderRadius.circular(CoffeeTheme.buttonRadius),
                  ),
                  child: Icon(
                    _getStatusIcon(orderDetail!.status),
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(CoffeeTheme.buttonRadius),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Date',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy')
                              .format(orderDetail!.orderDate),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 30, color: Colors.white30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Items',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${orderDetail!.items.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 30, color: Colors.white30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${orderDetail!.currency} ${orderDetail!.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long, color: CoffeeTheme.coffeeMain, size: 24),
              SizedBox(width: 12),
              Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildSummaryRow('Subtotal',
              '${orderDetail!.currency} ${(orderDetail!.totalAmount - orderDetail!.vat).toStringAsFixed(2)}'),
          if (orderDetail!.vat > 0) ...[
            SizedBox(height: 8),
            _buildSummaryRow('VAT',
                '${orderDetail!.currency} ${orderDetail!.vat.toStringAsFixed(2)}'),
          ],
          SizedBox(height: 8),
          _buildSummaryRow('Delivery Fee', '${orderDetail!.currency} 0.00'),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                '${orderDetail!.currency} ${orderDetail!.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: CoffeeTheme.coffeeMain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItemsCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.shopping_bag_outlined,
                    color: CoffeeTheme.coffeeMain, size: 24),
                SizedBox(width: 12),
                Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  ' (${orderDetail!.items.length})',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          ...orderDetail!.items.asMap().entries.map((entry) {
            int index = entry.key;
            OrderItem item = entry.value;
            return Column(
              children: [
                if (index > 0) Divider(height: 1, indent: 20, endIndent: 20),
                _buildOrderItem(item),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          CoffeeNetworkImage(
            imageUrl: item.imageUrl != null && item.imageUrl!.isNotEmpty
                ? ApiService.getImageUrl(item.imageUrl)
                : null,
            productName: item.name,
            width: 80,
            height: 80,
            borderRadius: BorderRadius.circular(CoffeeTheme.smallRadius),
            placeholderIcon: Icons.local_cafe,
            placeholderText: 'Coffee',
          ),
          SizedBox(width: 16),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.description.isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: 8),
                Row(
                  children: [
                    if (item.size.isNotEmpty) ...[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: CoffeeTheme.coffeeMain.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Size: ${item.size}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: CoffeeTheme.coffeeMain,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Qty: ${item.quantity}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (item.discountPrice < (item.total / item.quantity)) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${orderDetail!.currency} ${item.discountPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: CoffeeTheme.coffeeMain,
                            ),
                          ),
                          Text(
                            '${orderDetail!.currency} ${(item.total / item.quantity).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Text(
                        '${orderDetail!.currency} ${item.discountPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CoffeeTheme.coffeeMain,
                        ),
                      ),
                    ],
                    Text(
                      '${orderDetail!.currency} ${item.total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_shipping_outlined,
                  color: CoffeeTheme.coffeeMain, size: 24),
              SizedBox(width: 12),
              Text(
                'Shipping Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildInfoItem(
            Icons.location_on_outlined,
            'Delivery Address',
            orderDetail!.deliveryAddress.fullAddress,
          ),
          SizedBox(height: 12),
          _buildInfoItem(
            Icons.local_shipping,
            'Delivery Method',
            orderDetail!.deliveryMode,
          ),
          if (orderDetail!.shop.name.isNotEmpty) ...[
            SizedBox(height: 12),
            _buildInfoItem(
              Icons.store,
              'Shop',
              '${orderDetail!.shop.name} ${orderDetail!.shop.isVerified ? '✓ Verified' : ''}',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomerCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline,
                  color: CoffeeTheme.coffeeMain, size: 24),
              SizedBox(width: 12),
              Text(
                'Customer Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildInfoItem(
            Icons.person,
            'Name',
            orderDetail!.customerName,
          ),
          SizedBox(height: 12),
          _buildInfoItem(
            Icons.email_outlined,
            'Email',
            orderDetail!.customerEmail,
          ),
          SizedBox(height: 12),
          _buildInfoItem(
            Icons.phone_outlined,
            'Phone',
            orderDetail!.customerPhone,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: CoffeeTheme.coffeeMain, size: 24),
              SizedBox(width: 12),
              Text(
                'Payment Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildInfoItem(
            Icons.credit_card,
            'Payment Method',
            orderDetail!.paymentMethod,
          ),
          SizedBox(height: 12),
          _buildInfoItem(
            Icons.check_circle_outline,
            'Payment Status',
            orderDetail!.paymentStatus,
          ),
          if (orderDetail!.notes.isNotEmpty) ...[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    orderDetail!.notes,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderTrackingCard() {
    if (orderDetail!.activityRecords.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: CoffeeTheme.coffeeMain, size: 24),
              SizedBox(width: 12),
              Text(
                'Order Tracking',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...orderDetail!.activityRecords.asMap().entries.map((entry) {
            int index = entry.key;
            ActivityRecord record = entry.value;
            bool isLatest = index == 0;
            bool isLast = index == orderDetail!.activityRecords.length - 1;

            return _buildTimelineItem(record, isLatest, isLast);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(ActivityRecord record, bool isLatest, bool isLast) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isLatest ? CoffeeTheme.coffeeMain : Colors.grey[400],
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.grey[300],
                  margin: EdgeInsets.symmetric(vertical: 4),
                ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.status,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: isLatest ? CoffeeTheme.coffeeMain : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'by ${record.actionBy}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy at HH:mm').format(record.actionAt),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  if (record.remark != null && record.remark!.isNotEmpty) ...[
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        record.remark!,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CoffeeTheme.coffeeMain.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: CoffeeTheme.coffeeMain,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule;
      case 'accepted by store':
        return Icons.check_circle_outline;
      case 'ready to pickup':
        return Icons.inventory_2_outlined;
      case 'picked-up':
      case 'picked up by delivery':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.check_circle;
      case 'cancel order':
      case 'rejected by store':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }
}
