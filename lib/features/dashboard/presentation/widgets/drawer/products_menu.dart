import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solgensenapp/core/constants/drawer_text_style.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/categories_list_page.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/suppliers_list_page.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/variants_list_page.dart';

class ProductsMenu extends StatelessWidget {
  const ProductsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        tilePadding: EdgeInsets.zero,
        title: Text(
          "Products",
          style: DrawerTextStyle.MainMenuStyle,
        ),
        leading: SvgPicture.asset(
         'assets/icons/product.svg',
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
                Icons.category,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Variants",
              style: DrawerTextStyle.subMenuStyle,
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
                Icons.inventory_2,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Suppliers",
              style: DrawerTextStyle.subMenuStyle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SuppliersListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                Icons.business,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Categories",
              style: DrawerTextStyle.subMenuStyle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoriesListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
