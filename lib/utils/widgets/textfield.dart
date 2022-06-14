import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:resume_builder/styles/app-colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.onChanged,
      this.icon,
      this.hint,
      this.labelText,
      this.obscure = false,
      this.validator,
      this.onSaved,
      this.color,
      this.keyBoardType,
      this.initialValue,
      this.maxLine,
      this.maxLength,
      this.controller,
      this.inputFormatters,
      this.prefixText,
      this.postFixIcon,
      this.enable,
      this.isCenter,
      this.fontSize,
      this.textDirection,
      this.hintColor,
      this.styleColor,
      this.labelColor,
      this.readOnly,
      this.textInputAction,
      this.infoView,
      this.onFieldSubmitted,
      this.focusNode,
      this.focusBorderColor,
      this.filled,
      this.fillColor,
      this.borderColor,
      this.enabledColor,
      this.onTap,
      this.cursorColor});

  final FormFieldSetter<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final Icon? icon;
  final String? hint;
  final String? labelText;
  final bool obscure;

  final FormFieldValidator<String>? validator;
  final Color? color;
  final Color? cursorColor;
  final TextInputType? keyBoardType;
  final String? initialValue;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final Widget? postFixIcon;
  final bool? enable;
  final bool? isCenter;
  final double? fontSize;
  final TextDirection? textDirection;
  final Color? hintColor;
  final Color? styleColor;
  final Color? labelColor;
  final Color? focusBorderColor;
  final Color? borderColor;
  final Color? enabledColor;
  final Color? fillColor;
  final bool? readOnly;
  final bool? filled;
  final TextInputAction? textInputAction;
  final Widget? infoView;
  final FocusNode? focusNode;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: TextFormField(
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        textAlign:
            isCenter != null && isCenter! ? TextAlign.center : TextAlign.left,
        readOnly: readOnly ?? false,
        enabled: enable == null ? true : enable,
        onChanged: onChanged,
        maxLength: maxLength,
        controller: controller,
        maxLines: maxLine,
        initialValue: initialValue,
        keyboardType: keyBoardType,
        onTap: onTap,
        onSaved: onSaved,
        validator: validator,
        obscuringCharacter: "*",
        obscureText: obscure,
        inputFormatters: inputFormatters,
        textDirection: textDirection != null ? textDirection : null,
        style: Get.textTheme.headline1!.copyWith(
          color: styleColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        cursorColor: context.theme.disabledColor,
        decoration: InputDecoration(
          labelText: labelText,
          filled: filled,
          labelStyle: TextStyle(color: context.theme.disabledColor),
          fillColor: fillColor ?? AppColors.textFieldColor,
          prefixText: prefixText,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          hintStyle: Get.textTheme.subtitle2!.copyWith(
            fontSize: kIsWeb ? 16 : 14,
            color: Colors.grey[400],
          ),
          errorStyle: TextStyle(fontSize: 12),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.disabledColor,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.disabledColor,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.1),
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.disabledColor,
              width: 1,
            ),
          ),
          prefixIcon: icon != null
              ? Padding(
                  padding: EdgeInsets.all(5),
                  child: IconTheme(
                    data: IconThemeData(color: context.theme.disabledColor),
                    child: icon!,
                  ),
                )
              : null,
          suffixIcon: postFixIcon == null
              ? null
              : Padding(
                  padding: EdgeInsets.all(5),
                  child: IconTheme(
                    data: IconThemeData(color: context.theme.disabledColor),
                    child: postFixIcon!,
                  ),
                ),
        ),
      ),
    );
  }
}
