import 'lib/models/order_models.dart';

void main() {
  print('Testing fixed Address parsing...\n');

  // Test case 1: ecom_place_save structure (address is a string)
  final addressJson1 = {
    'address': 'Street 51',
    'phone_number': '+855',
    'note': null,
  };

  print('Test 1 - ecom_place_save structure (address as string):');
  testAddressParsing(addressJson1);

  // Test case 2: Shop address structure (direct fields)
  final addressJson2 = {
    'house_number': 'E01',
    'street_number': 'a',
    'post_code': '12500',
    'province': null,
    'district': null
  };

  print('\nTest 2 - shop address structure (direct fields):');
  testAddressParsing(addressJson2);

  // Test case 3: Nested address object
  final addressJson3 = {
    'address': {
      'house_number': 'B123',
      'street_number': '15',
      'post_code': '12000'
    },
    'note': 'Special delivery',
    'phone_number': '+85512345678'
  };

  print('\nTest 3 - nested address object:');
  testAddressParsing(addressJson3);
}

void testAddressParsing(Map<String, dynamic> json) {
  try {
    print('Input JSON: $json');

    final address = Address.fromJson(json);

    print('✅ Parsed successfully:');
    print('  Street: "${address.street}"');
    print('  House Number: "${address.houseNumber}"');
    print('  Street Number: "${address.streetNumber}"');
    print('  Post Code: "${address.postCode}"');
    print('  Note: "${address.note}"');
    print('  Phone: "${address.phone}"');
    print('  Full Address: "${address.fullAddress}"');
  } catch (e) {
    print('❌ Error parsing address: $e');
  }
}
