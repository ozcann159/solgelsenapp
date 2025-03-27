class CategoryModel {
  final String id;
  final String name;
  final String? description;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'],
    );
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
