import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../apptheme/app_colors.dart';
import 'custom_container.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? toolBarHeight;
  final Widget? title;
  final double? titleSpacing;
  final List<Widget>? actions;
  final bool? isLeading;
  final Widget? flexibleChild;
  final Function()? onTap;

  const CustomAppBar(
      {
      super.key,
      this.titleSpacing,
      this.onTap,
      this.toolBarHeight,
      this.title,
      this.flexibleChild,
      this.actions,
      this.isLeading = false
      }
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: toolBarHeight ?? 65.h,
      titleSpacing: titleSpacing ?? 15.w,
      shadowColor: AppColors.appBarShadowColor,
      centerTitle: false,
      elevation: 10,
      flexibleSpace: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            gradient: LinearGradient(
                colors: [AppColors.primaryBlack, AppColors.primaryWhite],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: flexibleChild,
      ),
      automaticallyImplyLeading: false,
      leading: isLeading != null && isLeading!
          ? Center(
              child: CustomContainer(
                onTap: onTap ?? ()=> Navigator.pop(context),
                width: 32.h,
                height: 32.h,
                left: 10.w,
                borderColor: Colors.transparent,
                color: AppColors.chipBgColorBlue,
                child: Center(child: FaIcon(FontAwesomeIcons.arrowLeft, color: AppColors.screenBgColor, size: 15.sp)),
              ),
            )
          : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight ?? 65.h);
}
