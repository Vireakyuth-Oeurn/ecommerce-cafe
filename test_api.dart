import 'dart:convert';
import 'dart:io';

void main() async {
  print('Testing API Connection...');

  const String baseUrl = 'https://sme.sosme.api.elitevigour.com';
  const String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo0OTA4MjIwNzAzLCJqdGkiOiIyNTljZjgxOTM1OWQ0YWIwOWNiODViMDViODQ2OWExYSIsInVzZXJfaWQiOjU2LCJsYW5nIjoiZW4ifQ.Y8zmpxCDqfjWiau6zzpCyRRFEQF3Vk38oEBZoq5XwXs';

  final client = HttpClient();

  try {
    // Test 1: Get Purchase Status List
    print('\n=== Testing Purchase Status List ===');
    final statusRequest = await client.getUrl(
      Uri.parse(
        '$baseUrl/api/v3/public/ecom-purchase-status/get-list?language_code=EN',
      ),
    );
    statusRequest.headers.set('Authorization', 'Bearer $token');
    statusRequest.headers.set('Content-Type', 'application/json');

    final statusResponse = await statusRequest.close();
    final statusResponseBody = await statusResponse
        .transform(utf8.decoder)
        .join();

    print('Status Code: ${statusResponse.statusCode}');
    print('Response: $statusResponseBody');

    // Test 2: Get Order Details
    print('\n=== Testing Order Details (ID: 120) ===');
    final orderRequest = await client.getUrl(
      Uri.parse(
        '$baseUrl/api/v3/public/ecom-purchase-records/get-detail?language_code=EN&ecom_purchase_records_id=120',
      ),
    );
    orderRequest.headers.set('Authorization', 'Bearer $token');
    orderRequest.headers.set('Content-Type', 'application/json');

    final orderResponse = await orderRequest.close();
    final orderResponseBody = await orderResponse
        .transform(utf8.decoder)
        .join();

    print('Status Code: ${orderResponse.statusCode}');
    print('Response: $orderResponseBody');
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}
