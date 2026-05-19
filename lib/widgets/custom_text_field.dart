import 'package:flutter/material.dart';
import '../configs/app_colors.dart';
import '../configs/app_textstyles.dart';
import '../utils/responsive_util.dart';

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  final double handleSize;

  CustomTextSelectionControls({this.handleSize = 20.0});

  @override
  Widget buildHandle(
      BuildContext context,
      TextSelectionHandleType type,
      double textLineHeight, [
        VoidCallback? onTap,
      ]) {
    // Wrap default handle in a SizedBox to adjust size
    final handle = super.buildHandle(context, type, textLineHeight, onTap);

    return SizedBox(
      width: handleSize,
      height: handleSize,
      child: handle,
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final TextInputType? type;
  final FocusNode? focusNode;
  final bool? obscureText;
  final bool? expands;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enabled;
  final bool? filled;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final void Function(PointerDownEvent)? onTapOutside;

  const CustomTextField(
      {super.key,
        required this.controller,
        required this.hintText,
        this.type,
        this.obscureText,
        this.suffixIcon, this.contentPadding, this.expands, this.maxLines, this.prefixIcon, this.borderRadius, this.enabled, this.filled, this.enabledBorder, this.focusedBorder, this.fillColor, this.onTapOutside, this.focusNode, this.validator, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: Colors.blue.withOpacity(0.3), // Text selection color
        selectionHandleColor: AppColors.yellow2Color, // The draggable handle
        // cursorColor: AppColors.yellow2Color, // Cursor color
        //   selectionHandleRadius: 10.r

      ),
      child: TextFormField(
        // selectionControls: CustomTextSelectionControls(handleSize: 20.r),
        enabled: enabled ?? true,
        cursorHeight: 25.h,
        onChanged: onChanged,
        focusNode: focusNode,
        validator: validator ?? (value) {
          return null;
        },
        // clipBehavior: Clip.hardEdge,
        textAlign: TextAlign.left,
        expands: expands ?? false,
        controller: controller,
        cursorColor: AppColors.black2Color,
        onTapOutside:onTapOutside ?? (event) {
          FocusScope.of(context).unfocus();
        },
        style: AppTextStyles.m500black14.copyWith(fontSize: 16.sp,fontFamily: 'POP-R'),
        keyboardType: type,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            isDense: true,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            contentPadding:contentPadding ?? EdgeInsets.symmetric(vertical:18.h,horizontal: 15.w),
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: AppTextStyles.r400black14.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 14.sp,
                color: AppColors.blackColor.withOpacity(0.7)),
            fillColor:fillColor ?? AppColors.white2Color,
            // fillColor:fillColor ?? Color(0xFFEAEAde).withOpacity(0.7),
            filled:filled ?? true,
            enabledBorder:enabledBorder ?? OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius:borderRadius ?? BorderRadius.circular(12.r)),
            focusedBorder:focusedBorder ?? OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.yellow4Color),
                borderRadius:borderRadius ?? BorderRadius.all(Radius.circular(12.r))),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius:borderRadius ?? BorderRadius.all(Radius.circular(12.r))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.yellow4Color),
                borderRadius:borderRadius ?? BorderRadius.all(Radius.circular(12.r))),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius:borderRadius ?? BorderRadius.all(Radius.circular(12.r))),

            enabled: true),
        mouseCursor: WidgetStateMouseCursor.clickable,
      ),
    );
  }
}