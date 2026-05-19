import 'package:flutter/material.dart';
import '../configs/app_colors.dart';
import '../configs/app_textstyles.dart';
import '../utils/responsive_util.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? fontSize;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback onPress;
  final Color? color;
  final bool enabled;
  final Color? textColor;
  final Color? iconColor;
  final BoxBorder? border;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPress,
    this.fontSize,
    this.prefixIcon,
    this.suffixIcon, this.height, this.borderRadius, this.color, this.textColor, this.iconColor, this.border, this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: Ink(
        height: 50.h,
        // height: 59.h,
        width: context.width,
        decoration: BoxDecoration(
          color:color ?? (enabled ? AppColors.yellow2Color : AppColors.greyColor.withOpacity(0.3))/*.withOpacity(0.5)*/,
          borderRadius: borderRadius ?? BorderRadius.circular(12.r),
          border: border
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          splashColor: Colors.white.withOpacity(0.25),
          highlightColor: Colors.white.withOpacity(0.1),
          onTap: enabled ? onPress : null,
          child: suffixIcon != null || prefixIcon != null
              ? Row(
                  children: [
                    const Spacer(),
                    if (prefixIcon != null) ...[
                      Icon(prefixIcon, color:iconColor ?? AppColors.blackColor, size: 20.r),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      title,
                      style: AppTextStyles.m500black14.copyWith(
                        fontSize: 16.sp,
                        color: textColor
                      ),
                    ),
                    if (suffixIcon != null) ...[
                      SizedBox(width: 10.w),
                      Icon(suffixIcon, color:iconColor ?? AppColors.blackColor, size: 25.r),
                    ],
                    const Spacer(),
                  ],
                )
              : Center(
                  child: Text(
                    title,
                    style: AppTextStyles.m500black14.copyWith(
                      fontSize: fontSize ?? 16.sp,
                      color: textColor
                      // color: AppColors.blackColor.withOpacity(0.5)
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
