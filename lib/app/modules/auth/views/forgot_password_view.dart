import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:iconly/iconly.dart';

import '../../../widgets/primary_auth_input_field.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forgot Password"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: controller.forgotEmailKey,
            child: Column(
              children: [
                PrimaryAuthInputField(
                  textEditingController: controller.forgotPassController,
                  authController: controller,
                  theme: theme,
                  textInputType: TextInputType.emailAddress,
                  label: "Enter Your email",
                  icon: IconlyLight.message,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 25),
                PrimaryButton(
                  title: "Next",
                  onPressed: () async {
                    await controller.sentOTP();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
