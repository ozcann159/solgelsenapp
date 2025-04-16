import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';

class InventoryItemsPage extends StatefulWidget {
  const InventoryItemsPage({super.key});

  @override
  State<InventoryItemsPage> createState() => _InventoryItemsPageState();
}

class _InventoryItemsPageState extends State<InventoryItemsPage> {
  bool isLoading = false;
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Inventory Item List',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(
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
          }),
          // actions: [
          //   IconButton(
          //     onPressed: () {

          //     },
          //     icon: Icon(Icons.refresh),
          //   ),
          // ], // refresh button
        ),
        body: Card(
          margin: EdgeInsets.only(bottom: 8),
          child: ListTile(),
        ));
  }
}
