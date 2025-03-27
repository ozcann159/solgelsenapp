import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solgensenapp/features/dashboard/domain/supplier_model.dart';


class SupplierService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'suppliers';

  // Tüm tedarikçileri getir
  Future<List<SupplierModel>> getSuppliers({
    String? categoryId,
    String? variantId,
  }) async {
    try {
      Query query = _firestore.collection(_collection);
      
      if (categoryId != null) {
        query = query.where('categoryId', isEqualTo: categoryId);
      }
      
      if (variantId != null) {
        query = query.where('variantId', isEqualTo: variantId);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => SupplierModel.fromMap(Map<String, dynamic>.from(doc.data() as Map<Object?, Object?>), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Tedarikçiler yüklenirken hata oluştu: $e');
    }
  }

  // Yeni tedarikçi ekle
  Future<void> addSupplier(SupplierModel supplier) async {
    try {
      await _firestore.collection(_collection).add(supplier.toMap());
    } catch (e) {
      throw Exception('Tedarikçi eklenirken hata oluştu: $e');
    }
  }

  // Tedarikçi güncelle
  Future<void> updateSupplier(SupplierModel supplier) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(supplier.id)
          .update(supplier.toMap());
    } catch (e) {
      throw Exception('Tedarikçi güncellenirken hata oluştu: $e');
    }
  }

  // Tedarikçi sil
  Future<void> deleteSupplier(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Tedarikçi silinirken hata oluştu: $e');
    }
  }

  // Birden fazla tedarikçi sil
  Future<void> deleteSuppliers(List<String> ids) async {
    try {
      final batch = _firestore.batch();
      for (var id in ids) {
        batch.delete(_firestore.collection(_collection).doc(id));
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Tedarikçiler silinirken hata oluştu: $e');
    }
  }
}
