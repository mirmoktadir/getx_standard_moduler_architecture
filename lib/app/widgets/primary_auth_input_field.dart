import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/light_theme_colors.dart';
import '../modules/auth/controllers/auth_controller.dart';

class PrimaryAuthInputField extends StatelessWidget {
  const PrimaryAuthInputField({
    Key? key,
    required this.textEditingController,
    required this.theme,
    required this.textInputType,
    required this.label,
    required this.icon,
    required this.textInputAction,
    required this.authController,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final AuthController authController;
  final ThemeData theme;
  final String label;
  final IconData icon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: TextFormField(
        controller: textEditingController,
        textInputAction: textInputAction,
        obscureText: false,
        onSaved: (value) {
          textEditingController.text = value!;
        },
        validator: (value) {
          if (textEditingController.text.isEmpty) {
            return "Field can't be empty!";
          }
          return authController.validateEmail(value!);
        },
        keyboardType: textInputType,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 15,
          ),
          prefixIcon: Icon(
            icon,
            size: 16,
            color: LightThemeColors.primaryColor,
          ),
          labelText: label,
          floatingLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: theme.hintColor,
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: theme.hintColor,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: const BorderSide(
              width: 1,
              color: LightThemeColors.buttonBorderColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: const BorderSide(
              width: 1,
              color: LightThemeColors.buttonBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: const BorderSide(
              width: 1,
              color: LightThemeColors.buttonBorderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: const BorderSide(
              width: 1,
              color: LightThemeColors.buttonBorderColor,
            ),
          ),
        ),
      ),
    );
  }
}
