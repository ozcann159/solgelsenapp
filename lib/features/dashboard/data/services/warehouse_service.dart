import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solgensenapp/features/dashboard/domain/warehouse_model.dart';

class WarehouseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'warehouses';

  //tüm repoları getir
  Future<List<WarehouseModel>> getWarehouses()async{
    try {
      final querySnapshot = await _firestore.collection(_collection).get();
      return querySnapshot.docs.map((doc) => WarehouseModel.fromMap(doc.data(),doc.id)).toList(); 
    } catch (e) {
      throw Exception('Error loading repositories $e'); 
    }
  }

  //Yeni depo ekle
  Future<void> addWarehouse(WarehouseModel warehouse)async{
    try {
      await _firestore.collection(_collection).add(warehouse.toMap()); 
    } catch (e) {
      throw Exception('An error occurred while adding the repository $e'); 
    }
  }

  //Depo güncelle
  Future<void> updateWarehouse(WarehouseModel warehouse)async{
    try {
      await _firestore.collection(_collection).doc(warehouse.id).update(warehouse.toMap()); 
    } catch (e) {
      throw Exception('An error occurred while updating the repository $e'); 
    }
  }

  //Depo sil

  Future<void> deleteWarehouse(String id)async{
    try {
        await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
       throw Exception('Error occurred while deleting repository: $e');
    }
  }
}