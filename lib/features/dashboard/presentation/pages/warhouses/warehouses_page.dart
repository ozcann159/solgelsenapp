import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/features/dashboard/data/services/warehouse_service.dart';
import 'package:solgensenapp/features/dashboard/domain/warehouse_model.dart';

class WarehousesPage extends StatefulWidget {
  const WarehousesPage({super.key});

  @override
  State<WarehousesPage> createState() => _WarehousesPageState();
}

class _WarehousesPageState extends State<WarehousesPage> {
  final WarehouseService _warehouseService = WarehouseService();
  List<WarehouseModel> warehouses = [];
  Set<String> selectedWarehouses = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWarehouses();
  }

  Future<void> _loadWarehouses() async {
    setState(() => isLoading = true);
    try {
      final warehouseList = await _warehouseService.getWarehouses();
      setState(() {
        warehouses = warehouseList;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading repositories: $e')),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showAddEditDialog(WarehouseModel? warehouse) {
    final nameController = TextEditingController(text: warehouse?.name);
    final locationController = TextEditingController(text: warehouse?.location);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(warehouse == null ? 'Add New Warehouse' : 'Edit Warehouse'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Warehouse Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
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
              if (nameController.text.trim().isEmpty ||
                  locationController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
                return;
              }
              try {
                if (warehouse == null) {
                  await _warehouseService.addWarehouse(WarehouseModel(
                    id: '',
                    name: nameController.text.trim(),
                    location: locationController.text.trim(),
                  ));
                } else {
                  await _warehouseService.updateWarehouse(WarehouseModel(
                    id: warehouse.id,
                    name: nameController.text.trim(),
                    location: locationController.text.trim(),
                  ));
                }
                if (mounted) {
                  Navigator.pop(context);
                  _loadWarehouses();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        warehouse == null
                            ? 'Repository added successfully'
                            : 'Repository updated successfully',
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
            child: Text(warehouse == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteSelected() async {
    try {
      for (var id in selectedWarehouses) {
        await _warehouseService.deleteWarehouse(id);
      }
      setState(() {
        selectedWarehouses.clear();
      });
      _loadWarehouses();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Selected repositories deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error occurred while deleting repositories: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Warehouse List',
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
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadWarehouses,
          ),
          // IconButton(
          //   icon: const Icon(Icons.delete, color: Colors.white),
          //   onPressed: selectedWarehouses.isEmpty ? null : _deleteSelected,
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(null),
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
                    child: warehouses.isEmpty
                        ? const Center(child: Text('No repositories added yet'))
                        : ListView.builder(
                            itemCount: warehouses.length,
                            itemBuilder: (context, index) {
                              final warehouse = warehouses[index];
                              return Card(
                                color: Colors.white,
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: Checkbox(
                                    value: selectedWarehouses
                                        .contains(warehouse.id),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value ?? false) {
                                          selectedWarehouses.add(warehouse.id);
                                        } else {
                                          selectedWarehouses
                                              .remove(warehouse.id);
                                        }
                                      });
                                    },
                                  ),
                                  title: Text(
                                    warehouse.name,
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Location: ${warehouse.location}',
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        _showAddEditDialog(warehouse),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  if (warehouses.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Total Warehouse: ${warehouses.length}'),
                        const Spacer(),
                        if (selectedWarehouses.isNotEmpty)
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
