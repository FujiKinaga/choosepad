import 'dart:io';

import 'package:choosepad/bloc/recipe/recipe_list_bloc.dart';
import 'package:choosepad/bloc/recipe/recipe_list_event.dart';
import 'package:choosepad/bloc/user/authentication_bloc.dart';
import 'package:choosepad/bloc/user/authentication_event.dart';
import 'package:choosepad/bloc/user/sign_in_bloc.dart';
import 'package:choosepad/bloc/user/sign_in_event.dart';
import 'package:choosepad/pages/home.dart';
import 'package:choosepad/pages/splash.dart';
import 'package:choosepad/repository/recipe/dummy_recipe_list_repository.dart';
import 'package:choosepad/repository/user/firebase_authentication_repository.dart';
import 'package:choosepad/repository/user/firebase_sign_in_repository.dart';
import 'package:choosepad/themes/choose_pad_theme_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void setOverrideForDesktop() {
  if (kIsWeb) return;

  if (Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  } else if (Platform.isFuchsia) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  setOverrideForDesktop();
  runApp(ChoosePadApp());
}

class ChoosePadApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChoosePad',
      debugShowCheckedModeBanner: false,
      theme: ChoosePadThemeData.lightThemeData,
      darkTheme: ChoosePadThemeData.darkThemeData,
      home: SplashPage(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<RecipeListBloc>(
              create: (context) => RecipeListBloc(
                  recipeListRepository: DummyRecipeListRepository())
              ..add(RecipeListLoad()),
            ),
            BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: FirebaseAuthenticationRepository())
              ..add(AppStarted()),
            ),
            BlocProvider<SignInBloc>(
              create: (context) =>
                  SignInBloc(signInRepository: FirebaseSignInRepository())
              ..add(SignInAnonymouslyOnPressed()),
            ),
          ],
          child: HomePage(),
        ),
      ),
    );
  }
}
