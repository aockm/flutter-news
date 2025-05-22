import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    // 高度去掉 顶部、底部 导航
    ScreenUtil.init(context,
    designSize: Size(375, 812 - 44 - 34));
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter news"),
      ),
      body: Center(
        child: Container(
          child: Text("Hello world"),
        ),
      ),
    );
  }
}