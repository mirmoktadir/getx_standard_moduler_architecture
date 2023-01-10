import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/light_theme_colors.dart';
import '../modules/auth/controllers/auth_controller.dart';

class AuthInputFieldObsecure extends StatelessWidget {
  const AuthInputFieldObsecure({
    Key? key,
    required this.controller,
    required this.label,
    required this.theme,
    required this.icon,
    required this.textEditingController,
  }) : super(key: key);

  final AuthController controller;

  final ThemeData theme;
  final TextEditingController textEditingController;

  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: TextFormField(
        controller: textEditingController,
        textInputAction: TextInputAction.done,
        obscureText: controller.isObscure,
        onSaved: (value) {
          textEditingController.text = value!;
        },
        validator: (value) {
          if (textEditingController.text.isEmpty) {
            return "Field can't be empty!";
          }
          return controller.validatePassword(value!);
        },
        keyboardType: TextInputType.text,
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
          suffixIcon: IconButton(
            color: theme.primaryColor,
            icon: Icon(
                controller.isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              controller.isObscure = !controller.isObscure;
              (context as Element).markNeedsBuild();
            },
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
