import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/core/utils/responsive_layout.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/view_details_page.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/appbar/plus_appbar.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/bottom/bottom_navigation_bar.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/card/account_list_card.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({super.key});

  @override
  _AccountListPageState createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  List<Map<String, dynamic>> accounts = [];

  @override
  void initState() {
    super.initState();
    fetchAccounts();
  }

  Future<void> fetchAccounts() async {
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('accounts').get();
      setState(() {
        accounts = snapshot.docs.map((doc) {
          var data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void _deleteAccount(String docId, int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('accounts')
          .doc(docId)
          .delete();
      setState(() {
        accounts.removeAt(index);
      });
    } catch (e) {
      print("Error deleting account: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveLayout.isMobile(context);
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: PlusAppBar(),
      body: accounts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final asset = accounts[index];
                return Column(
                  children: [
                    Dismissible(
                      key: Key(asset["id"]),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Delete Confirmation"),
                            content: Text(
                                "Are you sure you want to delete this item?"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                  _deleteAccount(asset["id"], index);
                                },
                                child: Text("Yes",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                        return confirm;
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            Icon(Icons.delete, color: Colors.white, size: 30),
                      ),
                      child: AccountListCard(
                        title: asset["name"] ?? "Default Name",
                        subtitle: asset["type"] ?? "No Genre Information",
                        balance: (asset["balance"] != null &&
                                asset["balance"] is String)
                            ? double.tryParse(asset["balance"]) ?? 0.0
                            : asset["balance"] ?? 0.0,
                        accountId: asset["id"],
                        index: index,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewListPage(
                                accountId: asset["id"],
                                index: index + 1,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
      bottomNavigationBar: isSmallScreen
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
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
