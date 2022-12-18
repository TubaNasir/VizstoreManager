import 'package:flutter/material.dart';

class ProductJson {
  final String? id;
  final String title, description;
  final String image;
  final int price;
  final String storeId;
  final String category;
  final int stock;
  final int sold; //stock

  ProductJson({
    this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.storeId,
    required this.category,
    required this.stock,
    this.sold = 0,
  });

  ProductJson copyWith(
          {String? id,
          String? image,
          String? title,
          int? price,
          String? description,
          String? storeId,
          String? category,
          int? stock,
          int? sold}) =>
      ProductJson(
        id: id ?? this.id,
        image: image ?? this.image,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        storeId: storeId ?? this.storeId,
        category: category ?? this.category,
        stock: stock ?? this.stock,
        sold: sold ?? this.sold,
      );

  const ProductJson.empty()
      : id = '',
        image = 'h',
        title = '',
        price = 0,
        description = '',
        storeId = '',
        category = '',
        stock = 0,
        sold = 0;

  factory ProductJson.fromJson(Map<String, dynamic> json, String id) =>
      ProductJson(
        id: id,
        title: json["title"] as String? ?? '',
        description: json["description"] as String? ?? '',
        image: json["image"] as String? ?? '',
        price: json["price"] as int? ?? -1,
        category: json["category"] as String? ?? '',
        stock: json["stock"] as int? ?? -1,
        sold: json["sold"] as int? ?? -1,
        storeId: json["storeId"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "image": image,
        "price": price,
        "stock": stock,
        "storeId": storeId,
        "sold": sold,
        "category": category,
      };
}

// Our demo Products

List<ProductJson> demoProducts = [
  ProductJson(
    id: "1",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ_0CtulSwA_imJJ4nZXEIwu13VNszMaZUBaHgEXVQ&s",
    title: "Wireless Controller for PS4™ nsadfk akjdnaksj kjands",
    price: 1000,
    description:
        "This is a red shirt. Material is agdjd dlfk skrn fjrndf erfr kenedf resjfnr",
    storeId: "1",
    category: "Clothing",
    stock: 5,
    sold: 1,
  ),
  ProductJson(
    id: "2",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ_0CtulSwA_imJJ4nZXEIwu13VNszMaZUBaHgEXVQ&s",
    title: "Wireless Controller for PS4™",
    price: 1000,
    description: "This is a red shirt. Material is agdjd",
    category: "Clothing",
    storeId: "1",
    stock: 5,
    sold: 1,
  ),
  ProductJson(
    id: "3",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ_0CtulSwA_imJJ4nZXEIwu13VNszMaZUBaHgEXVQ&s",
    title: "Wireless Controller for PS4™",
    price: 1000,
    description: "This is a red shirt. Material is agdjd",
    category: "Clothing",
    storeId: "2",
    stock: 5,
    sold: 1,
  ),
  ProductJson(
    id: "5",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ_0CtulSwA_imJJ4nZXEIwu13VNszMaZUBaHgEXVQ&s",
    title: "Wireless Controller for PS4™",
    price: 1000,
    description: "This is a red shirt. Material is agdjd",
    category: "Clothing",
    storeId: "2",
    stock: 5,
    sold: 1,
  ),
];
