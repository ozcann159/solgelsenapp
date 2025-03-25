import 'package:cloud_firestore/cloud_firestore.dart';

class VariantModel {
  final String id;
  final String name;
  final DocumentReference category;
  final double costPrice;
  final double listPrice;
  final int? availableQuantity;

  VariantModel({
    required this.id,
    required this.name,
    required this.category,
    required this.costPrice,
    required this.listPrice,
    this.availableQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'costPrice': costPrice,
      'listPrice': listPrice,
      'availableQuantity': availableQuantity,
    };
  }

  factory VariantModel.fromMap(Map<String, dynamic> map, String documentId) {
    return VariantModel(
      id: documentId,
      name: map['name'] ?? '',
      category: map['category'],
      costPrice: (map['costPrice'] ?? 0).toDouble(),
      listPrice: (map['listPrice'] ?? 0).toDouble(),
      availableQuantity: map['availableQuantity'],
    );
  }
}
