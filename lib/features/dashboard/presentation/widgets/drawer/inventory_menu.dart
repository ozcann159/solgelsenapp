import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solgensenapp/core/constants/drawer_text_style.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/inventory/create_new_inventory_item.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/inventory/inventory_items_page.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/location/create_location_page.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/location/location_page.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/warhouses/create_warehouses.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/warhouses/warehouses_page.dart';

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
          'assets/icons/invontory.svg',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        childrenPadding: EdgeInsets.only(left: 20),
        children: [
          ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Inventory Items",
                style: DrawerTextStyle.subMenuStyle,
              ),
            ),
            leading: Icon(
              Icons.inventory,
              color: Colors.white,
            ),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ListTile(
                leading: Icon(
                  CupertinoIcons.list_bullet,
                  color: Colors.white,
                ),
                title: Text(
                  "Items",
                  style: DrawerTextStyle.subMenuStyle.copyWith(fontSize: 14),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryItemsPage(),
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
                  "Create Item",
                  style: DrawerTextStyle.childMenuStyle.copyWith(fontSize: 14),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNewInventoryItem(),
                    ),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Warehouses",
                style: DrawerTextStyle.subMenuStyle,
              ),
            ),
            leading: Icon(
              Icons.warehouse,
              color: Colors.white,
            ),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ListTile(
                leading: Icon(
                  CupertinoIcons.list_bullet,
                  color: Colors.white,
                ),
                title: Text(
                  "Warehouses",
                  style: DrawerTextStyle.subMenuStyle.copyWith(fontSize: 14),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WarehousesPage(),
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
                  "Create Warehouse",
                  style: DrawerTextStyle.childMenuStyle.copyWith(fontSize: 14),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateWarehouses(),
                    ),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Location",
                style: DrawerTextStyle.subMenuStyle,
              ),
            ),
            leading: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ListTile(
                leading: Icon(
                  CupertinoIcons.list_bullet,
                  color: Colors.white,
                ),
                title: Text(
                  "Locations List",
                  style: DrawerTextStyle.subMenuStyle.copyWith(fontSize: 14),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationsPage(),
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
                  "Create Location",
                  style: DrawerTextStyle.childMenuStyle.copyWith(fontSize: 14),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateLocation(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
