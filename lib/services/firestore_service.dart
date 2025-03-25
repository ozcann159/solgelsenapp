import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solgensenapp/features/dashboard/data/models/category_model.dart';
import 'package:solgensenapp/features/dashboard/data/models/variant_model.dart';
import 'package:solgensenapp/features/dashboard/data/models/supplier_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kategori İşlemleri
  Future<List<CategoryModel>> getCategories() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('categories').get();
      return snapshot.docs.map((doc) => CategoryModel.fromMap(
        doc.data() as Map<String, dynamic>, 
        doc.id
      )).toList();
    } catch (e) {
      print('Kategoriler getirilirken hata: $e');
      return [];
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      await _firestore.collection('categories').add(category.toMap());
    } catch (e) {
      print('Kategori eklenirken hata: $e');
      rethrow;
    }
  }

  // Variant İşlemleri
  Future<List<VariantModel>> getVariants() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('variants').get();
      return snapshot.docs.map((doc) => VariantModel.fromMap(
        doc.data() as Map<String, dynamic>, 
        doc.id
      )).toList();
    } catch (e) {
      print('Variantlar getirilirken hata: $e');
      return [];
    }
  }

  Future<void> addVariant(VariantModel variant) async {
    try {
      await _firestore.collection('variants').add(variant.toMap());
    } catch (e) {
      print('Variant eklenirken hata: $e');
      rethrow;
    }
  }

  // Filtreleme ve Sıralama İşlemleri
  Future<List<VariantModel>> getFilteredVariants({
    String? searchText,
    DocumentReference? categoryRef,
    String? sortBy,
    bool descending = false,
  }) async {
    try {
      Query query = _firestore.collection('variants');

      if (categoryRef != null) {
        query = query.where('category', isEqualTo: categoryRef);
      }

      if (searchText != null && searchText.isNotEmpty) {
        query = query.where('name', isGreaterThanOrEqualTo: searchText)
                    .where('name', isLessThan: searchText + 'z');
      }

      if (sortBy != null) {
        query = query.orderBy(sortBy, descending: descending);
      }

      final QuerySnapshot snapshot = await query.get();
      return snapshot.docs.map((doc) => VariantModel.fromMap(
        doc.data() as Map<String, dynamic>, 
        doc.id
      )).toList();
    } catch (e) {
      print('Filtreleme sırasında hata: $e');
      return [];
    }
  }

  // Alt kategorileri getirme
  Future<List<CategoryModel>> getSubcategories(DocumentReference parentRef) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('categories')
          .where('parentCategory', isEqualTo: parentRef)
          .get();
      
      return snapshot.docs.map((doc) => CategoryModel.fromMap(
        doc.data() as Map<String, dynamic>, 
        doc.id
      )).toList();
    } catch (e) {
      print('Alt kategoriler getirilirken hata: $e');
      return [];
    }
  }

  // Supplier İşlemleri
  Future<List<SupplierModel>> getSuppliers() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('suppliers').get();
      return snapshot.docs.map((doc) => SupplierModel.fromMap(
        doc.data() as Map<String, dynamic>, 
        doc.id
      )).toList();
    } catch (e) {
      print('Tedarikçiler getirilirken hata: $e');
      return [];
    }
  }

  Future<void> addSupplier(SupplierModel supplier) async {
    try {
      await _firestore.collection('suppliers').add(supplier.toMap());
    } catch (e) {
      print('Tedarikçi eklenirken hata: $e');
      rethrow;
    }
  }

  Future<List<SupplierModel>> getFilteredSuppliers({
    String? searchText,
    DocumentReference? categoryRef,
  }) async {
    try {
      Query query = _firestore.collection('suppliers');

      if (categoryRef != null) {
        query = query.where('category', isEqualTo: categoryRef);
      }

      if (searchText != null && searchText.isNotEmpty) {
        query = query.where('supplierName', isGreaterThanOrEqualTo: searchText)
                    .where('supplierName', isLessThan: searchText + 'z');
      }

      final QuerySnapshot snapshot = await query.get();
      return snapshot.docs.map((doc) => SupplierModel.fromMap(
        doc.data() as Map<String, dynamic>, 
        doc.id
      )).toList();
    } catch (e) {
      print('Tedarikçi filtreleme sırasında hata: $e');
      return [];
    }
  }

  // Variant-Supplier İlişkisi İşlemleri
  Future<List<SupplierModel>> getSuppliersForVariant(DocumentReference variantRef) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('suppliers')
          .where('variants', arrayContains: variantRef)
          .get();
      
      return snapshot.docs.map((doc) => SupplierModel.fromMap(
        doc.data() as Map<String, dynamic>, 
        doc.id
      )).toList();
    } catch (e) {
      print('Variant tedarikçileri getirilirken hata: $e');
      return [];
    }
  }
}
