import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/features/dashboard/data/services/location_service.dart';
import 'package:solgensenapp/features/dashboard/data/services/warehouse_service.dart';
import 'package:solgensenapp/features/dashboard/domain/location_model.dart';
import 'package:solgensenapp/features/dashboard/domain/warehouse_model.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final LocationService _locationService = LocationService();
  final WarehouseService _warehouseService = WarehouseService();

  List<LocationModel> locations = [];
  Map<String, WarehouseModel> warehouseMap = {};
  Set<String> selectedLocations = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    setState(() => isLoading = true);
    try {
      final locationList = await _locationService.getLocations();
      final warehouseList = await _warehouseService.getWarehouses();
      warehouseMap = {for (var w in warehouseList) w.id: w};
      setState(() {
        locations = locationList;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading locations: $e')),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showAddEditDialog(LocationModel? location) {
    final locationCodeController =
        TextEditingController(text: location?.locationCode);
    final descriptionController =
        TextEditingController(text: location?.description);
    String? selectedWarehouseId = location?.warehouseId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(location == null ? 'Add New Location' : 'Edit Location'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedWarehouseId,
                items: warehouseMap.entries
                    .map((entry) => DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value.name),
                        ))
                    .toList(),
                onChanged: (val) => selectedWarehouseId = val,
                decoration: const InputDecoration(
                  labelText: 'Warehouse',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationCodeController,
                decoration: const InputDecoration(
                  labelText: 'Location Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (selectedWarehouseId == null ||
                  locationCodeController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
                return;
              }
              try {
                if (location == null) {
                  await _locationService.addLocation(LocationModel(
                    id: '',
                    warehouseId: selectedWarehouseId!,
                    locationCode: locationCodeController.text.trim(),
                    description: descriptionController.text.trim(),
                  ));
                } else {
                  await _locationService.updateLocation(LocationModel(
                    id: location.id,
                    warehouseId: selectedWarehouseId!,
                    locationCode: locationCodeController.text.trim(),
                    description: descriptionController.text.trim(),
                  ));
                }
                if (mounted) {
                  Navigator.pop(context);
                  _loadLocations();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        location == null
                            ? 'Location added successfully'
                            : 'Location updated successfully',
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
            child: Text(location == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteSelected() async {
    try {
      for (var id in selectedLocations) {
        await _locationService.deleteLocation(id);
      }
      setState(() {
        selectedLocations.clear();
      });
      _loadLocations();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Selected locations deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error occurred while deleting locations: $e')),
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
          'Location List',
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
            onPressed: _loadLocations,
          ),
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
                    child: locations.isEmpty
                        ? const Center(child: Text('No locations added yet'))
                        : ListView.builder(
                            itemCount: locations.length,
                            itemBuilder: (context, index) {
                              final location = locations[index];
                              final warehouseName =
                                  warehouseMap[location.warehouseId]?.name ??
                                      'Unknown';
                              return Card(
                                color: Colors.white,
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: Checkbox(
                                    value:
                                        selectedLocations.contains(location.id),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value ?? false) {
                                          selectedLocations.add(location.id);
                                        } else {
                                          selectedLocations.remove(location.id);
                                        }
                                      });
                                    },
                                  ),
                                  title: Text(
                                    'Location Code: ${location.locationCode} - $warehouseName',
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    location.description ?? '',
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        _showAddEditDialog(location),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  if (locations.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Total Locations: ${locations.length}'),
                        const Spacer(),
                        if (selectedLocations.isNotEmpty)
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
