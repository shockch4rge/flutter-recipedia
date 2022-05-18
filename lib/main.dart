import 'package:flutter/material.dart';
import 'package:flutter_recipedia/screens/home_screen.dart';
import 'package:flutter_recipedia/screens/login_screen.dart';
import 'package:flutter_recipedia/screens/reset_password_screen.dart';
import 'package:flutter_recipedia/screens/signup_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const primaryColor = Color(0xFF795DFE);
  static const primaryAccent = Color(0xFF4B23EA);

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
              bodyText1: TextStyle(fontSize: 16, color: Colors.black),
              subtitle2: TextStyle(fontSize: 14, color: App.primaryColor),
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
                  fontSize: 24,
                  color: App.primaryColor,
                  fontWeight: FontWeight.w600),
              headline4: TextStyle(
                  fontSize: 16,
                  color: App.primaryColor,
                  fontWeight: FontWeight.w500),
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
