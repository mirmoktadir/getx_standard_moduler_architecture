// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryAppbar extends StatelessWidget implements PreferredSizeWidget {
  SecondaryAppbar({
    Key? key,
    required this.title,
    this.actionIcon,
    this.onPressed,
    this.iconColor,
  }) : super(key: key);
  final String title;
  IconData? actionIcon;
  VoidCallback? onPressed;

  Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      centerTitle: false,
      titleSpacing: 0,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPressed,
              icon: Icon(
                actionIcon,
                size: 24,
                color: iconColor,
              )),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
