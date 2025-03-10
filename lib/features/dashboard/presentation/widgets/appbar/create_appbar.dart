import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/account_list_page.dart';

class CreateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CreateAppBar({
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
        ' Create New Account',
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
                MaterialPageRoute(builder: (context) => AccountListPage()),
              );
            },
          );
        },
      ),
      actions: const [
        Icon(
          CupertinoIcons.clear_circled,
          color: AppColors.white,
          size: 27,
        ),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
