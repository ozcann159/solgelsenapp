import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/location/location_page.dart';

class CreateLocation extends StatefulWidget {
  const CreateLocation({super.key});

  @override
  State<CreateLocation> createState() => _CreateLocationState();
}

class _CreateLocationState extends State<CreateLocation> {
  List<Map<String, dynamic>> warehouses = [];
  String? selectedWarehouseId;
  final _locationCodeController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchWarehouses();
  }

  Future<void> fetchWarehouses() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('warehouses').get();
    setState(() {
      warehouses = snapshot.docs
          .map((doc) => {'id': doc.id, 'name': doc['name']})
          .toList();
    });
  }

  Future<void> createLocation() async {
    if (selectedWarehouseId == null || _locationCodeController.text.isEmpty) {
      return;
    }
    await FirebaseFirestore.instance.collection('locations').add({
      'warehouseId': selectedWarehouseId,
      'locationCode': _locationCodeController.text,
      'description': _descriptionController.text,
    });
    setState(() {
      isLoading = false;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LocationsPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Location',
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
          Icon(
            CupertinoIcons.clear_circled,
            color: AppColors.white,
            size: 27,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Container(
          width: 347,
          height: 425,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField<String>(
                value: selectedWarehouseId,
                items: warehouses
                    .map((w) => DropdownMenuItem<String>(
                          value: w['id'],
                          child: Text(w['name']),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => selectedWarehouseId = val),
                decoration: InputDecoration(
                  labelText: 'Warehouse',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: _locationCodeController,
                decoration: InputDecoration(
                  labelText: 'Location Code',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF39EB8F),
                  foregroundColor: Colors.white,
                  minimumSize: Size(30, 40),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  isLoading ? null : createLocation();
                },
                child: Text('Create Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
