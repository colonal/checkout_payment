import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  const CustomAppBar({
    this.title,
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      leading: Center(
        child: leading ??
            SvgPicture.asset(
              "assets/images/arrow.svg",
              height: 24,
              width: 24,
            ),
      ),
      title: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: Styles.style25,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
