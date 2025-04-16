class SupplierModel {
  final String id;
  final String name;
  final String categoryId;
  final String variantId;

  SupplierModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.variantId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryId': categoryId,
      'variantId': variantId,
    };
  }

  factory SupplierModel.fromMap(Map<String, dynamic> map, String id) {
    return SupplierModel(
      id: id,
      name: map['name'] ?? '',
      categoryId: map['categoryId'] ?? '',
      variantId: map['variantId'] ?? '',
    );
  }

  SupplierModel copyWith({
    String? id,
    String? name,
    String? categoryId,
    String? variantId,
  }) {
    return SupplierModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      variantId: variantId ?? this.variantId,
    );
  }
}
