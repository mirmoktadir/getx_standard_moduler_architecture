import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../../../widgets/auth_input_field_obsecure.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class SetPasswordView extends GetView<AuthController> {
  const SetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: controller.resetPassKey,
          child: Column(
            children: [
              AuthInputFieldObsecure(
                controller: controller,
                label: "Enter Password",
                theme: theme,
                icon: Iconsax.lock,
                textEditingController: controller.newPassController,
              ),
              const SizedBox(height: 25),
              AuthInputFieldObsecure(
                controller: controller,
                label: "Confirmed password",
                theme: theme,
                icon: Iconsax.lock,
                textEditingController: controller.confirmPasswordController,
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                title: "reset",
                onPressed: () async {
                  await controller.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
