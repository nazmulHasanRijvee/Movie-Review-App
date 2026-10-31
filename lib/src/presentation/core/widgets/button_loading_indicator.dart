import 'package:flutter/material.dart';

import '../theme/theme.dart';

class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        // RepaintBoundary for optimization
        strokeWidth: 4,
        backgroundColor: context.color.active,
      ),
    );
  }
}
