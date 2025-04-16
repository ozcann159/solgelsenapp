class VariantModel {
  final String id;
  final String name;
  final String categoryId;
  final double costPrice;
  final double listPrice;

  VariantModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.costPrice,
    required this.listPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryId': categoryId,
      'costPrice': costPrice,
      'listPrice': listPrice,
    };
  }

  factory VariantModel.fromMap(Map<String, dynamic> map, String id) {
    return VariantModel(
      id: id,
      name: map['name'] ?? '',
      categoryId: map['categoryId'] ?? '',
      costPrice: (map['costPrice'] ?? 0).toDouble(),
      listPrice: (map['listPrice'] ?? 0).toDouble(),
    );
  }

  VariantModel copyWith({
    String? id,
    String? name,
    String? categoryId,
    double? costPrice,
    double? listPrice,
  }) {
    return VariantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      costPrice: costPrice ?? this.costPrice,
      listPrice: listPrice ?? this.listPrice,
    );
  }
}
