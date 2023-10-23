import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:banking/constants/app_constants.dart';

class CustomOnboardingPageViewModel extends StatelessWidget {
  const CustomOnboardingPageViewModel({
    Key? key,
    required this.imageUrl,
    required this.modelTitle,
    required this.modelDescription,
  }) : super(key: key);

  final String imageUrl, modelTitle, modelDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter:
          const ColorFilter.mode(Color(0xff7A7A7A), BlendMode.modulate),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding.h * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              modelTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: kDefaultPadding.h / 2,
            ),
            Text(
              modelDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}