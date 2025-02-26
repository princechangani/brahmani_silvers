import 'package:brahmani_silvers/apptheme/stylehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../apptheme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final double?height;
  final double?width;
  final double?horizontalMargin;
  final double?verticalMargin;
  final double?borderRadius;
  final String?text;
  final Function?onTap;

  const CustomButton(
      {super.key,
        this.height,
        this.width,
        this.horizontalMargin,
        this.verticalMargin,
        this.borderRadius,
        required this.text,
        required this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap!.call();
      },
      child: Container(
        height: height??45.h,
        width: width??double.infinity,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin??0,vertical:verticalMargin??0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: AppColors.likeOrange,
            borderRadius: BorderRadius.circular(borderRadius??8.r),
            gradient: const LinearGradient(
                colors: [AppColors.primaryBlack, AppColors.primaryWhite],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter)),
        child: Center(
            child: Text(
              text!,
              style: StyleHelper.boldWhite_18
            )),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final double?height;
  final double?width;
  final double?horizontalMargin;
  final double?verticalMargin;
  final double?borderRadius;
  final String?text;
  final Function?onTap;

  const CustomButton2(
      {super.key,
        this.height,
        this.width,
        this.horizontalMargin,
        this.verticalMargin,
        this.borderRadius,
        required this.text,
        required this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap!.call();
      },
      child: Container(
        height: height??45.h,
        width: width??double.infinity,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin??0,vertical:verticalMargin??0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(borderRadius??8.r),
            gradient: const LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter)),
        child: Center(
            child: Text(
                text!,
                style: StyleHelper.boldWhite_16
            )),
      ),
    );

  }
}

class CustomIconButton extends StatelessWidget {
  final double?height;
  final double?width;
  final double?horizontalMargin;
  final double?verticalMargin;
  final double?borderRadius;
  final Icon?icon;
  final Function?onTap;

  const CustomIconButton(
      {super.key,
        this.height,
        this.width,
        this.horizontalMargin,
        this.verticalMargin,
        this.borderRadius,
        required this.icon,
        required this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap!.call();
      },
      child: Container(
        height: height??45.h,
        width: width??double.infinity,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin??0,vertical:verticalMargin??0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(borderRadius??8.r),
            gradient: const LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter)),
        child: Center(
            child: icon),
      ),
    );
  }
}