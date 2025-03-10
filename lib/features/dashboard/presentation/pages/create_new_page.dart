import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/core/utils/responsive_layout.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/account_list_page.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/appbar/create_appbar.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/bottom/bottom_navigation_bar.dart';

class CreateNewPage extends StatefulWidget {
  const CreateNewPage({super.key});

  @override
  _CreateNewPageState createState() => _CreateNewPageState();
}

class _CreateNewPageState extends State<CreateNewPage> {
  String? selectedAccountType;
  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  final List<String> accountsType = [
    "Assets",
    "Debt",
    "Income",
    "Expense",
    "Bank",
    "Cash"
  ];

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveLayout.isMobile(context);
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CreateAppBar(),
      body: Center(
        child: Container(
          width: 369,
          height: 460,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black26,
            //     blurRadius: 3,
            //     spreadRadius: 2,
            //     offset: Offset(0, 2),
            //   ),
            // ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Account Name',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 40),
              DropdownButtonFormField<String>(
                value: selectedAccountType,
                decoration: InputDecoration(
                  labelText: "Account Type",
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                items: accountsType.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAccountType = newValue;
                  });
                },
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: balanceController,
                decoration: InputDecoration(
                  labelText: 'Balance',
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
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  await firestore.collection('accounts').add({
                    'name': nameController.text,
                    'type': selectedAccountType,
                    'balance': double.parse(balanceController.text),
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountListPage(),
                    ),
                  );
                },
                child: Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isSmallScreen
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                      ..withValues(
                        alpha: (0.5 * 255),
                        //blurRadius: 10,
                      ),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: custom_navigation_bar(),
              ),
            )
          : null,
    );
  }
}
