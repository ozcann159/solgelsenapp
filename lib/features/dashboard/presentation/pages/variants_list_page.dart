import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solgensenapp/features/dashboard/data/models/variant_model.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/add_variant_page.dart';
import 'package:solgensenapp/services/firestore_service.dart';


class VariantsListPage extends StatefulWidget {
  const VariantsListPage({super.key});

  @override
  State<VariantsListPage> createState() => _VariantsListPageState();
}

class _VariantsListPageState extends State<VariantsListPage> {
  final TextEditingController _searchController = TextEditingController();
  DocumentReference? selectedCategory;
  final FirestoreService _firestoreService = FirestoreService();
  List<VariantModel> variants = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    try {
      final variantsData = await _firestoreService.getVariants();
      setState(() {
        variants = variantsData;
      });
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
        title: const Text('Variant Listesi'),
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
                    hintText: 'Variant Ara',
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
                    itemCount: variants.length,
                    itemBuilder: (context, index) {
                      final variant = variants[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(variant.name),
                          subtitle: FutureBuilder<DocumentSnapshot>(
                            future: variant.category.get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final categoryData = snapshot.data!.data() as Map<String, dynamic>?;
                                return Text('Kategori: ${categoryData?['name'] ?? 'Unknown'}');
                              }
                              return const Text('Kategori: Yükleniyor...');
                            },
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${variant.listPrice}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // Variant düzenleme sayfasına yönlendirme
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddVariantPage(),
            ),
          );
          if (result == true) {
            _loadData(); // Yeni variant eklendiğinde listeyi yenile
          }
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