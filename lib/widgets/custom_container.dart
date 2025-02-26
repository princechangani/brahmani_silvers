import 'package:flutter/material.dart';

import '../apptheme/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? color;
  final LinearGradient? gradient;
  final Widget ?child;
  final double ?left;
  final double ?top;
  final double ?right;
  final double ?bottom;
  final double ?leftPadding;
  final double ?topPadding;
  final double ?rightPadding;
  final double ?bottomPadding;
  final Alignment ? alignment;
  final Clip ?clipBehavior;
  final Function ? onTap;
  final Function ? onLongPress;
  final List<BoxShadow> ? boxShadow;

  const CustomContainer(
  {super.key, this.height,
      this.width,
      this.radius,
      this.borderWidth,
      this.borderColor,
      this.color,
      this.gradient,
      this.child,
      this.left,
      this.top,
      this.onTap,
      this.onLongPress,
      this.right,
      this.bottom,
      this.leftPadding,
      this.topPadding,
      this.rightPadding,
      this.bottomPadding,
      this.alignment,
      this.boxShadow,
      this.clipBehavior});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(onTap!=null){
          onTap!.call();
        }
      },
      onLongPress: (){
        if(onLongPress!=null){
          onLongPress!.call();
        }
      },
      child: Container(
        height: height,
        width: width??double.infinity,
        decoration: BoxDecoration(
            color: color??Colors.white,
            borderRadius: BorderRadius.circular(radius??8),
            border: Border.all(
                color: borderColor ?? AppColors.lightOrange, width: borderWidth ?? 0),
          gradient: gradient,
          boxShadow: boxShadow ?? []
        ),
        margin: EdgeInsets.fromLTRB(left??0, top??0, right??0, bottom??0),
        padding: EdgeInsets.fromLTRB(leftPadding??0, topPadding??0, rightPadding??0, bottomPadding??0),
        alignment: alignment??Alignment.center,
        clipBehavior: clipBehavior??Clip.antiAlias,
        child: child,

      ),
    );
  }
}

