import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final DocumentReference? parentCategory;
  final List<DocumentReference>? subcategories;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.parentCategory,
    this.subcategories,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'parentCategory': parentCategory,
      'subcategories': subcategories,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String documentId) {
    return CategoryModel(
      id: documentId,
      name: map['name'] ?? '',
      description: map['description'],
      parentCategory: map['parentCategory'],
      subcategories: map['subcategories'] != null
          ? List<DocumentReference>.from(map['subcategories'])
          : null,
    );
  }
}
