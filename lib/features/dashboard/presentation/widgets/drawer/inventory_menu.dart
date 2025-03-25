import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solgensenapp/core/constants/drawer_text_style.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/supplier_list_page.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/variants_list_page.dart';

class InventoryMenu extends StatelessWidget {
  const InventoryMenu({
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
          "Inventory",
          style: DrawerTextStyle.MainMenuStyle,
        ),
        leading: SvgPicture.asset(
          'assets/icons/ınvontory.svg',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        childrenPadding: EdgeInsets.only(left: 60),
        children: [
          ListTile(
            leading: Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                CupertinoIcons.list_bullet,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Variants",
              style: DrawerTextStyle.subMenuStyle.copyWith(fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VariantsListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                CupertinoIcons.list_bullet,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Suppliers",
              style: DrawerTextStyle.subMenuStyle.copyWith(fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupplierListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                CupertinoIcons.list_bullet,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Categories",
              style: DrawerTextStyle.subMenuStyle.copyWith(fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VariantsListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
