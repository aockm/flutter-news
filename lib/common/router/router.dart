import 'package:flutter/material.dart';
// import 'package:flutter_news/pages/sign_in/sign_in.dart';
// import 'package:flutter_news/pages/sign_up/sign_up.dart';
// import 'package:flutter_news/pages/welcome/welcome_page.dart';

Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  // you get an animation object and a widget
  // make your own transition
  return ScaleTransition(scale: animation, child: child);
}

// @MaterialAutoRouter()
// class $AppRouter {
//   @initial
//   WelcomePage welcomePageRoute;

//   SignInPage signInPageRoute;

//   SignUpPage signUpPageRoute;

//   @GuardedBy([AuthGuard])
//   ApplicationPage applicationPageRoute;

//   @GuardedBy([AuthGuard])
//   @CustomRoute(transitionsBuilder: zoomInTransition)
//   DetailsPage detailsPageRoute;
// }
