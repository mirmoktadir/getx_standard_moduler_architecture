import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:getx_standard/app/modules/auth/views/set_password_view.dart';

import '../../../../config/theme/my_fonts.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/secondary_aapbar.dart';
import '../bindings/auth_binding.dart';
import '../controllers/auth_controller.dart';

class OtpVerificationView extends GetView<AuthController> {
  const OtpVerificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // String? otpValue;
    return Scaffold(
      appBar: SecondaryAppbar(
        title: "Verification Code",
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 222.h,
                width: 222.h,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(AppImages.kEmail),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            const SizedBox(height: 20),
            OtpTextField(
              numberOfFields: 4,
              fieldWidth: 60.w,
              margin: EdgeInsets.zero,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              borderColor: theme.primaryColor,
              focusedBorderColor: theme.primaryColor,
              enabledBorderColor: Colors.black26,

              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                //  otpValue = verificationCode;
                controller.otp = verificationCode;
                (context as Element).markNeedsBuild();
              }, // end onSubmit
            ),
            const SizedBox(height: 25),
            Text(
              "We’ve send a 4-digit verification code to your email!",
              style: TextStyle(
                color: theme.hintColor,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Did not get an email?",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () async {
                await controller.sentOTP();
              },
              child: Text(
                "Resend Code",
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: MyFonts.buttonTextSize,
                ),
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              title: "Submit",
              onPressed: () {
                /// temporary navigation
                Get.to(() => const SetPasswordView(), binding: AuthBinding());
              },
            ),
          ],
        ),
      ),
    );
  }
}
