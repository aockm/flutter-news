import 'package:flutter/material.dart';
import 'package:flutter_news/global.dart';
import 'package:flutter_news/pages/index/index.dart';
import 'package:flutter_news/routes.dart';

void main() => Global.init().then((e) => runApp(MyApp()));
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
