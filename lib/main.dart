import 'package:flutter/material.dart';
import 'package:flutter_recipedia/screens/app_settings_screen.dart';
import 'package:flutter_recipedia/screens/home/home_screen.dart';
import 'package:flutter_recipedia/screens/home/personal_profile/personal_profile_settings_screen.dart';
import 'package:flutter_recipedia/screens/login_screen.dart';
import 'package:flutter_recipedia/screens/view_recipe_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const primaryColor = Color(0xFF795DFE);
  static const primaryAccent = Color(0xFF4B23EA);
  static final heartOutlinedIcon = SvgPicture.asset(
    "assets/heart_outlined.svg",
    width: 20,
    height: 20,
    color: App.primaryAccent,
  );
  static final heartFilledIcon = SvgPicture.asset(
    "assets/heart_filled.svg",
    width: 20,
    height: 20,
    color: App.primaryAccent,
  );
  static final chatBubbleIcon = SvgPicture.asset(
    "assets/chat_bubble.svg",
    width: 20,
    height: 20,
    color: App.primaryAccent,
  );
  static final shareIcon = SvgPicture.asset(
    "assets/share.svg",
    width: 20,
    height: 20,
    color: App.primaryAccent,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'recipedia',
        theme: ThemeData(
          primaryColor: const Color(0xFF795DFE),
          primaryColorDark: const Color(0xFF4B23EA),
          fontFamily: "WorkSans",
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: App.primaryAccent,
              letterSpacing: 1.5,
              fontSize: 44,
              fontWeight: FontWeight.w900,
            ),
            headline2: TextStyle(
              fontSize: 30,
              color: App.primaryAccent,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              fontSize: 26,
              color: App.primaryAccent,
              fontWeight: FontWeight.w600,
            ),
            headline4: TextStyle(
              fontSize: 20,
              color: App.primaryColor,
              fontWeight: FontWeight.w600,
            ),
            headline5: TextStyle(
              fontSize: 14,
              color: App.primaryColor,
              fontWeight: FontWeight.w400,
            ),
            subtitle1: TextStyle(
              fontSize: 16,
              color: App.primaryAccent,
              fontWeight: FontWeight.w600,
            ),
            subtitle2: TextStyle(
              fontSize: 16,
              color: App.primaryColor,
            ),
            bodyText1: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            bodyText2: TextStyle(
              fontSize: 15,
              color: Colors.black,
              wordSpacing: 0.5,
            ),
            labelMedium: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        // TODO: Use a ternary to check sign-in status and replace routes accordingly
        home: const LoginScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          PersonalProfileSettingsScreen.routeName: (context) =>
              const PersonalProfileSettingsScreen(),
          ViewRecipeScreen.routeName: (_) => const ViewRecipeScreen(),
          AppSettingsScreen.routeName: (_) => const AppSettingsScreen(),
        },
      ),
    );
  }
}
