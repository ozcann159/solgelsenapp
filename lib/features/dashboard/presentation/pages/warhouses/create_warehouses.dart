import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/core/utils/responsive_layout.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/warhouses/warehouses_page.dart';

class CreateWarehouses extends StatefulWidget {
  const CreateWarehouses({super.key});

  @override
  State<CreateWarehouses> createState() => _CreateWarehousesState();
}

class _CreateWarehousesState extends State<CreateWarehouses> {
  TextEditingController warehouseName = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String? selectedAccountType;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveLayout.isMobile(context);
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Create New Warehouse',
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
              TextFormField(
                controller: warehouseName,
                decoration: InputDecoration(
                  labelText: 'Warehouse Name',
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
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
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
                onPressed: () async {
                  if (warehouseName.text.isEmpty ||
                      locationController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill in all fields")),
                    );
                    return;
                  }
                  String location = locationController.text;
                  if (location == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Please enter a valid number for location")));
                    return;
                  }
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  var newWarehouseRef =
                      firestore.collection('warehouses').doc();

                  await newWarehouseRef.set({
                    'name': warehouseName.text,
                    'location': location,
                    'accountType': selectedAccountType,
                    'id': newWarehouseRef.id,
                    'createdAt': FieldValue.serverTimestamp(),
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WarehousesPage()));
                },
                child: Text('Create Warehouse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
