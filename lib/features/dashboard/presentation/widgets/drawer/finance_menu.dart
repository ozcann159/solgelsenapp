import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solgensenapp/core/constants/drawer_text_style.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/account_list_page.dart';

class FinanceMenu extends StatelessWidget {
  const FinanceMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        tilePadding: EdgeInsets.zero,
        title: Text(
          "Finance",
          style: DrawerTextStyle.MainMenuStyle,
        ),
        leading: SvgPicture.asset(
          'assets/icons/finance.svg',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        childrenPadding: EdgeInsets.only(left: 60),
        children: [
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/assets.svg',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            title: Text(
              "Assets",
              style: DrawerTextStyle.subMenuStyle,
            ),
            onTap: () {},
          ),
          ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Accounts",
                style: DrawerTextStyle.subMenuStyle,
              ),
            ),
            leading: Icon(
              Icons.supervisor_account,
              color: Colors.white,
            ),
            childrenPadding: EdgeInsets.only(left: 30),
            children: [
              ListTile(
                leading: Icon(
                  CupertinoIcons.list_bullet,
                  color: Colors.white,
                ),
                title: Text(
                  "Account List",
                  style: DrawerTextStyle.subMenuStyle.copyWith(fontSize: 14),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountListPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.plus,
                  color: Colors.white,
                ),
                title: Text(
                  "Create Account",
                  style: DrawerTextStyle.childMenuStyle.copyWith(fontSize: 14),
                ),
                onTap: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/budgets.svg',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              title: Text(
                "Budgets",
                style: DrawerTextStyle.subMenuStyle,
              ),
              onTap: () {},
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/ınvoices.svg',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            title: Text(
              "Invoices",
              style: DrawerTextStyle.subMenuStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/journals.svg',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            title: Text(
              "Journals",
              style: DrawerTextStyle.subMenuStyle,
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/periods.svg',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              title: Text(
                "Periods",
                style: DrawerTextStyle.subMenuStyle,
              ),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/transfers.svg',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              title: Text(
                "Transfers",
                style: DrawerTextStyle.subMenuStyle,
              ),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/payments.svg',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              title: Text(
                "Payments",
                style: DrawerTextStyle.subMenuStyle,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
