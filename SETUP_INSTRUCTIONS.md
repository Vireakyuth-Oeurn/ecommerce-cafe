# Flutter Order Details App - Complete Setup Guide

## 📋 API Analysis Summary

### ✅ API Endpoints Tested Successfully

**1. Purchase Status List**
- **URL**: `GET /api/v3/public/ecom-purchase-status/get-list?language_code=EN`
- **Status**: ✅ Working (200 OK)
- **Response Structure**:
```json
{
  "data": {
    "results": [
      {
        "id": 1,
        "ecom_purchase_status_ref": {"id": 1, "code": "PENDING"},
        "name": "Pending",
        "language_code": "EN"
      },
      // ... more statuses
    ]
  }
}
```

**2. Order Details**
- **URL**: `GET /api/v3/public/ecom-purchase-records/get-detail?language_code=EN&ecom_purchase_records_id=120`
- **Status**: ✅ Working (200 OK)
- **Response Structure**: Complex nested object with order details, items, shop info, customer data, etc.

### 🔑 Authentication
- **Type**: Bearer Token
- **Header**: `Authorization: Bearer <token>`
- **Token**: Valid and working ✅

## 🏗️ Project Structure

```
flutter_order_app/
├── lib/
│   ├── main.dart                         # App entry point with home screen
│   ├── models/
│   │   └── order_models.dart            # Data models (OrderDetail, OrderItem, Shop, etc.)
│   ├── services/
│   │   └── api_service.dart             # API service layer with HTTP calls
│   └── screens/
│       └── order_details_screen.dart    # Order details UI screen
├── pubspec.yaml                         # Dependencies configuration
├── test_api.dart                        # Dart API test script
├── test_api.ps1                         # PowerShell API test script
└── README.md                           # Documentation
```

## 🚀 Setup Instructions

### Step 1: Install Flutter
1. Download Flutter SDK from [flutter.dev](https://flutter.dev/docs/get-started/install)
2. Extract and add to PATH
3. Run `flutter doctor` to verify installation

### Step 2: Create Flutter Project
```bash
# Create new Flutter project
flutter create flutter_order_app
cd flutter_order_app

# Replace the generated files with our custom implementation
# Copy all files from the generated project to your Flutter project directory
```

### Step 3: Update Dependencies
Replace the content of `pubspec.yaml` with:

```yaml
name: flutter_order_app
description: A Flutter application for viewing order details

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.0.0"

dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  provider: ^6.0.5
  intl: ^0.18.1
  cached_network_image: ^3.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
```

Then run:
```bash
flutter pub get
```

### Step 4: Copy Project Files
Copy all the generated files to your Flutter project:

1. `lib/main.dart` - Main app entry point
2. `lib/models/order_models.dart` - Data models
3. `lib/services/api_service.dart` - API service
4. `lib/screens/order_details_screen.dart` - Order details screen

### Step 5: Run the Application
```bash
# For Android emulator
flutter run

# For Chrome (web)
flutter run -d chrome

# For Windows (if enabled)
flutter run -d windows
```

## 📱 App Features

### Home Screen
- Input field for order ID
- Default order ID (120) for testing
- Navigation to order details
- API connection test functionality

### Order Details Screen
- **Order Header**: Order number, status, date, payment method
- **Customer Information**: Name, email, phone
- **Delivery Information**: Address, delivery mode
- **Shop Information**: Shop details, rating, verification status
- **Order Items**: Product list with images, prices, quantities
- **Order Summary**: Total amount, VAT, notes
- **Activity Timeline**: Order status change history
- **Interactive Features**: Pull-to-refresh, error handling, loading states

### Data Models
- `OrderDetail`: Main order information
- `OrderItem`: Individual product items
- `Shop`: Shop/store information
- `Address`: Delivery address details
- `ActivityRecord`: Order status timeline
- `PurchaseStatus`: Available order statuses

## 🔧 Customization

### Testing Different Order IDs
1. Change the default order ID in `lib/main.dart` line 33:
```dart
_orderIdController.text = '120'; // Change this to test different orders
```

2. Or simply enter a different ID in the app's input field

### API Configuration
Update API settings in `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'https://sme.sosme.api.elitevigour.com';
static const String fileBaseUrl = 'https://sme.sosme.file.elitevigour.com';
static const String token = 'your_token_here';
```

### UI Customization
- Colors: Modify color schemes in the screens
- Layout: Adjust card layouts and spacing
- Typography: Change text styles and fonts
- Images: Update placeholder handling for product images

## 🧪 Testing

### API Testing (PowerShell)
```powershell
cd flutter_order_app
.\test_api.ps1
```

### API Testing (Dart)
```bash
cd flutter_order_app
dart test_api.dart
```

### Flutter Testing
```bash
flutter test
```

## 📝 API Response Mapping

The app handles the complex API response structure by mapping:

**API Field** → **App Model**
- `data.results` → `OrderDetail`
- `ecom_purchase_records_items` → `List<OrderItem>`
- `ecom_shop_chanel` → `Shop`
- `ecom_place_save` → `Address`
- `ecom_purchase_activity_record` → `List<ActivityRecord>`
- `purchase_by` → Customer information
- `ecom_payment_mean` → Payment method
- `ecom_delivery_mode` → Delivery mode

## 🎯 Next Steps

1. **Test API Endpoints**: Verify both endpoints work with your environment
2. **Flutter Setup**: Install Flutter SDK and create project
3. **Copy Files**: Move all generated files to your Flutter project
4. **Install Dependencies**: Run `flutter pub get`
5. **Run App**: Test with `flutter run`
6. **Customize**: Modify according to your needs

## 🐛 Troubleshooting

### Common Issues

1. **API Token Expired**
   - Check if API calls return 401 Unauthorized
   - Update token in `api_service.dart`

2. **Order Not Found**
   - Verify order ID exists
   - Check API response for error messages

3. **Image Loading Issues**
   - Verify file base URL is correct
   - Check network permissions

4. **Flutter Build Issues**
   - Run `flutter clean` then `flutter pub get`
   - Check Flutter doctor for missing dependencies

### Debug Mode
Enable debug mode by adding print statements in `api_service.dart` to see raw API responses.

## 📞 Support

For issues with:
- **API**: Check server status and authentication
- **Flutter**: Refer to Flutter documentation
- **App Logic**: Review the model mapping in `order_models.dart`

The app is designed to be robust and handle various API response formats gracefully.
