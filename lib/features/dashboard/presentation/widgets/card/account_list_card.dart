import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:solgensenapp/features/dashboard/presentation/pages/view_details_page.dart';

class AccountListCard extends StatelessWidget {
  final String accountId;
  final String title;
  final String subtitle;
  final double balance;
  final VoidCallback onPressed;
  final int index;
  const AccountListCard({
    Key? key,
    required this.accountId,
    required this.title,
    required this.subtitle,
    required this.balance,
    required this.onPressed,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 349,
      constraints: BoxConstraints(minHeight: 91),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat'),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat'),
                  ),
                  SizedBox(height: 4),
                  Text(
                    balance.toStringAsFixed(3),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewListPage(
                              accountId: accountId,
                              index: index,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(60, 35),
                  backgroundColor: Color(0xFF2C6BAB),
                ),
                child: Text(
                  "View Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
