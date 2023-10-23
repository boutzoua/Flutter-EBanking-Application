import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/screens/initial/initial_screen.dart';
import 'package:banking/screens/onboarding/local_components/custom_onboarding_page_view_model.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = "onboarding screen";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Widget> getPages() {
    return [
      const CustomOnboardingPageViewModel(
        imageUrl: 'assets/images/onboarding-image-1.png',
        modelTitle: 'Mobile Wallet',
        modelDescription:
        'You can send and receive money to friends and family accross the world',
      ),
      const CustomOnboardingPageViewModel(
        imageUrl: 'assets/images/onboarding-image-2.png',
        modelTitle: 'Mobile Top-Up',
        modelDescription:
        'You can easily pay data and airtime purchase & airtime to cash',
      ),
      const CustomOnboardingPageViewModel(
        imageUrl: 'assets/images/onboarding-image-3.png',
        modelTitle: 'Bill Payment',
        modelDescription:
        'You can easily pay bills, purchase data, airtime, tv cable with ease',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          rawPages: getPages(),
          onDone: () => Navigator.of(context).pushReplacementNamed(
            InitialScreen.id,
          ),
          done: const Text(
            'Get Started',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: kSecondaryColour,
            ),
          ),
          showSkipButton: true,
          skip: const Text(
            'Skip',
            style: TextStyle(
              color: kSecondaryColour,
            ),
          ),
          next: FaIcon(
            FontAwesomeIcons.arrowRight,
            size: kDefaultIconSize.sp,
            color: kSecondaryColour,
          ),
          globalBackgroundColor: const Color(0xff7F7F7F),
          dotsDecorator: const DotsDecorator(
            activeColor: kPrimaryColour,
          ),
        ),
      ),
    );
  }
}