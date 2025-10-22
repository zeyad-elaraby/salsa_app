import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salsa_app/core/utils/app_colors.dart';
import 'package:salsa_app/core/utils/app_text_styles.dart';


class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.label,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    this.spaceBetween = 16,
    this.keyBoardType,
    this.controller,
    this.maxLines,
    this.readOnly = false,
    this.validator,
    this.isObscured = false,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.focusNode,
    this.nextFocus,
  });
  final String? label;
  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final double? spaceBetween;
  final TextInputType? keyBoardType;
  final TextEditingController? controller;
  final int? maxLines;
  final bool readOnly;
  final String? Function(String?)? validator;
  final bool isObscured;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hidden = widget.isObscured;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: widget.spaceBetween!.h,
                ),
                child: Text(
                  widget.label!,
                  style: TextStyles.bold13.copyWith(
                    color: AppColors.color949D9E,
                  ),
                ),
              )
            : SizedBox(),
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          obscureText: hidden,
          obscuringCharacter: '*',
          validator: widget.validator,
          focusNode: widget.focusNode,
          onEditingComplete: () {
            widget.focusNode?.unfocus();
            if (widget.nextFocus != null) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            }
          },
          textInputAction: widget.nextFocus == null
              ? TextInputAction.done
              : TextInputAction.next,

          readOnly: widget.readOnly,
          style: TextStyles.bold13.copyWith(color: AppColors.color949D9E),
          maxLines: widget.maxLines ?? 1,
          keyboardType: widget.keyBoardType ?? TextInputType.text,
          controller: widget.controller,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.symmetric(
              horizontal: 25.w,
              vertical: 17.h,
            ),
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isObscured
                ? IconButton(
                    icon: Icon(
                      Icons.visibility_off,
                      color: AppColors.colorC9CECF,
                    ),
                    isSelected: !hidden,

                    selectedIcon: Icon(
                      Icons.visibility,
                      color: AppColors.colorC9CECF,
                    ),
                    iconSize: 20.r,
                    splashRadius: 15.r,
                    onPressed: () {
                      setState(() {
                        hidden = !hidden;
                      });
                    },
                  )
                : widget.suffixIcon,

            errorStyle: TextStyles.bold13.copyWith(color: AppColors.errorColor),
            hintStyle:
                widget.hintStyle ??
                TextStyles.bold13.copyWith(color: AppColors.color949D9E),
            fillColor: widget.fillColor ?? AppColors.colorf9fafa,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.colore6e9ea,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 4.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.colore6e9ea,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 4.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.colore6e9ea,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 4.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorColor, width: 1.w),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 4.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorColor, width: 2.w),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 4.r),
            ),
          ),
        ),
      ],
    );
  }
}
