
import 'dart:developer';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/common/apis/apis.dart';
import 'package:flutter_news/common/entitys/entitys.dart';
import 'package:flutter_news/common/utils/utils.dart';
import 'package:flutter_news/pages/main/categories_widget.dart';
import 'package:flutter_news/pages/main/channels_widget.dart';
import 'package:flutter_news/pages/main/news_item_widget.dart';
import 'package:flutter_news/pages/main/newsletter_widget.dart';
import 'package:flutter_news/pages/main/recommend_widget.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late EasyRefreshController _controller;

  late NewsPageListResponseEntity _newsPageList; // 新闻翻页
  late List<CategoryResponseEntity> _categories; // 分类
  late NewsRecommendResponseEntity _newsRecommend; // 新闻推荐
  late List<ChannelResponseEntity> _channels; // 频道

  String? _selCategoryCode; // 选中的分类Code
  bool _loading = true;
  
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();  
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
  // 拉取推荐、新闻
  _loadNewsData(
    categoryCode, {
    bool refresh = false,
  }) async {
    _selCategoryCode = categoryCode;
    _newsRecommend = await NewsAPI.newsRecommend(
      params: {"categoryCode": categoryCode},
      refresh: refresh,
      cacheDisk: true,
    );
    _newsPageList = await NewsAPI.newsPageList(
      params: {"categoryCode": categoryCode},
      refresh: refresh,
      cacheDisk: true,
    );

    if (mounted) {
      setState(() {});
    }
  }
  // 分类菜单
  Widget _buildCategories() {
    if (_loading || _categories == null) {
      return Center(child: CircularProgressIndicator());
    }
    return newsCategoriesWidget(
      categories: _categories,
      selCategoryCode: _selCategoryCode,
      onTap: (CategoryResponseEntity item) {
        _loadNewsData(item.code);
      },
    );
  }

  // 推荐阅读
  Widget _buildRecommend() {
    if (_loading || _newsRecommend==null) {
      return Center(child: CircularProgressIndicator());
    }
    return recommendWidget(_newsRecommend);
  }

  // 频道
  Widget _buildChannels() {
     if (_loading || _channels==null) {
      return Center(child: CircularProgressIndicator());
    }
    return newsChannelsWidget(
            channels: _channels,
            onTap: (ChannelResponseEntity item) {},
          );
  }

  // 新闻列表
  Widget _buildNewsList() {
     if (_loading || _newsPageList == null) {
      return Container(height: duSetHeight(161 * 5 + 100.0),);
    }
    return Column(
            children: _newsPageList.items!.map((item) {
              return Column(
                children: <Widget>[
                  newsItem(item),
                  Divider(height: 1),
                ],
              );
            }).toList(),
          );
  }

  // ad 广告条
  // 邮件订阅
  Widget _buildEmailSubscribe() {
    return newsletterWidget();
  }

  
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _controller,
      header: const ClassicHeader(),
      onRefresh: () async {
        await _loadNewsData(
          _selCategoryCode,
          refresh: true,
        );
        _controller.finishRefresh();
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildCategories(),
            Divider(height: 1),
            _buildRecommend(),
            Divider(height: 1),
            _buildChannels(),
            Divider(height: 1),
            _buildNewsList(),
            Divider(height: 1),
            _buildEmailSubscribe(),
          ],
        ),
      ),
    );
  }
}