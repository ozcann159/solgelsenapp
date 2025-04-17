import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/features/dashboard/domain/category_model.dart';
import 'package:solgensenapp/features/dashboard/domain/supplier_model.dart';
import 'package:solgensenapp/features/dashboard/domain/variant_model.dart';
import '../../data/services/supplier_service.dart';
import '../../data/services/category_service.dart';
import '../../data/services/variant_service.dart';

class SuppliersListPage extends StatefulWidget {
  const SuppliersListPage({super.key});

  @override
  State<SuppliersListPage> createState() => _SuppliersListPageState();
}

class _SuppliersListPageState extends State<SuppliersListPage> {
  final SupplierService _supplierService = SupplierService();
  final CategoryService _categoryService = CategoryService();
  final VariantService _variantService = VariantService();

  List<SupplierModel> suppliers = [];
  List<CategoryModel> categories = [];
  List<VariantModel> variants = [];
  String? selectedCategoryId;
  String? selectedVariantId;
  Set<String> selectedSuppliers = {};
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
      final variantsData = await _variantService.getVariants(
        categoryId: selectedCategoryId,
      );
      final suppliersData = await _supplierService.getSuppliers(
        categoryId: selectedCategoryId,
        variantId: selectedVariantId,
      );

      setState(() {
        categories = categoriesData;
        variants = variantsData;
        suppliers = suppliersData;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred while loading data: $e')),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showAddEditDialog([SupplierModel? supplier]) {
    final nameController = TextEditingController(text: supplier?.name);
    final variantController =
        TextEditingController(text: supplier?.variantId ?? '');
    String? categoryId = supplier?.categoryId ?? selectedCategoryId;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(supplier == null ? 'Add Supplier' : 'Edit Supplier'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Supplier Name'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: categoryId,
                decoration: const InputDecoration(labelText: 'Category'),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setDialogState(() {
                    categoryId = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: variantController,
                decoration: const InputDecoration(labelText: 'Variant'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter supplier name'),
                    ),
                  );
                  return;
                }

                if (categoryId == null ||
                    variantController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter category and variant'),
                    ),
                  );
                  return;
                }

                try {
                  if (supplier == null) {
                    await _supplierService.addSupplier(
                      SupplierModel(
                        id: '',
                        name: nameController.text.trim(),
                        categoryId: categoryId!,
                        variantId: variantController.text.trim(),
                      ),
                    );
                  } else {
                    await _supplierService.updateSupplier(
                      SupplierModel(
                        id: supplier.id,
                        name: nameController.text.trim(),
                        categoryId: categoryId!,
                        variantId: variantController.text.trim(),
                      ),
                    );
                  }
                  if (mounted) {
                    Navigator.pop(context);
                    _loadData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          supplier == null
                              ? 'Supplier added successfully'
                              : 'Supplier updated successfully',
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
              child: Text(supplier == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteSelected() async {
    try {
      await _supplierService.deleteSuppliers(selectedSuppliers.toList());
      setState(() {
        selectedSuppliers.clear();
      });
      _loadData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Suppliers deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error while deleting suppliers: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Supplier List',
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
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _loadData,
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: selectedSuppliers.isEmpty ? null : _deleteSelected,
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
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String?>(
                          value: selectedCategoryId,
                          decoration: const InputDecoration(
                            labelText: 'Variant',
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
                              selectedVariantId = null;
                              _loadData();
                            });
                          },
                        ),
                      ),
                      if (selectedCategoryId != null) ...[
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String?>(
                            value: selectedVariantId,
                            decoration: const InputDecoration(
                              labelText: 'Variant Filter',
                              border: OutlineInputBorder(),
                            ),
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('All'),
                              ),
                              ...variants
                                  .where(
                                      (v) => v.categoryId == selectedCategoryId)
                                  .map((variant) {
                                return DropdownMenuItem(
                                  value: variant.id,
                                  child: Text(variant.name),
                                );
                              }).toList(),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedVariantId = value;
                                _loadData();
                              });
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    
                    child: suppliers.isEmpty
                        ? const Center(
                            child: Text('No suppliers added yet'),
                          )
                        : ListView.builder(
                            itemCount: suppliers.length,
                            itemBuilder: (context, index) {
                              final supplier = suppliers[index];
                              final category = categories.firstWhere(
                                (c) => c.id == supplier.categoryId,
                                orElse: () => CategoryModel(
                                  id: '',
                                  name: 'Unknown Category',
                                ),
                              );

                              return Card(
                                color: Colors.white,
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: Checkbox(
                                    value:
                                        selectedSuppliers.contains(supplier.id),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value ?? false) {
                                          selectedSuppliers.add(supplier.id);
                                        } else {
                                          selectedSuppliers.remove(supplier.id);
                                        }
                                      });
                                    },
                                  ),
                                  title: Text(supplier.name,
                                  style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Category: ${category.name}',style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),),
                                      Text('Variant: ${supplier.variantId}',
                                      style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        _showAddEditDialog(supplier),
                                  ),
                                  isThreeLine: true,
                                ),
                              );
                            },
                          ),
                  ),
                  if (suppliers.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Total Supplier: ${suppliers.length}'),
                        const Spacer(),
                        if (selectedSuppliers.isNotEmpty)
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
