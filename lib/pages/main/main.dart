
import 'dart:async';
import 'dart:developer';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:news/common/apis/apis.dart';
import 'package:news/common/entitys/entitys.dart';
import 'package:news/common/utils/utils.dart';
import 'package:news/common/values/values.dart';
import 'package:news/common/widgets/widgets.dart';
import 'package:news/pages/main/ad_widget.dart';
import 'package:news/pages/main/categories_widget.dart';
import 'package:news/pages/main/channels_widget.dart';
import 'package:news/pages/main/news_item_widget.dart';
import 'package:news/pages/main/newsletter_widget.dart';
import 'package:news/pages/main/recommend_widget.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late EasyRefreshController _controller;

  late NewsPageListResponseEntity _newsPageList; // 新闻翻页
  late List<CategoryResponseEntity> _categories; // 分类
  late NewsItem _newsRecommend; // 新闻推荐
  late List<ChannelResponseEntity> _channels; // 频道

  String? _selCategoryCode; // 选中的分类Code
  bool _loading = true;
  
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );  
    _loadAllData();
    _loadLatestWithDiskCache();
  }
  
  // 如果有磁盘缓存，延迟1秒拉取更新档案
  _loadLatestWithDiskCache() {
    if (CACHE_ENABLE == true) {
      var cacheData = StorageUtil().getJSON(STORAGE_INDEX_NEWS_CACHE_KEY);
      if (cacheData != null) {
        Timer(Duration(seconds: 1), () {
          _controller.callRefresh();
        });
      }
    }
  }
  
  
  // 读取所有数据
  _loadAllData() async {
    log("初始化数据");
    _categories = await NewsAPI.categories(context: context,cacheDisk: true,);

    _channels = await NewsAPI.channels(context: context,cacheDisk: true,);

    _newsRecommend = await NewsAPI.newsRecommend(context: context,cacheDisk: true,);
    
    _newsPageList = await NewsAPI.newsPageList(context: context,cacheDisk: true,);

    _selCategoryCode = _categories.first.code;
    _loading = false;

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
    log("categoryCode:$categoryCode");
    _newsRecommend = await NewsAPI.newsRecommend(
      context: context,
      params:{"category":categoryCode},
      refresh: refresh,
      cacheDisk: true,
    );
    _newsPageList = await NewsAPI.newsPageList(
       context: context,
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
    if (_loading) {
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
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }
    return recommendWidget(context,_newsRecommend);
  }

  // 频道
  Widget _buildChannels() {
     if (_loading) {
      return Center(child: CircularProgressIndicator());
    }
    return newsChannelsWidget(
            channels: _channels,
            onTap: (ChannelResponseEntity item) {},
          );
  }

  // 新闻列表
  Widget _buildNewsList() {
     if (_loading) {
      return Container(height: duSetHeight(161 * 5 + 100.0),);
    }
    return Column(
            children: _newsPageList.items!.map((item) {
              // 新闻行
              List<Widget> widgets = <Widget>[
                newsItem(context,item),
                Divider(height: 1),
              ];
              // 每 5 条 显示广告
              int index = _newsPageList.items!.indexOf(item);
              if (((index + 1) % 5) == 0) {
                widgets.addAll(<Widget>[
                  adWidget(),
                  Divider(height: 1),
                ]);
              }
              return Column(
                children: widgets
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
    return _loading 
    ?cardListSkeletonWithShimmer()
    :EasyRefresh(
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