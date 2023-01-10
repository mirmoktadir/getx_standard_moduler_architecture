import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/theme/my_fonts.dart';

import '../../../../utils/constants.dart';
import '../../../widgets/auth_input_field_obsecure.dart';
import '../../../widgets/primary_auth_input_field.dart';
import '../../../widgets/primary_button.dart';
import '../bindings/auth_binding.dart';
import '../controllers/auth_controller.dart';
import 'forgot_password_view.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              child: Column(
                children: [
                  Lottie.asset(
                    'animations/login.json',
                    height: 200.h,
                    repeat: true,
                    reverse: true,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 30.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.kAppLogo),
                          fit: BoxFit.fill),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: controller.loginFormKey,
                    child: Wrap(
                      children: [
                        PrimaryAuthInputField(
                          textEditingController: controller.mailController,
                          authController: controller,
                          theme: theme,
                          icon: Iconsax.user,
                          textInputType: TextInputType.emailAddress,
                          label: "Enter Your Email",
                          textInputAction: TextInputAction.next,
                        ),
                        AuthInputFieldObsecure(
                          controller: controller,
                          theme: theme,
                          textEditingController: controller.passwordController,
                          icon: Iconsax.lock,
                          label: "Password",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  PrimaryButton(
                    title: "Login",
                    onPressed: () async {
                      await controller.doLogin();
                    },
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Get.to(() => const ForgotPasswordView(),
                          binding: AuthBinding());
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: MyFonts.buttonTextSize,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // langSection(theme, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
