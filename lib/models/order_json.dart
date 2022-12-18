import 'package:vizstore_manager/models/cart_item_json.dart';

class OrderJson {
  OrderJson({
    this.id,
    required this.userId,
    required this.storeId,
    required this.cart,
    this.status = 'Pending',
    required this.date_created,
    required this.city,
    required this.address,
    required this.total,
  });

  String? id;
  String? userId;
  String? storeId;
  List<CartItemJson> cart;
  String status;
  DateTime date_created;
  String city;
  String address;
  int total;

  OrderJson.empty()
      : id = '',
        userId = '',
        storeId = '',
        cart = [],
        status = '',
        date_created = DateTime.now(),
        city = '',
        address = '',
        total = 0;

  OrderJson copyWith(
          {String? id,
          String? userId,
          String? storeId,
          List<CartItemJson>? cart,
          String? status,
          DateTime? date_created,
          String? city,
          String? address}) =>
      OrderJson(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        storeId: storeId ?? this.storeId,
        cart: cart ?? this.cart,
        status: status ?? this.status,
        date_created: date_created ?? this.date_created,
        city: city ?? this.city,
        address: address ?? this.address,
        total: total ?? this.total,
      );

  factory OrderJson.fromJson(Map<String, dynamic> json, String id) => OrderJson(
        id: id,
        userId: json["userId"] as String? ?? '',
        storeId: json["storeId"] as String? ?? '',
        cart: List<CartItemJson>.from(
            json["cart"].map((x) => CartItemJson.fromJson(x))),
        status: json["status"] as String? ?? '',
        date_created:
            json["date_created"].toDate() as DateTime? ?? DateTime.now(),
        city: json["city"] as String? ?? '',
        address: json["address"] as String? ?? '',
        total: json["total"] as int? ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "status": status,
        "date_created": date_created,
        "city": city,
        "address": address,
        "total": total,
      };
}
