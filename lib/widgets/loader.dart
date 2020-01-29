import 'package:flutter/material.dart';

import '../colors.dart';

class CircularProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 4,
      valueColor: new AlwaysStoppedAnimation<Color>(CustomColor.loader),
      backgroundColor: CustomColor.loader_background,
    );
  }
}
