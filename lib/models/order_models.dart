class OrderDetail {
  final int id;
  final String purchaseNumber;
  final String status;
  final double totalAmount;
  final String currency;
  final DateTime orderDate;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final Address deliveryAddress;
  final List<OrderItem> items;
  final String paymentMethod;
  final String paymentStatus;
  final String notes;
  final String deliveryMode;
  final Shop shop;
  final List<ActivityRecord> activityRecords;
  final double vat;

  OrderDetail({
    required this.id,
    required this.purchaseNumber,
    required this.status,
    required this.totalAmount,
    required this.currency,
    required this.orderDate,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.items,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.notes,
    required this.deliveryMode,
    required this.shop,
    required this.activityRecords,
    required this.vat,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    // Calculate total amount from items
    double total = 0.0;
    if (json['ecom_purchase_records_items'] != null) {
      for (var item in json['ecom_purchase_records_items']) {
        final discountPrice = (item['discount_price'] is String)
            ? double.tryParse(item['discount_price']) ?? 0.0
            : (item['discount_price'] ?? 0.0).toDouble();
        final totalItems = (item['total_items'] is String)
            ? int.tryParse(item['total_items']) ?? 1
            : (item['total_items'] ?? 1);
        total += discountPrice * totalItems;
      }
    }

    final vat = (json['vat'] is String)
        ? double.tryParse(json['vat']) ?? 0.0
        : (json['vat'] ?? 0.0).toDouble();

    return OrderDetail(
      id: (json['id'] is String)
          ? int.tryParse(json['id']) ?? 0
          : (json['id'] ?? 0),
      purchaseNumber: (json['purchase_number'] ?? '').toString(),
      status: (json['ecom_purchase_status']?['name'] ?? 'Unknown').toString(),
      totalAmount: total + vat,
      currency: 'USD', // Default currency as not specified in API
      orderDate: DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      customerName:
          (json['purchase_by']?['fullname'] ?? 'Unknown Customer').toString(),
      customerEmail: (json['purchase_by']?['email'] ?? '').toString(),
      customerPhone: (json['purchase_by']?['phone_number'] ?? '').toString(),
      deliveryAddress: Address.fromJson(json['ecom_place_save'] ?? {}),
      items: (json['ecom_purchase_records_items'] as List<dynamic>? ?? [])
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      paymentMethod:
          (json['ecom_payment_mean']?['name'] ?? 'Unknown').toString(),
      paymentStatus:
          (json['ecom_payment_status']?['name'] ?? 'Unknown').toString(),
      notes: (json['order_note'] ?? '').toString(),
      deliveryMode:
          (json['ecom_delivery_mode']?['name'] ?? 'Unknown').toString(),
      shop: Shop.fromJson(json['ecom_shop_chanel'] ?? {}),
      activityRecords:
          (json['ecom_purchase_activity_record'] as List<dynamic>? ?? [])
              .map((record) => ActivityRecord.fromJson(record))
              .toList(),
      vat: vat,
    );
  }
}

class Address {
  final String street;
  final String houseNumber;
  final String streetNumber;
  final String postCode;
  final String note;
  final String phone;

  Address({
    required this.street,
    required this.houseNumber,
    required this.streetNumber,
    required this.postCode,
    required this.note,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    // Handle two different address structures:
    // 1. ecom_place_save: 'address' is a string
    // 2. ecom_shop_chanel.address: object with house_number, street_number, etc.

    String street = '';
    String houseNumber = '';
    String streetNumber = '';
    String postCode = '';

    // Check if 'address' field exists and what type it is
    if (json['address'] != null) {
      if (json['address'] is String) {
        // Case 1: address is a string (ecom_place_save)
        street = json['address'].toString();
      } else if (json['address'] is Map<String, dynamic>) {
        // Case 2: address is an object
        final addressObj = json['address'] as Map<String, dynamic>;
        houseNumber = (addressObj['house_number'] ?? '').toString();
        streetNumber = (addressObj['street_number'] ?? '').toString();
        postCode = (addressObj['post_code'] ?? '').toString();
      }
    } else {
      // Case 3: Direct address fields in current object (shop address)
      houseNumber = (json['house_number'] ?? '').toString();
      streetNumber = (json['street_number'] ?? '').toString();
      postCode = (json['post_code'] ?? '').toString();
    }

    return Address(
      street: street,
      houseNumber: houseNumber,
      streetNumber: streetNumber,
      postCode: postCode,
      note: (json['note'] ?? '').toString(),
      phone: (json['phone_number'] ?? '').toString(),
    );
  }

  String get fullAddress {
    List<String> parts = [];
    if (street.isNotEmpty) parts.add(street);
    if (houseNumber.isNotEmpty) parts.add(houseNumber);
    if (streetNumber.isNotEmpty) parts.add(streetNumber);
    if (postCode.isNotEmpty) parts.add(postCode);
    return parts.join(', ');
  }
}

class OrderItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final double discountPrice;
  final int quantity;
  final double total;
  final String? imageUrl;
  final String code;
  final String size;

  OrderItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.quantity,
    required this.total,
    this.imageUrl,
    required this.code,
    required this.size,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    final itemData = json['ecom_item_ref']?['ecom_item'] ?? {};
    final itemFiles =
        json['ecom_item_ref']?['ecom_shop_item_files'] as List? ?? [];
    final sizeData = json['ecom_item_size'] ?? {};

    String? imageUrl;
    if (itemFiles.isNotEmpty) {
      imageUrl = itemFiles.first['file'];
    }

    // Safe type conversion for numeric fields
    final price = (json['price'] is String)
        ? double.tryParse(json['price']) ?? 0.0
        : (json['price'] ?? 0.0).toDouble();

    final discountPrice = (json['discount_price'] is String)
        ? double.tryParse(json['discount_price']) ?? 0.0
        : (json['discount_price'] ?? 0.0).toDouble();

    final totalItems = (json['total_items'] is String)
        ? int.tryParse(json['total_items']) ?? 0
        : (json['total_items'] ?? 0);

    return OrderItem(
      id: (json['id'] is String)
          ? int.tryParse(json['id']) ?? 0
          : (json['id'] ?? 0),
      name: (itemData['name'] ?? '').toString(),
      description: (itemData['description'] ?? '').toString(),
      price: price,
      discountPrice: discountPrice,
      quantity: totalItems,
      total: discountPrice * totalItems,
      imageUrl: imageUrl,
      code: (json['ecom_item_ref']?['code'] ?? '').toString(),
      size: (sizeData['name'] ?? '').toString(),
    );
  }
}

class Shop {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String description;
  final String? logo;
  final Address address;
  final double rating;
  final int ratingCount;
  final bool isVerified;

  Shop({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.description,
    this.logo,
    required this.address,
    required this.rating,
    required this.ratingCount,
    required this.isVerified,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    final ratingData = json['ecom_shop_rating'] ?? {};
    final addressData = json['address'] ?? {};

    final rating = (ratingData['average_rating'] is String)
        ? double.tryParse(ratingData['average_rating']) ?? 0.0
        : (ratingData['average_rating'] ?? 0.0).toDouble();

    final ratingCount = (ratingData['count_rating'] is String)
        ? int.tryParse(ratingData['count_rating']) ?? 0
        : (ratingData['count_rating'] ?? 0);

    return Shop(
      id: (json['id'] is String)
          ? int.tryParse(json['id']) ?? 0
          : (json['id'] ?? 0),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone_number'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      logo: json['logo']?.toString(),
      address: Address(
        street: '',
        houseNumber: (addressData['house_number'] ?? '').toString(),
        streetNumber: (addressData['street_number'] ?? '').toString(),
        postCode: (addressData['post_code'] ?? '').toString(),
        note: '',
        phone: '',
      ),
      rating: rating,
      ratingCount: ratingCount,
      isVerified: json['is_verified'] == true || json['is_verified'] == 'true',
    );
  }
}

class ActivityRecord {
  final int id;
  final String status;
  final String actionBy;
  final DateTime actionAt;
  final String? remark;

  ActivityRecord({
    required this.id,
    required this.status,
    required this.actionBy,
    required this.actionAt,
    this.remark,
  });

  factory ActivityRecord.fromJson(Map<String, dynamic> json) {
    final statusData = json['ecom_purchase_status'] ?? {};
    final actionByData = json['action_by'] ?? {};

    return ActivityRecord(
      id: (json['id'] is String)
          ? int.tryParse(json['id']) ?? 0
          : (json['id'] ?? 0),
      status: (statusData['name'] ?? '').toString(),
      actionBy: (actionByData['fullname'] ?? '').toString(),
      actionAt: DateTime.tryParse(json['action_at']?.toString() ?? '') ??
          DateTime.now(),
      remark: json['remark']?.toString(),
    );
  }
}

class PurchaseStatus {
  final int id;
  final String name;
  final String code;
  final String languageCode;

  PurchaseStatus({
    required this.id,
    required this.name,
    required this.code,
    required this.languageCode,
  });

  factory PurchaseStatus.fromJson(Map<String, dynamic> json) {
    final statusRef = json['ecom_purchase_status_ref'] ?? {};

    return PurchaseStatus(
      id: (json['id'] is String)
          ? int.tryParse(json['id']) ?? 0
          : (json['id'] ?? 0),
      name: (json['name'] ?? '').toString(),
      code: (statusRef['code'] ?? '').toString(),
      languageCode: (json['language_code'] ?? 'EN').toString(),
    );
  }
}
