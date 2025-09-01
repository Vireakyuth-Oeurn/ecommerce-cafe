import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_models.dart';

class ApiService {
  static const String baseUrl = 'https://sme.sosme.api.elitevigour.com';
  static const String fileBaseUrl = 'https://sme.sosme.file.elitevigour.com';
  static const String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo0OTA4MjIwNzAzLCJqdGkiOiIyNTljZjgxOTM1OWQ0YWIwOWNiODViMDViODQ2OWExYSIsInVzZXJfaWQiOjU2LCJsYW5nIjoiZW4ifQ.Y8zmpxCDqfjWiau6zzpCyRRFEQF3Vk38oEBZoq5XwXs';

  static Map<String, String> get headers => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  /// Get order details by ID
  static Future<OrderDetail?> getOrderDetail(
    int orderId, {
    String languageCode = 'EN',
  }) async {
    try {
      final url = Uri.parse(
        '$baseUrl/api/v3/public/ecom-purchase-records/get-detail?language_code=$languageCode&ecom_purchase_records_id=$orderId',
      );

      print('Fetching order details from: $url');
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Handle the actual API response structure
        if (jsonData['data'] != null && jsonData['data']['results'] != null) {
          print('API Response received, parsing order details...');
          try {
            return OrderDetail.fromJson(jsonData['data']['results']);
          } catch (parseError) {
            print('Error parsing OrderDetail: $parseError');
            print('Raw data: ${jsonData['data']['results']}');
            return null;
          }
        } else {
          print('Unexpected response structure: $jsonData');
          return null;
        }
      } else {
        print('Failed to load order details: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching order details: $e');
      return null;
    }
  }

  /// Get list of purchase statuses
  static Future<List<PurchaseStatus>> getPurchaseStatusList({
    String languageCode = 'EN',
  }) async {
    try {
      final url = Uri.parse(
        '$baseUrl/api/v3/public/ecom-purchase-status/get-list?language_code=$languageCode',
      );

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Handle the actual API response structure
        if (jsonData['data'] != null && jsonData['data']['results'] != null) {
          final List<dynamic> statusList = jsonData['data']['results'];
          return statusList
              .map((status) => PurchaseStatus.fromJson(status))
              .toList();
        } else {
          print('Unexpected response structure: $jsonData');
          return [];
        }
      } else {
        print('Failed to load purchase status list: ${response.statusCode}');
        print('Response body: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching purchase status list: $e');
      return [];
    }
  }

  /// Get full image URL with CORS handling for web
  static String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return '';
    }

    if (imagePath.startsWith('http')) {
      return imagePath;
    }

    // For web, we'll use a CORS proxy or return empty to show placeholder
    final fullUrl = '$fileBaseUrl$imagePath';

    // In web environment, we might need to use a CORS proxy
    // For now, return the direct URL and let the image widget handle errors
    return fullUrl;
  }

  /// Check if image URL is accessible (for future CORS detection)
  static Future<bool> isImageAccessible(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl), headers: headers);
      return response.statusCode == 200;
    } catch (e) {
      print('Image accessibility check failed: $e');
      return false;
    }
  }

  /// Test API connection
  static Future<bool> testConnection() async {
    try {
      // Test with a simple request
      final response = await getPurchaseStatusList();
      return response.isNotEmpty;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }
}
