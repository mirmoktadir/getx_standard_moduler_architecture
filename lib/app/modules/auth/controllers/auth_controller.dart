import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_standard/app/service/base_controller.dart';
import 'package:flutter/material.dart';

import '../../../../config/translations/localization_service.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';
import '../../../service/api_urls.dart';
import '../../../service/app_exceptions.dart';
import '../../../service/dio_client.dart';
import '../../../service/helper/dialog_helper.dart';
import '../bindings/auth_binding.dart';
import '../views/otp_verification_view.dart';

class AuthController extends GetxController with BaseController {
  final TextEditingController mailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //
  final TextEditingController forgotPassController = TextEditingController();
  //
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  //
  final loginFormKey = GlobalKey<FormState>();
  final forgotEmailKey = GlobalKey<FormState>();
  final resetPassKey = GlobalKey<FormState>();
  final profileEditKey = GlobalKey<FormState>();
  bool isObscure = false;

  var lang = ["BD", "EN"];
  String dropdownValue = LocalizationService.getCurrentLocal()
      .languageCode
      .toUpperCase()
      .toString();

  ///
  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Email Incorrect! Try Again...";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length <= 2) {
      return "Password Incorrect! Try Again...";
    } else {
      return null;
    }
  }

  String otp = "";

  /// API -----start-------API///

  //** Login API **//

  doLogin() async {
    bool isValidate = loginFormKey.currentState!.validate();

    if (isValidate) {
      var request = {
        "email": mailController.text.trim(),
        "password": passwordController.text
      };
      showLoading('Login...');
      var response = await DioClient()
          .post(
              ApiUrl.login,
              {
                HttpHeaders.contentTypeHeader: "application/json",
              },
              request)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          DialogHelper.showErrorDialog(description: apiError["reason"]);
        } else {
          handleError(error);
          CustomSnackBar.showCustomErrorSnackBar(
            title: "Failed!",
            message: 'Incorrect Email or Password!',
          );
        }
      });
      if (response == null) return;

      MySharedPref.setToken(response["data"]["token"].toString());

      MySharedPref.setEmail(mailController.text.trim());
      MySharedPref.setPassword(passwordController.text);

      loginFormKey.currentState!.save();
      //reload();

      hideLoading();
      if (kDebugMode) {
        print("Logged in!");
      }
      // Get.offAllNamed(AppPages.HOME);
      // CustomSnackBar.showCustomSnackBar(
      //   title: "Success!",
      //   message: "Successfully Logged in",
      // );
    }
  }
  //** otp sent API **//

  sentOTP() async {
    bool isValidate = forgotEmailKey.currentState!.validate();

    if (isValidate) {
      var request = {
        "email": forgotPassController.text.trim(),
      };
      showLoading('Sending otp...');
      var response = await DioClient()
          .post(
              ApiUrl.sentOTP,
              {
                HttpHeaders.contentTypeHeader: "application/json",
              },
              request)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          DialogHelper.showErrorDialog(description: apiError["reason"]);
        } else {
          handleError(error);
          CustomSnackBar.showCustomErrorSnackBar(
            title: "Internal Server Error!",
            message:
                'Invalid email or Connection could not be established with host smtp.mail-trap.io',
          );
        }
      });
      if (response == null) return;

      forgotEmailKey.currentState!.save();
      //reload();
      hideLoading();
      Get.to(() => const OtpVerificationView(), binding: AuthBinding());
      CustomSnackBar.showCustomSnackBar(
        title: "Success!",
        message: "OTP sent to your email!",
      );
    }
  }

  //** reset password API **//

  reset() async {
    bool isValidate = resetPassKey.currentState!.validate();

    if (isValidate) {
      var request = {
        "otp": otp,
        "password": newPassController.text,
        "password_confirmation": confirmPasswordController.text
      };
      showLoading('Updating password...');
      var response = await DioClient()
          .post(
              ApiUrl.resetPass,
              {
                HttpHeaders.contentTypeHeader: "application/json",
              },
              request)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          DialogHelper.showErrorDialog(description: apiError["reason"]);
        } else {
          handleError(error);
          CustomSnackBar.showCustomErrorSnackBar(
            title: "Failed!",
            message: 'Operation Failed',
          );
        }
      });
      if (response == null) return;

      resetPassKey.currentState!.save();
      //reload();
      hideLoading();
      Get.toNamed(Routes.AUTH);
      CustomSnackBar.showCustomSnackBar(
        title: "Success!",
        message: "Password updated!",
      );
    }
  }

  /// API -------end--------API///

  /// load current user
  Future currentUser() async {
    final email = await MySharedPref.getEmail() ?? '';
    mailController.text = email;
  }

  /// Logout
  doLogout() async {
    await MySharedPref.removeToken();

    // await MySharedPref.removeEmail();
    await MySharedPref.removePassword();

    Get.offAllNamed(Routes.AUTH);
  }

  @override
  void onInit() {
    mailController;
    passwordController;
    newPassController;
    confirmPasswordController;

    currentUser();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    mailController.dispose();
    passwordController.dispose();
    newPassController.dispose();
    confirmPasswordController.dispose();
  }
}
