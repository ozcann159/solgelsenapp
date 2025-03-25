import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solgensenapp/features/dashboard/data/models/supplier_model.dart';
import 'package:solgensenapp/services/firestore_service.dart';

class SupplierListPage extends StatefulWidget {
  const SupplierListPage({super.key});

  @override
  State<SupplierListPage> createState() => _SupplierListPageState();
}

class _SupplierListPageState extends State<SupplierListPage> {
  final TextEditingController _searchController = TextEditingController();
  DocumentReference? selectedCategory;
  final FirestoreService _firestoreService = FirestoreService();
  List<SupplierModel> suppliers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    try {
      // Firestore servisine supplier getirme fonksiyonu eklenecek
      // final suppliersData = await _firestoreService.getSuppliers();
      // setState(() {
      //   suppliers = suppliersData;
      // });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veri yüklenirken hata oluştu: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tedarikçi Listesi'),
        backgroundColor: const Color(0xFF2C3E50),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Tedarikçi Ara',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _loadData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Filtrele'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          selectedCategory = null;
                          _loadData();
                        });
                      },
                      child: const Text('Sıfırla'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: suppliers.length,
                    itemBuilder: (context, index) {
                      final supplier = suppliers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ExpansionTile(
                          title: Text(supplier.supplierName),
                          subtitle: FutureBuilder<DocumentSnapshot>(
                            future: supplier.category.get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final categoryData = snapshot.data!.data() as Map<String, dynamic>?;
                                return Text('Kategori: ${categoryData?['name'] ?? 'Unknown'}');
                              }
                              return const Text('Kategori: Yükleniyor...');
                            },
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tedarik Edilen Ürünler:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  FutureBuilder<List<DocumentSnapshot>>(
                                    future: Future.wait(
                                      supplier.variants.map((ref) => ref.get()),
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: snapshot.data!.map((doc) {
                                            final variantData = doc.data() as Map<String, dynamic>?;
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 16, bottom: 4),
                                              child: Text(
                                                '• ${variantData?['name'] ?? 'Unknown'}',
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      }
                                      return const Text('Ürünler yükleniyor...');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Tedarikçi düzenleme sayfasına yönlendirme
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni tedarikçi ekleme sayfasına yönlendirme
        },
        backgroundColor: const Color(0xFF2C3E50),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
