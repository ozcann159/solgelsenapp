import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solgensenapp/core/constants/drawer_text_style.dart';

class InventoryMenu extends StatelessWidget {
  const InventoryMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset(
          'assets/icons/invontory.svg',
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
    );
  }
}
