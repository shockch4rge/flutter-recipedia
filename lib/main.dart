import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/authentication/ui/login/login_screen.dart';
import 'package:flutter_recipedia/features/misc/home_screen.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_comments/app/recipe_comment_reply_repository.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_comments/app/recipe_comment_repository.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_comments/recipe_comments_screen.dart';
import 'package:flutter_recipedia/features/recipes/ui/view_recipe/view_recipe_screen.dart';
import 'package:flutter_recipedia/features/search/ui/search_screen.dart';
import 'package:flutter_recipedia/features/settings/ui/app_settings_screen.dart';
import 'package:flutter_recipedia/features/testing/test_screen.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/personal_profile_settings_screen.dart';
import 'package:flutter_recipedia/features/users/ui/user_followers/user_followers_screen.dart';
import 'package:flutter_recipedia/features/users/ui/user_following/user_following_screen.dart';
import 'package:flutter_recipedia/features/users/ui/user_profile/user_profile_screen.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/providers/comment_provider.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(firebase_auth.FirebaseAuth.instance),
        ),
        ChangeNotifierProvider(
          create: (_) => CommentProvider(),
        ),
        Provider(
          create: (_) => UserRepository(
            FirebaseFirestore.instance.collection("users"),
          ),
        ),
        Provider(
          create: (_) => RecipeRepository(
            FirebaseFirestore.instance.collection("recipes"),
          ),
        ),
        Provider(
          create: (_) => RecipeCommentRepository(
            FirebaseFirestore.instance.collection("replies"),
          ),
        ),
        Provider(
          create: (_) => RecipeCommentReplyRepository(
            FirebaseFirestore.instance.collection("replies"),
          ),
        ),
      ],
      child: const App(),
    ),
  );
}

final routeObserver = RouteObserver<PageRoute>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const _primaryColor = Color(0xFF795DFE);
  static const _primaryAccent = Color(0xFF4B23EA);

  static final heartOutlinedIcon = SvgPicture.asset(
    "assets/heart_outlined.svg",
    width: 20,
    height: 20,
    color: App._primaryAccent,
  );
  static final heartFilledIcon = SvgPicture.asset(
    "assets/heart_filled.svg",
    width: 20,
    height: 20,
    color: App._primaryAccent,
  );
  static final chatBubbleIcon = SvgPicture.asset(
    "assets/chat_bubble.svg",
    width: 20,
    height: 20,
    color: App._primaryAccent,
  );
  static final shareIcon = SvgPicture.asset(
    "assets/share.svg",
    width: 20,
    height: 20,
    color: App._primaryAccent,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      title: 'recipedia',
      theme: ThemeData(
        primaryColor: const Color(0xFF795DFE),
        primaryColorDark: const Color(0xFF4B23EA),
        fontFamily: "WorkSans",
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: App._primaryAccent,
            letterSpacing: 1.5,
            fontSize: 44,
            fontWeight: FontWeight.w900,
          ),
          headline2: TextStyle(
            fontSize: 30,
            color: App._primaryAccent,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            fontSize: 26,
            color: App._primaryAccent,
            fontWeight: FontWeight.w600,
          ),
          headline4: TextStyle(
            fontSize: 20,
            color: App._primaryColor,
            fontWeight: FontWeight.w600,
          ),
          headline5: TextStyle(
            fontSize: 14,
            color: App._primaryColor,
            fontWeight: FontWeight.w400,
          ),
          subtitle1: TextStyle(
            fontSize: 16,
            color: App._primaryAccent,
            fontWeight: FontWeight.w600,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            color: App._primaryColor,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.4,
            height: 1.4,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            height: 1.3,
            color: Colors.black,
            letterSpacing: -0.3,
            wordSpacing: 0.3,
          ),
          labelMedium: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      // TODO: Use a ternary to check sign-in status and replace routes accordingly
      home: StreamBuilder(
          stream: context.watch<AuthProvider>().authStateChanges,
          builder: (_, snap) {
            return snap.data == null ? const LoginScreen() : const HomeScreen();
          }),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        RecipeCommentsScreen.routeName: (context) =>
            const RecipeCommentsScreen(),
        SearchScreen.routeName: (_) => const SearchScreen(),
        PersonalProfileSettingsScreen.routeName: (context) =>
            const PersonalProfileSettingsScreen(),
        UserProfileScreen.routeName: (context) => const UserProfileScreen(),
        UserFollowersScreen.routeName: (context) => const UserFollowersScreen(),
        UserFollowingScreen.routeName: (context) => const UserFollowingScreen(),
        ViewRecipeScreen.routeName: (_) => const ViewRecipeScreen(),
        AppSettingsScreen.routeName: (_) => const AppSettingsScreen(),
        TestScreen.routeName: (_) => const TestScreen(),
      },
    );
  }
}
