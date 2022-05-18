import 'package:flutter/material.dart';
import 'package:flutter_recipedia/screens/home_screen.dart';
import 'package:flutter_recipedia/screens/login_screen.dart';
import 'package:flutter_recipedia/screens/reset_password_screen.dart';
import 'package:flutter_recipedia/screens/signup_screen.dart';
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

  // a list of screens for the bottom nav bar to access
  static const screens = [HomeScreen()];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
          title: 'recipedia',
          theme: ThemeData(
            fontFamily: "WorkSans",
            textTheme: const TextTheme(
              headline1: TextStyle(
                  color: App.primaryAccent,
                  letterSpacing: 1.5,
                  fontSize: 44,
                  fontWeight: FontWeight.w900),
              headline2: TextStyle(
                  fontSize: 30,
                  color: App.primaryAccent,
                  fontWeight: FontWeight.bold),
              headline3: TextStyle(
                  fontSize: 20,
                  color: App.primaryAccent,
                  fontWeight: FontWeight.w600),
              headline4: TextStyle(
                  fontSize: 14,
                  color: App.primaryColor,
                  fontWeight: FontWeight.w600),
              subtitle2: TextStyle(fontSize: 14, color: App.primaryColor),
              bodyText1: TextStyle(fontSize: 16, color: Colors.black),
              bodyText2: TextStyle(
                  fontSize: 13, color: Colors.black, wordSpacing: 0.5),
            ),
          ),
          // TODO: Use a ternary to check sign-in status and replace routes accordingly
          initialRoute: "/",
          routes: {
            "/": (context) => const LoginScreen(),
            "/signup": (context) => const SignUpScreen(),
            "/reset-password": (context) => const ResetPasswordScreen(),
            "/home": (context) => const HomeScreen(),
          }),
    );
  }
}
