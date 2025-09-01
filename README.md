# ☕ Coffee-Themed Ecommerce Flutter App

A beautiful, modern Flutter ecommerce application with coffee-themed design for viewing order details using the SOSME API.

## 🎨 Features

- **Coffee-Themed Design**: Beautiful brown color palette with consistent styling
- **Modern Ecommerce UI**: Professional order details and home screens
- **Smart Image Loading**: Local asset fallbacks for CORS-blocked images
- **Modular Architecture**: Well-organized, maintainable code structure
- **Responsive Design**: Works perfectly on web, mobile, and desktop

## 📱 App Screenshots

The app features:
- ☕ Coffee-themed home screen with gradient backgrounds
- 📋 Detailed order view with product images and information
- 🖼️ Smart image loading with local coffee/cake asset fallbacks
- 🎯 Consistent UI components and styling throughout

## 🚀 Quick Start

### Prerequisites

Make sure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0 or higher)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Chrome Browser](https://www.google.com/chrome/) (for web development)
- [Git](https://git-scm.com/) (optional, for version control)

### 🛠️ Installation & Setup

1. **Navigate to the project directory:**
   ```bash
   cd "f:\DR.Sophea project\flutter_order_app"
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Enable web support (if not already enabled):**
   ```bash
   flutter create .
   ```

4. **Run the app:**
   ```bash
   # Run on Chrome (recommended for development)
   flutter run -d chrome
   
   # Or run on any connected device
   flutter run
   
   # Or run in debug mode with hot reload
   flutter run --debug
   ```

### 🎯 Available Run Commands

```bash
# Web Development (recommended)
flutter run -d chrome                    # Run on Chrome browser
flutter run -d chrome --release          # Run optimized release build
flutter run -d chrome --web-port=8080    # Run on specific port

# Mobile Development
flutter run -d android                   # Run on Android device/emulator
flutter run -d ios                       # Run on iOS device/simulator

# Desktop Development
flutter run -d windows                   # Run on Windows desktop
flutter run -d macos                     # Run on macOS desktop
flutter run -d linux                     # Run on Linux desktop

# Development Tools
flutter run --hot                        # Enable hot reload
flutter run --verbose                    # Verbose output for debugging
```

## 🏗️ Project Architecture

```
flutter_order_app/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── theme/
│   │   └── coffee_theme.dart              # Centralized theme system
│   ├── models/
│   │   └── order_models.dart              # Data models
│   ├── services/
│   │   └── api_service.dart               # API service layer
│   ├── screens/
│   │   └── order_details_screen.dart      # Order details UI
│   ├── widgets/                           # Reusable UI components
│   │   ├── coffee_app_bar.dart            # Coffee-themed app bar
│   │   ├── coffee_button.dart             # Styled buttons
│   │   ├── coffee_card.dart               # Container cards
│   │   ├── coffee_home_screen.dart        # Modern home screen
│   │   ├── coffee_icon.dart               # Gradient icons
│   │   ├── coffee_network_image.dart      # Smart image loading
│   │   └── coffee_text_field.dart         # Themed input fields
│   ├── utils/
│   │   └── coffee_placeholders.dart       # Asset mapping utility
│   └── assets/                            # Local image assets
│       ├── coffee.webp                    # Coffee product placeholder
│       ├── coffee-hot.webp                # Hot beverage placeholder
│       └── cake.webp                      # Dessert product placeholder
├── test/                                  # Unit tests
├── web/                                   # Web-specific files
├── pubspec.yaml                           # Dependencies and assets
└── README.md                              # This file
```

## 🎨 Theme System

The app uses a centralized coffee theme system:

### Color Palette
- **Primary**: `#8B4513` (Saddle Brown)
- **Primary Dark**: `#5D2F0A` (Dark Brown)
- **Secondary**: `#D2691E` (Chocolate)
- **Background**: `#FFF8DC` (Cornsilk)
- **Surface**: `#F5F5DC` (Beige)

### Design Constants
- **Card Radius**: 20.0px
- **Button Radius**: 16.0px
- **Small Radius**: 12.0px
- **Consistent spacing and typography**

## 🖼️ Smart Image Loading

The app features intelligent image loading with local asset fallbacks:

### Asset Mapping
- **Coffee products** → `coffee.webp`
- **Hot beverages** → `coffee-hot.webp`
- **Cakes/desserts** → `cake.webp`

### How it works
1. Attempts to load images from the API
2. On CORS errors, intelligently maps product names to local assets
3. Falls back to themed placeholder icons if needed

## 🌐 API Integration

### Base Configuration
- **API Base URL**: `https://sme.sosme.api.elitevigour.com`
- **File Base URL**: `https://sme.sosme.file.elitevigour.com`
- **Authentication**: Bearer Token (included in code)

### Available Endpoints
1. **Get Order Details**: `/api/v3/public/ecom-purchase-records/get-detail`
2. **Get Purchase Status**: `/api/v3/public/ecom-purchase-status/get-list`

### Testing the API

You can test the API using the included Postman collection:
```bash
# Import the collection file
Test API.postman_collection.json
```

Or use cURL:
```bash
curl -X GET "https://sme.sosme.api.elitevigour.com/api/v3/public/ecom-purchase-records/get-detail?language_code=EN&ecom_purchase_records_id=120" \
  -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo0OTA4MjIwNzAzLCJqdGkiOiIyNTljZjgxOTM1OWQ0YWIwOWNiODViMDViODQ2OWExYSIsInVzZXJfaWQiOjU2LCJsYW5nIjoiZW4ifQ.Y8zmpxCDqfjWiau6zzpCyRRFEQF3Vk38oEBZoq5XwXs"
```

## 🔧 Development

### Adding New Components

1. **Create component in `lib/widgets/`:**
   ```dart
   // lib/widgets/my_coffee_component.dart
   import 'package:flutter/material.dart';
   import '../theme/coffee_theme.dart';

   class MyCoffeeComponent extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return Container(
         decoration: BoxDecoration(
           color: CoffeeTheme.surfaceColor,
           borderRadius: BorderRadius.circular(CoffeeTheme.cardRadius),
         ),
         // Your component content
       );
     }
   }
   ```

2. **Use theme constants for consistency:**
   ```dart
   // Colors
   CoffeeTheme.primaryColor
   CoffeeTheme.backgroundColor
   
   // Radius
   CoffeeTheme.cardRadius
   CoffeeTheme.buttonRadius
   
   // Text Styles
   CoffeeTheme.headlineStyle
   CoffeeTheme.bodyStyle
   ```

### Building for Production

```bash
# Web build (optimized)
flutter build web --release

# Android APK
flutter build apk --release

# iOS build
flutter build ios --release

# Windows desktop
flutter build windows --release
```

## 📚 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0              # API calls
  provider: ^6.0.5          # State management
  intl: ^0.18.1             # Internationalization
  cached_network_image: ^3.3.0  # Image caching
```

### Dev Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0     # Linting rules
```

## 🐛 Troubleshooting

### Common Issues

#### 1. App won't start
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

#### 2. Web support missing
```bash
# Enable web support
flutter create .
```

#### 3. Dependencies issues
```bash
# Update dependencies
flutter pub upgrade
```

#### 4. Hot reload not working
```bash
# Restart with hot reload
flutter run --hot
```

#### 5. Images not loading
- The app automatically handles CORS issues with local assets
- Check that assets are properly declared in `pubspec.yaml`
- Verify the asset files exist in `lib/assets/`

### Performance Tips

1. **Use release builds for testing performance:**
   ```bash
   flutter run --release
   ```

2. **Enable web renderer for better performance:**
   ```bash
   flutter run -d chrome --web-renderer canvaskit
   ```

3. **Monitor performance:**
   ```bash
   flutter run --profile
   ```

## 🧪 Testing

### Run Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Test Structure
- **Unit tests**: Test individual functions and classes
- **Widget tests**: Test UI components
- **Integration tests**: Test complete user flows

## 📈 Next Steps

### Potential Enhancements
1. **🔍 Search functionality** for orders
2. **📊 Order analytics dashboard**
3. **🛒 Shopping cart integration**
4. **👤 User authentication**
5. **🌙 Dark mode support**
6. **🌍 Multi-language support**
7. **📱 Push notifications**
8. **💾 Offline data caching**

### Performance Optimizations
1. **Lazy loading** for large order lists
2. **Image optimization** and compression
3. **API response caching**
4. **State management optimization**

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:
- Create an issue in the repository
- Review the troubleshooting section above
- Check Flutter documentation: [flutter.dev](https://flutter.dev)

---

**Happy Coding! ☕** Enjoy building your coffee-themed ecommerce experience!
