import 'lib/models/order_models.dart';

void main() {
  print('Testing Address parsing only...');

  // Test with the actual JSON structure from the API
  final testJson = {
    'id': 77,
    'user': {'id': 509, 'fullname': 'Nung', 'phone_number': '+85593211943'},
    'note': null,
    'address': 'Street 51', // This is a STRING, not an object
    'phone_number': '+855'
  };

  try {
    print('Parsing address from: $testJson');
    final address = Address.fromJson(testJson);
    print('✅ Success!');
    print('Street: "${address.street}"');
    print('House Number: "${address.houseNumber}"');
    print('Phone: "${address.phone}"');
    print('Full Address: "${address.fullAddress}"');
  } catch (e) {
    print('❌ Error: $e');
  }
}
