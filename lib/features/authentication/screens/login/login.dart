import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/styles/spacing_styles.dart';
import 'package:proyectomanu/common/widgets/widgets.login_signup/form_divider.dart';
import 'package:proyectomanu/common/widgets/widgets.login_signup/social_buttons.dart';
import 'package:proyectomanu/features/authentication/screens/login/widgets/login_form.dart';
import 'package:proyectomanu/features/authentication/screens/login/widgets/login_header.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //LOGO TITULO SUBTITULO
              TLoginHeader(),
              TLoginForm(),
              //Divisor
              TFormDivider(dividerText: TTexts.orSignIn.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),
              //footer
              TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
