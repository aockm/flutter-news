import 'package:flutter/material.dart';
import 'package:flutter_news/common/provider/app.dart';
import 'package:flutter_news/global.dart';
import 'package:flutter_news/pages/index/index.dart';
import 'package:flutter_news/routes.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((e) => runApp(
  ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MyApp(),
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
