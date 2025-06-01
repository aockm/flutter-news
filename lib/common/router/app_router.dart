import 'package:auto_route/auto_route.dart';
import 'package:news/pages/index/index.dart';
import 'package:news/pages/sign_in/sign_in.dart';
import 'package:news/pages/sign_up/sign_up.dart';
import 'package:news/pages/welcome/welcome_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: IndexRoute.page, initial: true),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SignUpRoute.page),
      ];
}