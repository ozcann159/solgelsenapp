import 'package:flutter/material.dart';


class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPagegState();
}

class _LocationPagegState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5f5f5),
      // appBar: AppBar(
      //   title: const Text(
      //     'Supplier List',
      //     style: TextStyle(
      //       fontFamily: 'Montserrat',
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor: AppColors.primary,
      //   elevation: 0,
      //   leading: Builder(
      //     builder: (context) {
      //       return IconButton(
      //         icon: const Icon(
      //           Icons.arrow_back,
      //           color: Colors.white,
      //           size: 27,
      //         ),
      //         onPressed: () {
      //           if (Navigator.canPop(context)) {
      //             Navigator.pop(context);
      //           } else {
      //             Scaffold.of(context).openDrawer();
      //           }
      //         },
      //       );
      //     },
      //   ),
      //   actions: [
          
      //     IconButton(
      //       icon: const Icon(
      //         Icons.refresh,
      //         color: Colors.white,
      //       ),
      //       onPressed: _loadData,
      //     ),
      //     IconButton(
      //       icon: const Icon(
      //         Icons.delete,
      //         color: Colors.white,
      //       ),
      //       onPressed: selectedSuppliers.isEmpty ? null : _deleteSelected,
      //     ),
      //   ],
      // ),
    );
  }
}