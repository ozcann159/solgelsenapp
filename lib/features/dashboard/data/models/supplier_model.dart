import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierModel {
  final String id;
  final String supplierName;
  final DocumentReference category;
  final List<DocumentReference> variants;

  SupplierModel({
    required this.id,
    required this.supplierName,
    required this.category,
    required this.variants,
  });

  Map<String, dynamic> toMap() {
    return {
      'supplierName': supplierName,
      'category': category,
      'variants': variants,
    };
  }

  factory SupplierModel.fromMap(Map<String, dynamic> map, String documentId) {
    return SupplierModel(
      id: documentId,
      supplierName: map['supplierName'] ?? '',
      category: map['category'],
      variants: (map['variants'] as List?)?.map((ref) => ref as DocumentReference).toList() ?? [],
    );
  }
}
