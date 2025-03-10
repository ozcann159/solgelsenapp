import 'package:flutter/material.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/appbar/plus_appbar.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/card/account_list_card.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({super.key});

  @override
  _AccountListPageState createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  List<Map<String, dynamic>> assetsList = [
    {"title": "Account Assets", "subtitle": "Assets", "balance": 91000.0},
    {"title": "Account Debt", "subtitle": "Debt", "balance": 45000.0},
    {"title": "Savings Account", "subtitle": "Savings", "balance": 120000.0},
    {
      "title": "Investment Account",
      "subtitle": "Investment",
      "balance": 75000.0
    },
  ];

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Confirmation"),
          content: Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("İptal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  assetsList.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text("Evet", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: PlusAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: assetsList.length,
        itemBuilder: (context, index) {
          final asset = assetsList[index];

          return Column(
            children: [
              Dismissible(
                key: Key(asset["title"]),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  // Kullanıcıdan onay iste
                  bool confirm = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Silme Onayı"),
                      content:
                          Text("Bu öğeyi silmek istediğinize emin misiniz?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text("İptal"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child:
                              Text("Evet", style: TextStyle(color: Colors.red)),
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
                  child: Icon(Icons.delete, color: Colors.white, size: 30),
                ),
                child: AccountListCard(
                  title: asset["title"],
                  subtitle: asset["subtitle"],
                  balance: asset["balance"],
                  onPressed: () {
                    print('Clicked');
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
