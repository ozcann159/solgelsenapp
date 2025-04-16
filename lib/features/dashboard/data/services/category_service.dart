import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solgensenapp/features/dashboard/domain/category_model.dart';


class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'categories';

  // Tüm kategorileri getir
  Future<List<CategoryModel>> getCategories() async {
    try {
      final querySnapshot = await _firestore.collection(_collection).get();
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Kategoriler yüklenirken hata oluştu: $e');
    }
  }

  // Yeni kategori ekle
  Future<void> addCategory(CategoryModel category) async {
    try {
      await _firestore.collection(_collection).add(category.toMap());
    } catch (e) {
      throw Exception('Kategori eklenirken hata oluştu: $e');
    }
  }

  // Kategori güncelle
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(category.id)
          .update(category.toMap());
    } catch (e) {
      throw Exception('Kategori güncellenirken hata oluştu: $e');
    }
  }

  // Kategori sil
  Future<void> deleteCategory(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Kategori silinirken hata oluştu: $e');
    }
  }

  
  Future<void> deleteCategories(List<String> ids) async {
    try {
      final batch = _firestore.batch();
      for (var id in ids) {
        batch.delete(_firestore.collection(_collection).doc(id));
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Kategoriler silinirken hata oluştu: $e');
    }
  }
}
