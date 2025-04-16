import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solgensenapp/core/constants/app_colors.dart'; // intl paketini içeri aktarın

class ViewListPage extends StatelessWidget {
  final String accountId;
  final int index;

  const ViewListPage({
    Key? key,
    required this.accountId,
    required this.index,
  }) : super(key: key);

  Future<DocumentSnapshot> getAccountDetails() async {
    return await FirebaseFirestore.instance
        .collection('accounts')
        .doc(accountId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(13),
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: FutureBuilder<DocumentSnapshot>(
          future: getAccountDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            }
            if (!snapshot.hasData ||
                snapshot.data == null ||
                !snapshot.data!.exists) {
              return Text("Account Not Found");
            }

            var accountData = snapshot.data!.data() as Map<String, dynamic>;

            String accountName = accountData['name'] ?? 'Unknown Account';
            return Text(
              accountName,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textLight,
              ),
            );
          },
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getAccountDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              !snapshot.data!.exists) {
            return Center(child: Text("Account not found"));
          }

          var accountData = snapshot.data!.data() as Map<String, dynamic>;

          Timestamp? createdAt = accountData['createdAt'];

          String formattedDate = createdAt != null
              ? DateFormat("MMM.d.yyyy, h:mm a").format(createdAt.toDate())
              : "Not Available";

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400,
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account ID: $index",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        _buildDetailRow("Account Name",
                            accountData['name'] ?? "Unknown Account"),
                        _buildDetailRow(
                            "Account Type", accountData['type'] ?? "No Type"),
                        _buildDetailRow(
                            "Balance", "\$${accountData['balance'] ?? '0.0'}"),
                        _buildDetailRow("Created At", formattedDate),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
