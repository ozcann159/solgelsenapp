import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solgensenapp/features/dashboard/domain/variant_model.dart';


class VariantService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'variants';

  // Tüm varyantları getir
  Future<List<VariantModel>> getVariants({String? categoryId}) async {
    try {
      Query query = _firestore.collection(_collection);
      
      if (categoryId != null) {
        query = query.where('categoryId', isEqualTo: categoryId);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => VariantModel.fromMap(Map<String, dynamic>.from(doc.data() as Map<Object?, Object?>), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Varyantlar yüklenirken hata oluştu: $e');
    }
  }

  // Yeni varyant ekle
  Future<void> addVariant(VariantModel variant) async {
    try {
      await _firestore.collection(_collection).add(variant.toMap());
    } catch (e) {
      throw Exception('Varyant eklenirken hata oluştu: $e');
    }
  }

  // Varyant güncelle
  Future<void> updateVariant(VariantModel variant) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(variant.id)
          .update(variant.toMap());
    } catch (e) {
      throw Exception('Varyant güncellenirken hata oluştu: $e');
    }
  }

  // Varyant sil
  Future<void> deleteVariant(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Varyant silinirken hata oluştu: $e');
    }
  }

  // Birden fazla varyant sil
  Future<void> deleteVariants(List<String> ids) async {
    try {
      final batch = _firestore.batch();
      for (var id in ids) {
        batch.delete(_firestore.collection(_collection).doc(id));
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Varyantlar silinirken hata oluştu: $e');
    }
  }

  // Kategoriye göre varyantları sırala
  Future<List<VariantModel>> getVariantsSortedByCostPrice({
    String? categoryId,
    bool ascending = true,
  }) async {
    try {
      Query query = _firestore.collection(_collection);
      
      if (categoryId != null) {
        query = query.where('categoryId', isEqualTo: categoryId);
      }

      query = query.orderBy('costPrice', descending: !ascending);

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => VariantModel.fromMap(Map<String, dynamic>.from(doc.data() as Map<Object?, Object?>), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Varyantlar sıralanırken hata oluştu: $e');
    }
  }
}
