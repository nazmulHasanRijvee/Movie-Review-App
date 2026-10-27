import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/asset_paths.dart';
import '../../../core/routes/app_routes.dart';
import '../controllers/home_controller.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.userName});

  final String? userName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColors.primary,

      title: Row(
        mainAxisSize: .min,

        children: [
          Image.asset(
            AssetPaths.movieAppLogo,
            height: 50,
            width: 50,
            fit: .contain,
          ),

          const SizedBox(width: 5),

          Text(
            'CINEPLEX, Hi ${userName ?? 'Stranger'}',
            style: TextStyle(
              // Add text theme
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),

      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.searchMovie);
          },
          icon: Icon(Icons.search, color: Colors.white),
        ),

        IconButton(
          onPressed: () async {
            final isSuccess = await Get.find<HomeController>().logOut();

            if (!isSuccess) return;

            Get.offAllNamed(AppRoutes.onboarding);
          },
          icon: Icon(Icons.exit_to_app_rounded, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
