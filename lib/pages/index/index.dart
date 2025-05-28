import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/global.dart';
import 'package:flutter_news/pages/application/application.dart';
import 'package:flutter_news/pages/sign_in/sign_in.dart';
import 'package:flutter_news/pages/welcome/welcome_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(
    //   context,
    //   width: 375,
    //   height: 812 - 44 - 34,
    //   allowFontScaling: true,
    // );
    ScreenUtilInit(
      designSize: Size(375, 812 - 44 - 34), // UI设计稿的尺寸（逻辑像素）
      minTextAdapt: true,
      splitScreenMode: true,
    );
    return Scaffold(
      body: Global.isFirstOpen == true
          ? WelcomePage()
          : Global.isOfflineLogin == true ? ApplicationPage() : SignInPage(),
    );
  }
}
