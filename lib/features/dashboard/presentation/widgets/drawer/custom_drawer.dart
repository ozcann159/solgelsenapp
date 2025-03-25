import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/core/constants/drawer_text_style.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/drawer/finance_menu.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/drawer/inventory_menu.dart';

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
                FinanceMenu(),
                InventoryMenu(),
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
