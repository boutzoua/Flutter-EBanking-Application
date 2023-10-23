import 'package:banking/components/changeNotifier.dart';
import 'package:banking/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/palette.dart';
import 'screens/initial/initial_screen.dart';
import 'screens/onboarding/onboardin_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<ItemProvider>(
          create: (context) => ItemProvider(),
        ),
        // Add more providers as needed
      ],
      child: const FlutterBank(),
    ),
  );
}

class FlutterBank extends StatelessWidget {
  const FlutterBank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414.0, 896.0),
      builder: (_,child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Banking App',
        theme: ThemeData(
          primarySwatch: Palette.kCustomColour,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme:
          GoogleFonts.manropeTextTheme(Theme.of(context).textTheme).copyWith(
            bodyText2: TextStyle(
              fontSize: 14.0.sp,
            ),
          ),
        ),
        home: BankingSplash(),
        initialRoute: initScreen == 0 || initScreen == null
            ? OnboardingScreen.id
            : InitialScreen.id,
        routes: {
          InitialScreen.id: (context)=> const InitialScreen(),
          OnboardingScreen.id: (context)=> const OnboardingScreen(),
        },
      ),
    );
  }
}