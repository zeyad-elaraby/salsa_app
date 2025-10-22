import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salsa_app/core/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.onPressed,
    super.key,
    required this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.backGroundColor,
    this.textStyle,
    this.radius,
    this.width,
    this.height,
    this.isLoading = false,
  });
  final Function()? onPressed;
  final String title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backGroundColor;
  final TextStyle? textStyle;
  final double? radius;
  final double? width;
  final double? height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 16.r),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: height ?? 54.h,
        width: width ?? double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            suffixIcon ?? SizedBox.shrink(),
            if (suffixIcon != null) SizedBox(width: 24.w),
            isLoading
                ? CircularProgressIndicator()
                : Text(
                    title,
                    style:
                        textStyle ??
                        TextStyle(color: AppColors.whiteColor, fontSize: 20.sp),
                    // getMediumStyle(color: AppColors.whiteColor, fontSize: 20.sp),
                  ),
            if (suffixIcon != null) SizedBox(width: 27.w),

            prefixIcon ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
