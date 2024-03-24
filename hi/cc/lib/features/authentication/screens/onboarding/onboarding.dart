import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izistock/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:izistock/features/authentication/screens/onboarding/onboarding_dot_navigation.dart';
import 'package:izistock/features/authentication/screens/onboarding/onboarding_next_button.dart';
import 'package:izistock/utils/constants/image_strings.dart';
import '../../../../utils/constants/text_String.dart';
import 'onboarding_page.dart';
import 'onboarding_skip.dart';

class OnboardingScreen extends StatelessWidget{
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          const OnBoardingSkip(),

          const OnBoardingDotNavigation(),

          const OnBoardingDotNavigation(),

          const OnBoardingNextButton(),
        ],
      ),
    );
  }

}







