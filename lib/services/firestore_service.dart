import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solgensenapp/features/dashboard/domain/category_model.dart';
import 'package:solgensenapp/features/dashboard/domain/supplier_model.dart';
import 'package:solgensenapp/features/dashboard/domain/variant_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Categories
  Future<List<CategoryModel>> getCategories() async {
    final QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.docs.map((doc) => CategoryModel.fromMap(
      Map<String, dynamic>.from(doc.data() as Map<Object?, Object?>),
      doc.id
    )).toList();
  }

  Future<void> addCategory(CategoryModel category) async {
    await _firestore.collection('categories').add(category.toMap());
  }

  Future<void> updateCategory(CategoryModel category) async {
    await _firestore.collection('categories').doc(category.id).update(category.toMap());
  }

  Future<void> deleteCategory(String categoryId) async {
    await _firestore.collection('categories').doc(categoryId).delete();
  }

  // Variants
  Future<List<VariantModel>> getVariants() async {
    final QuerySnapshot snapshot = await _firestore.collection('variants').get();
    return snapshot.docs.map((doc) => VariantModel.fromMap(
      Map<String, dynamic>.from(doc.data() as Map<Object?, Object?>),
      doc.id
    )).toList();
  }

  Future<List<VariantModel>> getFilteredVariants({
    String? searchText,
    String? categoryId,
    String? sortBy,
    bool descending = false,
  }) async {
    Query query = _firestore.collection('variants');

    if (searchText != null && searchText.isNotEmpty) {
      query = query.where('name', isGreaterThanOrEqualTo: searchText)
                  .where('name', isLessThan: searchText + 'z');
    }

    if (categoryId != null) {
      query = query.where('categoryId', isEqualTo: categoryId);
    }

    if (sortBy != null) {
      query = query.orderBy(sortBy, descending: descending);
    }

    final QuerySnapshot snapshot = await query.get();
    return snapshot.docs.map((doc) => VariantModel.fromMap(
      Map<String, dynamic>.from(doc.data() as Map<Object?, Object?>),
      doc.id
    )).toList();
  }

  Future<String> addVariant(VariantModel variant) async {
    final docRef = await _firestore.collection('variants').add(variant.toMap());
    return docRef.id;
  }

  Future<void> updateVariant(VariantModel variant) async {
    await _firestore.collection('variants').doc(variant.id).update(variant.toMap());
  }

  Future<void> deleteVariant(String variantId) async {
    await _firestore.collection('variants').doc(variantId).delete();
  }

  // Suppliers
  Future<List<SupplierModel>> getSuppliers() async {
    final QuerySnapshot snapshot = await _firestore.collection('suppliers').get();
    return snapshot.docs.map((doc) => SupplierModel.fromMap(
      Map<String, dynamic>.from(doc.data() as Map<Object?, Object?>),
      doc.id
    )).toList();
  }

  Future<List<SupplierModel>> getFilteredSuppliers({
    String? searchText,
    String? variantId,
  }) async {
    Query query = _firestore.collection('suppliers');

    if (searchText != null && searchText.isNotEmpty) {
      query = query.where('name', isGreaterThanOrEqualTo: searchText)
                  .where('name', isLessThan: searchText + 'z');
    }

    if (variantId != null) {
      query = query.where('variantId', isEqualTo: variantId);
    }

    final QuerySnapshot snapshot = await query.get();
    return snapshot.docs.map((doc) => SupplierModel.fromMap(
      Map<String, dynamic>.from(doc.data() as Map<Object?, Object?>),
      doc.id
    )).toList();
  }

  Future<String> addSupplier(SupplierModel supplier) async {
    final docRef = await _firestore.collection('suppliers').add(supplier.toMap());
    return docRef.id;
  }

  Future<void> updateSupplier(SupplierModel supplier) async {
    await _firestore.collection('suppliers').doc(supplier.id).update(supplier.toMap());
  }

  Future<void> deleteSupplier(String supplierId) async {
    await _firestore.collection('suppliers').doc(supplierId).delete();
  }
}
