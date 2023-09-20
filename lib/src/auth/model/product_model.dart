import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  ProductModel({
      this.image, 
      this.createdAt, 
      this.price, 
      this.name, 
      this.id, 
      this.updatedAt, 
      this.desc,});

  ProductModel.fromJson(dynamic json) {
    image = json['image'];
    createdAt = json['createdAt'];
    price = json['price'];
    name = json['name'];
    id = json['id'];
    updatedAt = json['updatedAt'];
    desc = json['desc'];
  }
  String? image;
  Timestamp? createdAt;
  double? price;
  String? name;
  String? id;
  Timestamp? updatedAt;
  String? desc;
ProductModel copyWith({  String? image,
  Timestamp? createdAt,
  double? price,
  String? name,
  String? id,
  Timestamp? updatedAt,
  String? desc,
}) => ProductModel(  image: image ?? this.image,
  createdAt: createdAt ?? this.createdAt,
  price: price ?? this.price,
  name: name ?? this.name,
  id: id ?? this.id,
  updatedAt: updatedAt ?? this.updatedAt,
  desc: desc ?? this.desc,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['price'] = price;
    map['name'] = name;
    map['id'] = id;
    map['updatedAt'] = updatedAt;
    map['desc'] = desc;
    return map;
  }

}