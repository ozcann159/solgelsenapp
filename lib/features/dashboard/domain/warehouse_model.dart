class WarehouseModel {
  final String id;
  final String name;
  final String location;

  WarehouseModel(
      {required this.id, required this.name, required this.location});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
    };
  }

  factory WarehouseModel.fromMap(Map<String, dynamic> map, String documentId) {
    return WarehouseModel(
      id: documentId,
      name: map['name'],
      location: map['location'] as String? ?? '',
    );
  }
}
