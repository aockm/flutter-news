
import 'dart:developer';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/common/apis/apis.dart';
import 'package:flutter_news/common/entitys/entitys.dart';
import 'package:flutter_news/common/utils/utils.dart';
import 'package:flutter_news/common/widgets/widgets.dart';
import 'package:flutter_news/pages/main/categories_widget.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late NewsPageListResponseEntity _newsPageList; // 新闻翻页
  late List<CategoryResponseEntity> _categories; // 分类
  late NewsRecommendResponseEntity _newsRecommend; // 新闻推荐
  late List<ChannelResponseEntity> _channels; // 频道

  String? _selCategoryCode; // 选中的分类Code
  bool _loading = true;
  
  @override
  void initState() {
    super.initState();  
    _loadAllData();
  }// 读取所有数据
  _loadAllData() async {
    log("初始化数据");
    _categories = await NewsAPI.categories();
    _channels = await NewsAPI.channels();
    _newsRecommend = await NewsAPI.newsRecommend();
    _newsPageList = await NewsAPI.newsPageList();

    _selCategoryCode = _categories.first.code;
    _loading = false;
    log(_selCategoryCode!);
    if (mounted) {
      setState(() {});
    }
  }

  // 分类菜单
  Widget _buildCategories() {
    if (_loading || _categories == null || _newsPageList == null || _newsRecommend==null||_channels==null) {
      return Center(child: CircularProgressIndicator());
    }
    return newsCategoriesWidget(
      categories: _categories,
      selCategoryCode: _selCategoryCode,
      onTap: (CategoryResponseEntity item) {
        setState(() {
          _selCategoryCode = item.code!;
        });
      },
    );
  }

  // 推荐阅读
  Widget _buildRecommend() {
    return Container(
      height: duSetHeight(490),
      color: Colors.amber,
    );
  }

  // 频道
  Widget _buildChannels() {
    return Container(
      height: duSetHeight(137),
      width: double.infinity,
      color: Colors.blueAccent,
      child: Text("频道"),
    );
  }

  // 新闻列表
  Widget _buildNewsList() {
    return Container(
      height: duSetHeight(161 * 5 + 100.0),
      color: Colors.purple,
      child: Text("新闻列表"),
    );
  }

  // ad 广告条
  // 邮件订阅
  Widget _buildEmailSubscribe() {
    return Container(
      height: duSetHeight(259),
       width: double.infinity,
      color: Colors.brown,
      child: Text("邮件订阅"),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCategories(),
          _buildRecommend(),
          _buildChannels(),
          _buildNewsList(),
          _buildEmailSubscribe(),
        ],
      ),
    );
  }
}