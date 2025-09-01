import 'lib/models/order_models.dart';
import 'lib/services/api_service.dart';

void main() async {
  print('Testing JSON parsing...');

  try {
    print('Fetching order details...');
    final orderDetail = await ApiService.getOrderDetail(22);

    if (orderDetail != null) {
      print('✅ Order parsed successfully!');
      print('Order ID: ${orderDetail.id}');
      print('Purchase Number: ${orderDetail.purchaseNumber}');
      print('Status: ${orderDetail.status}');
      print('Customer: ${orderDetail.customerName}');
      print('Delivery Address: ${orderDetail.deliveryAddress.fullAddress}');
      print('Items count: ${orderDetail.items.length}');
    } else {
      print('❌ Order detail is null');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}
