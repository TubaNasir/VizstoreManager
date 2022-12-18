class StoreJson {
  const StoreJson(
      {required this.id,
      required this.storeManager,
      required this.storeName,
      required this.deliveryCharges});

  final String id;
  final String storeManager;
  final String storeName;
  final int deliveryCharges;

  const StoreJson.empty()
      : id = '',
        storeManager = '',
        storeName = '',
        deliveryCharges = 0;

  factory StoreJson.fromJson(Map<String, dynamic> json, String id) => StoreJson(
        id: id,
        storeManager: json["storeManager"] as String? ?? '',
        storeName: json["storeName"] as String? ?? '',
        deliveryCharges: json["deliveryCharges"] as int? ?? -1,
      );
}
