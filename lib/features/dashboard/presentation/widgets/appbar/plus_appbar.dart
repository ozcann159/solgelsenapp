import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/create_new_page.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/home_page.dart';


class PlusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PlusAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(13),
        ),
      ),
      title: Text(
        'Account List',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textLight,
        ),
      ),
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.white,
              size: 27,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          );
        },
      ),
      actions: [
        IconButton(
          color: AppColors.white,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CreateNewPage(),
              ),
            );
          },
          icon: Icon(
            CupertinoIcons.plus_circle,
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
