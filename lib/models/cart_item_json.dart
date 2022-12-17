class CartItemJson {
  final String productId;
  final int quantity;

  const CartItemJson({
    required this.productId,
    required this.quantity
});

  const CartItemJson.empty() : productId = '', quantity = 0;

  CartItemJson copyWith(
      {String? productId,
        int? quantity,}
      ) =>
      CartItemJson(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );

  static CartItemJson fromJson(Map<String, dynamic> json) => CartItemJson(
    productId: json["productId"] as String? ?? '',
    quantity: json["quantity"] as int? ?? -1,
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
  };


}