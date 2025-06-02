import 'package:auto_route/auto_route.dart';
import 'package:news/common/router/router.dart';
import 'package:news/common/utils/utils.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool loggedIn = await isAuthenticated();
    
    if (loggedIn) {
      resolver.next(); // 允许跳转
    } else {
      router.push(SignInRoute()); // 重定向到登录页
    }
  }
}