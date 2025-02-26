import 'package:brahmani_silvers/utils/const_image_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double? width;
  final double? height;
  final bool? isDisMissile;

  const CustomLoadingIndicator({
    Key? key,
    this.width,
    this.height,
    this.isDisMissile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => isDisMissile!,
      child: SizedBox(
        width: width??80.w,
        height: height??120.w,
        child: Lottie.asset(AppImages.loadingIndicator),
      ),
    );
  }
}
