import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solgensenapp/features/dashboard/domain/location_model.dart';

class LocationService {
  final CollectionReference _locationsRef = FirebaseFirestore.instance.collection('locations');

    Future<List<LocationModel>> getLocations() async {
    final snapshot = await _locationsRef.get();
    return snapshot.docs
        .map((doc) => LocationModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> addLocation(LocationModel location) async {
    await _locationsRef.add(location.toMap());
  }

  Future<void> updateLocation(LocationModel location) async {
    await _locationsRef.doc(location.id).update(location.toMap());
  }

  Future<void> deleteLocation(String id) async {
    await _locationsRef.doc(id).delete();
  }
}