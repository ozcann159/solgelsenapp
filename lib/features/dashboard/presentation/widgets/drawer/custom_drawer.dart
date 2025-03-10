import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/core/constants/drawer_text_style.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/account_list_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF2C3E50),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    size: 24,
                    color: AppColors.textLight,
                  ),
                  title: Text(
                    "Home",
                    style: DrawerTextStyle.MainMenuStyle,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/product.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "Products",
                    style: DrawerTextStyle.MainMenuStyle,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/ohs.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "OHS",
                    style: DrawerTextStyle.MainMenuStyle,
                  ),
                  onTap: () {},
                ),
                ExpansionTile(
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
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
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 6.0),
                        child: SvgPicture.asset(
                          'assets/icons/assets.svg',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
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
                      title: Text(
                        "Accounts",
                        style: DrawerTextStyle.subMenuStyle,
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.supervisor_account,
                          color: Colors.white,
                        ),
                      ),
                      childrenPadding: EdgeInsets.only(left: 60),
                      children: [
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.list_bullet,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Account List",
                            style: DrawerTextStyle.subMenuStyle,
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
                            style: DrawerTextStyle.childMenuStyle,
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
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(
                          'assets/icons/ınvoices.svg',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Text(
                        "Invoices",
                        style: DrawerTextStyle.subMenuStyle,
                      ),
                      onTap: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ListTile(
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
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/ınvontory.svg',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "Inventory",
                      style: DrawerTextStyle.MainMenuStyle,
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/sales.svg',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "Sales",
                      style: DrawerTextStyle.MainMenuStyle,
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/purchases.svg',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "Purchases",
                      style: DrawerTextStyle.MainMenuStyle,
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/hr.svg',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "HR",
                      style: DrawerTextStyle.MainMenuStyle,
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/projectm.svg',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "Project Managament",
                      style: DrawerTextStyle.MainMenuStyle,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
