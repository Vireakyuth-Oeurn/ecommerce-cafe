import 'dart:convert';

void main() {
  // Simulate the problematic address parsing
  print('Testing Address parsing...');

  // Test case 1: Direct address object (from ecom_place_save)
  final addressJson1 = {
    'address': 'Street 51',
    'phone_number': '+855',
    'note': null,
    'user': {'fullname': 'Nung', 'phone_number': '+85593211943'}
  };

  print('Test 1 - ecom_place_save structure:');
  testAddressParsing(addressJson1);

  // Test case 2: Shop address structure (from ecom_shop_chanel.address)
  final addressJson2 = {
    'house_number': 'E01',
    'street_number': 'a',
    'post_code': '12500',
    'province': null,
    'district': null
  };

  print('\nTest 2 - shop address structure:');
  testAddressParsing(addressJson2);
}

void testAddressParsing(Map<String, dynamic> json) {
  try {
    print('Input JSON: $json');

    // Handle both direct address fields and nested address object
    final addressData = json['address'] as Map<String, dynamic>? ?? json;
    print('Address data: $addressData');

    final street = (json['address'] ?? '').toString();
    final houseNumber = (addressData['house_number'] ?? '').toString();
    final streetNumber = (addressData['street_number'] ?? '').toString();
    final postCode = (addressData['post_code'] ?? '').toString();
    final note = (json['note'] ?? '').toString();
    final phone = (json['phone_number'] ?? '').toString();

    print('✅ Parsed successfully:');
    print('  Street: "$street"');
    print('  House Number: "$houseNumber"');
    print('  Street Number: "$streetNumber"');
    print('  Post Code: "$postCode"');
    print('  Note: "$note"');
    print('  Phone: "$phone"');
  } catch (e) {
    print('❌ Error parsing address: $e');
  }
}
