class LocationModel {
  final String id;
  final String warehouseId;
  final String locationCode;
  final String? description;

  LocationModel({required this.id, required this.warehouseId, required this.locationCode, required this.description});

   factory LocationModel.fromMap(Map<String, dynamic> map, String docId) {
    return LocationModel(
      id: docId,
      warehouseId: map['warehouseId'] ?? '',
      locationCode: map['locationCode'] ?? '',
      description: map['description'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'warehouseId':warehouseId,
      'locationCode': locationCode,
      'description': description
    };
  }

}



