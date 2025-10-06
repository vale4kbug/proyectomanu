import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/common/widgets/widgets.login_signup/form_divider.dart';
import 'package:proyectomanu/common/widgets/widgets.login_signup/social_buttons.dart';
import 'package:proyectomanu/features/authentication/screens/signup/verify_email.dart';
import 'package:proyectomanu/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Titulo
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              //Forma
              const TSignupForm(),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              //Divider
              TFormDivider(dividerText: TTexts.orSignUp.capitalize!),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              const TSocialButtons(),
              const SizedBox(height: TSizes.spaceBtwInputFields),
            ],
          ),
        ),
      ),
    );
  }
}
