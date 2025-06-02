import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news/common/router/auth_guard.dart';
import 'package:news/pages/application/application.dart';
import 'package:news/pages/detail/details.dart';
import 'package:news/pages/index/index.dart';
import 'package:news/pages/sign_in/sign_in.dart';
import 'package:news/pages/sign_up/sign_up.dart';
import 'package:news/pages/welcome/welcome_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  
  AppRouter({required this.authGuard});

  final AuthGuard authGuard;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: IndexRoute.page, initial: true),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: ApplicationRoute.page),
        AutoRoute(page: DetailsRoute.page, guards: [authGuard]),
      ];
}