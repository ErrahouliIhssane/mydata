import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izistock/features/authentication/screens/login/widgets/login_form.dart';
import 'package:izistock/features/authentication/screens/login/widgets/login_header.dart';
import 'package:izistock/utils/helpers/helper_functions.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/styles/widgets/login_signup/form_divider.dart';
import '../../../../common/styles/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_String.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              TLoginHeader(dark: dark),
              const TLoginForm(),
              ///divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(width: TSizes.spaceBtwSections,),
              ///footer
              const TSocialButton()
            ],
          ),
        ),
      ),
    );
  }
}
