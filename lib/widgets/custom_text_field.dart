import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../apptheme/app_colors.dart';
import '../apptheme/stylehelper.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final Color? borderColor;
  final Color? errorBorderColor;
  final Color? fillColor;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final double? height;
  final double? width;
  final TextStyle? testStyle;
  final double? horizontalMargin;
  final double? topMargin;
  final double? bottomMargin;
  final int? maxLines;
  final bool? obscureText;
  final bool? filled;
  final bool? enabled;
  final bool? readOnly;
  final bool? alignLabelWithHint;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final double? borderRadius;
  final Function? onChanged;
  final Function? onTap;
  final Function? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onSubmit;

  const CustomTextField(
      {Key? key,
      this.hintText,
      this.labelText,
      this.initialValue,
      this.borderColor,
      this.validator,
      this.height,
      this.width,
      this.onChanged,
      this.textCapitalization,
      this.filled,
      this.alignLabelWithHint,
      this.fillColor,
      this.errorBorderColor,
      this.borderRadius,
      this.testStyle,
      this.controller,
      this.obscureText,
      this.suffixIcon,
      this.maxLines,
      this.onTap,
      this.readOnly,
      this.textInputAction,
      this.keyboardType,
      this.horizontalMargin,
      this.topMargin,
      this.bottomMargin,
      this.inputFormatters,
        this.onSubmit,
      this.maxLength, this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      margin: EdgeInsets.only(
          left: horizontalMargin ?? 0,
          right: horizontalMargin ?? 0,
          top: topMargin ?? 0,
          bottom: bottomMargin ?? 0),
      child: TextFormField(
        initialValue: initialValue,
        inputFormatters: inputFormatters ?? [],
        controller: controller,
        obscureText: obscureText ?? false,
        enabled: enabled ?? true,
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.text,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        onTap: () {
          if(onTap!=null){
            onTap!.call();
          }
        },
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!.call(value);
          }
        },
        validator: (value) {
          if (validator != null) {
            validator!.call(value);
          }
          return null;
        },
        onFieldSubmitted: (value) {
          if (onSubmit != null) {
            onSubmit!(); // Call the onSubmit function when "done" is pressed
          }
        },

        maxLength: maxLength,
        style: testStyle ?? StyleHelper.semiBoldBlack_14,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(

          hintText: hintText,
          counterText: '',
          labelText: labelText,
          alignLabelWithHint: alignLabelWithHint ?? false,
          border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(width: 1, color: borderColor ?? AppColors.primaryBlack)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(width: 1, color: borderColor ?? AppColors.primaryBlack)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide:
                  BorderSide(width: 1, color: errorBorderColor ?? AppColors.primaryBlack)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(width: 1, color: errorBorderColor ?? AppColors.primaryBlack)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide:
                  BorderSide(width: 1, color: borderColor ?? AppColors.primaryBlack)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(width: 1, color: borderColor ?? AppColors.primaryBlack)),
          fillColor: fillColor ?? AppColors.primaryBlue,
          filled: filled ?? false,
          suffixIcon: suffixIcon,
          suffixIconConstraints: BoxConstraints(maxWidth: 30.w, minWidth: 30.w),
          contentPadding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
          hintStyle: StyleHelper.semiBoldGray_12,
        ),
        maxLines: maxLines ?? 1,
        cursorColor: borderColor ?? AppColors.primaryBlue,

      ),
    );
  }
}
