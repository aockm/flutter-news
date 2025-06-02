import 'package:flutter/material.dart';
import 'package:news/common/provider/app.dart';
import 'package:news/common/router/auth_guard.dart';
import 'package:news/common/router/router.dart';
import 'package:news/global.dart';
import 'package:provider/provider.dart';

void main() {
  final appRouter = AppRouter(authGuard: AuthGuard());
  Global.init().then((e) => runApp(
    ChangeNotifierProvider(
        create: (_) => AppState(),
        child: Consumer<AppState>(builder: (context, appState, _) {
            if (appState.isGrayFilter) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
                child: MyApp(appRouter: appRouter),
              );
            } else {
              return MyApp(appRouter: appRouter);
            }
          }),
      ),
  ));
}
class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key,required this.appRouter});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config()
    );
  }
}
