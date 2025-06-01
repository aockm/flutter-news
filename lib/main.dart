import 'package:flutter/material.dart';
import 'package:news/common/provider/app.dart';
import 'package:news/global.dart';
import 'package:news/pages/index/index.dart';
import 'package:news/routes.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((e) => runApp(
  ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(builder: (context, appState, _) {
          if (appState.isGrayFilter) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
              child: MyApp(),
            );
          } else {
            return MyApp();
          }
        }),
    ),
));
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Demo',
      home: IndexPage(),
      routes: staticRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
