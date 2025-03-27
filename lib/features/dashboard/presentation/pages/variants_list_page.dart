import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/features/dashboard/data/services/category_service.dart';
import 'package:solgensenapp/features/dashboard/data/services/variant_service.dart';
import 'package:solgensenapp/features/dashboard/domain/category_model.dart';
import 'package:solgensenapp/features/dashboard/domain/variant_model.dart';

class VariantsListPage extends StatefulWidget {
  const VariantsListPage({super.key});

  @override
  State<VariantsListPage> createState() => _VariantsListPageState();
}

class _VariantsListPageState extends State<VariantsListPage> {
  final VariantService _variantService = VariantService();
  final CategoryService _categoryService = CategoryService();
  List<VariantModel> variants = [];
  List<CategoryModel> categories = [];
  String? selectedCategoryId;
  bool isAscending = true;
  Set<String> selectedVariants = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    try {
      final categoriesData = await _categoryService.getCategories();
      final variantsData = await _variantService.getVariantsSortedByCostPrice(
        categoryId: selectedCategoryId,
        ascending: isAscending,
      );

      setState(() {
        categories = categoriesData;
        variants = variantsData;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veri yüklenirken hata oluştu: $e')),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showAddEditDialog([VariantModel? variant]) {
    final nameController = TextEditingController(text: variant?.name);
    final costPriceController = TextEditingController(
      text: variant?.costPrice.toString(),
    );
    final listPriceController = TextEditingController(
      text: variant?.listPrice.toString(),
    );

    // Kategori ID'sini kontrol et
    String? categoryId = variant?.categoryId;
    if (categoryId != null) {
      // ID mevcut kategoriler listesinde var mı kontrol et
      bool categoryExists =
          categories.any((category) => category.id == categoryId);
      if (!categoryExists) {
        // Eğer yoksa, Paper veya Goods kategorisini seç
        final paperCategory = categories.firstWhere(
          (category) => category.name.toLowerCase() == 'paper',
          orElse: () => categories.firstWhere(
            (category) => category.name.toLowerCase() == 'goods',
            orElse: () => categories.first,
          ),
        );
        categoryId = paperCategory.id;
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(variant == null ? 'Add Variant' : 'Edit Variant'),
        content: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Variant Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: categoryId,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category.id,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      categoryId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: costPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Cost Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: listPriceController,
                  decoration: const InputDecoration(
                    labelText: 'List Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              try {
                final costPrice =
                    double.tryParse(costPriceController.text) ?? 0;
                final listPrice =
                    double.tryParse(listPriceController.text) ?? 0;

                if (categoryId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select category')),
                  );
                  return;
                }

                if (variant == null) {
                  await _variantService.addVariant(
                    VariantModel(
                      id: '',
                      name: nameController.text,
                      categoryId: categoryId!,
                      costPrice: costPrice,
                      listPrice: listPrice,
                    ),
                  );
                } else {
                  await _variantService.updateVariant(
                    VariantModel(
                      id: variant.id,
                      name: nameController.text,
                      categoryId: categoryId!,
                      costPrice: costPrice,
                      listPrice: listPrice,
                    ),
                  );
                }
                if (mounted) {
                  Navigator.pop(context);
                  _loadData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        variant == null
                            ? 'Variant added successfully'
                            : 'Variant updated successfully',
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
            child: Text(variant == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteSelected() async {
    try {
      await _variantService.deleteVariants(selectedVariants.toList());
      setState(() {
        selectedVariants.clear();
      });
      _loadData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Variants deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error while deleting variants: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Variant List',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
            );
          },
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.delete),
            onPressed: selectedVariants.isEmpty ? null : _deleteSelected,
            disabledColor: Colors.white,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String?>(
                    value: selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: 'Category Filter',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All'),
                      ),
                      ...categories.map((category) {
                        return DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                        _loadData();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: variants.isEmpty
                        ? const Center(
                            child: Text('No variants added yet'),
                          )
                        : ListView.builder(
                            itemCount: variants.length,
                            itemBuilder: (context, index) {
                              final variant = variants[index];
                              final category = categories.firstWhere(
                                (c) => c.id == variant.categoryId,
                                orElse: () {
                                  // Varsayılan olarak Goods kategorisini göster
                                  return CategoryModel(
                                    id: 'default',
                                    name: variant.categoryId
                                            .toLowerCase()
                                            .contains('paper')
                                        ? 'Paper'
                                        : 'Goods',
                                  );
                                },
                              );
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: Checkbox(
                                    value:
                                        selectedVariants.contains(variant.id),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value ?? false) {
                                          selectedVariants.add(variant.id);
                                        } else {
                                          selectedVariants.remove(variant.id);
                                        }
                                      });
                                    },
                                  ),
                                  title: Text(variant.name),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Category: ${category.name}'),
                                      Text(
                                        'Cost Price: ${variant.costPrice.toStringAsFixed(2)} TL',
                                      ),
                                      Text(
                                        'List Price: ${variant.listPrice.toStringAsFixed(2)} TL',
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        _showAddEditDialog(variant),
                                  ),
                                  isThreeLine: true,
                                ),
                              );
                            },
                          ),
                  ),
                  if (variants.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Total Variant: ${variants.length}'),
                        const Spacer(),
                        if (selectedVariants.isNotEmpty)
                          ElevatedButton.icon(
                            onPressed: _deleteSelected,
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete Selected'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
