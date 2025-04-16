import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/features/dashboard/domain/category_model.dart';
import '../../data/services/category_service.dart';

class CategoriesListPage extends StatefulWidget {
  const CategoriesListPage({super.key});

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  final CategoryService _categoryService = CategoryService();
  List<CategoryModel> categories = [];
  Set<String> selectedCategories = {};
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
      setState(() {
        categories = categoriesData;
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

  void _showAddEditDialog([CategoryModel? category]) {
    final nameController = TextEditingController(text: category?.name);
    final descController = TextEditingController(text: category?.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(category == null ? 'Add Category' : 'Edit Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
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
              try {
                if (category == null) {
                  await _categoryService.addCategory(
                    CategoryModel(
                      id: '',
                      name: nameController.text,
                      description: descController.text,
                    ),
                  );
                } else {
                  await _categoryService.updateCategory(
                    CategoryModel(
                      id: category.id,
                      name: nameController.text,
                      description: descController.text,
                    ),
                  );
                }
                if (mounted) {
                  Navigator.pop(context);
                  _loadData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        category == null
                            ? 'Category added successfully'
                            : 'Category updated successfully',
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
            child: Text(category == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteSelected() async {
    try {
      await _categoryService.deleteCategories(selectedCategories.toList());
      setState(() {
        selectedCategories.clear();
      });
      _loadData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Categories deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred while deleting categories.: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category List',
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
            onPressed: selectedCategories.isEmpty ? null : _deleteSelected,
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
                  Expanded(
                    child: categories.isEmpty
                        ? const Center(
                            child: Text('No categories added yet'),
                          )
                        : ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: Checkbox(
                                    value: selectedCategories
                                        .contains(category.id),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value ?? false) {
                                          selectedCategories.add(category.id);
                                        } else {
                                          selectedCategories
                                              .remove(category.id);
                                        }
                                      });
                                    },
                                  ),
                                  title: Text(category.name),
                                  subtitle: category.description != null
                                      ? Text(category.description!)
                                      : null,
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        _showAddEditDialog(category),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  if (categories.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Total Category: ${categories.length}'),
                        const Spacer(),
                        if (selectedCategories.isNotEmpty)
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
