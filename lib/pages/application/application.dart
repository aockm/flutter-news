import 'package:flutter/material.dart';
import 'package:news/common/utils/utils.dart';
import 'package:news/common/values/values.dart';
import 'package:news/common/widgets/widgets.dart';
import 'package:news/pages/account/account.dart';
import 'package:news/pages/bookmarks/bookmarks.dart';
import 'package:news/pages/category/category.dart';
import 'package:news/pages/main/main.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {

  // 当前 tab 页码
  int _page = 0;
  // tab 页标题
  final List<String> _tabTitles = [
    'Welcome',
    'Cagegory',
    'Bookmarks',
    'Account'
  ];
  // 页控制器
  late PageController _pageController;

  // tab栏页码切换
  void _handlePageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
    // tab栏动画
  void _handleNavBarTap(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _page);
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // 底部导航项目
 final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Iconfont.home,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.home,
        color: AppColors.secondaryElementText,
      ),
      label: 'main',
      backgroundColor: AppColors.primaryBackground,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Iconfont.grid,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.grid,
        color: AppColors.secondaryElementText,
      ),
      label: 'category',
      backgroundColor: AppColors.primaryBackground,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Iconfont.tag,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.tag,
        color: AppColors.secondaryElementText,
      ),
      label: 'tag',
      backgroundColor: AppColors.primaryBackground,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Iconfont.me,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.me,
        color: AppColors.secondaryElementText,
      ),
      label: 'my',
      backgroundColor: AppColors.primaryBackground,
    ),
  ];

   // 顶部导航
  PreferredSizeWidget _buildAppBar() {
    return transparentAppBar(
        context: context,
        title: Text(
          _tabTitles[_page],
          style: TextStyle(
            color: AppColors.primaryText,
            fontFamily: 'Montserrat',
            fontSize: duSetFontSize(18.0),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: AppColors.primaryText,
            ),
            onPressed: () {},
          )
        ]
    );
  }

  // 内容页
  Widget _buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: _handlePageChanged,
      children: <Widget>[
        MainPage(),
        CategoryPage(),
        BookmarksPage(),
        AccountPage(),
      ],
    );
  }
  // 底部导航
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: _bottomTabs,
      currentIndex: _page,
      // fixedColor: AppColors.primaryElement,
      type: BottomNavigationBarType.fixed,
      onTap: _handleNavBarTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

