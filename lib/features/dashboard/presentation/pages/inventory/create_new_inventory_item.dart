import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solgensenapp/features/dashboard/data/services/variant_service.dart';
import 'package:solgensenapp/features/dashboard/domain/variant_model.dart';

class CreateNewInventoryItem extends StatefulWidget {
  const CreateNewInventoryItem({super.key});

  @override
  State<CreateNewInventoryItem> createState() => _CreateNewInventoryItemState();
}

class _CreateNewInventoryItemState extends State<CreateNewInventoryItem> {
  // final _formKey = GlobalKey<FormState>();
  // final TextEditingController _itemCodeController = TextEditingController();

  // final TextEditingController _quantityController = TextEditingController();
  // final TextEditingController _reorderLevelController = TextEditingController();
  // final VariantService _variantService = VariantService();

  // String? selectedWarehouse;
  // String? selectedLocation;
  // String? selectedVariant;
  // VariantModel? selectedVariantModel;

  // List<String> warehouses = [];
  // List<String> locations = [];
  // List<VariantModel> variants = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _loadData();
  // }

  // Future<void> _loadData() async {
  //   try {
  //     //warehouse down
  //     final warehouseSnapshot =
  //         await FirebaseFirestore.instance.collection('warehouses');
  //     warehouses =
  //         warehouseSnapshot.docs.map((doc) => doc['name'] as String).toList();

  //     //variants down
  //     final variantList = await _variantService.getVariants();
  //     setState(() {
  //       variants = variantList;
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error loading data: $e')),
  //     );
  //   }
  // }

  // Future<void> _loadLocations(String warehouse) async{
  //   final locationSnapshot = await FirebaseFirestore.instance.collection('locations').where('warehouse', isEqualTo: warehouse).get;

  //   setState(() {
  //      locations = locationSnapshot.docs.map((doc) => doc['code'] as String).toList();
  //     selectedLocation = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
