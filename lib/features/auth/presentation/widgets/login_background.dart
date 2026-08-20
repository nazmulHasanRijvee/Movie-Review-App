import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/asset_paths.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AssetPaths.loginBackground, fit: BoxFit.cover),
        ),
        Positioned.fill(child: Container(color: Colors.black26)),
        child,
      ],
    );
  }
}
