import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/common/entitys/entitys.dart';
import 'package:flutter_news/common/utils/utils.dart';
import 'package:flutter_news/common/values/values.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late EasyRefreshController _controller ; // EasyRefresh控制器

  late NewsPageListResponseEntity _newsPageList; // 新闻翻页
  late NewsItem _newsRecommend; // 新闻推荐
  late List<CategoryResponseEntity> _categories; // 分类
  late List<ChannelResponseEntity> _channels; // 频道

  late String _selCategoryCode; // 选中的分类Code
  
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(controlFinishRefresh: true);
    _loadAllData();
    _loadLatestWithDiskCache();
  }
  // 如果有磁盘缓存，延迟3秒拉取更新档案
  _loadLatestWithDiskCache() {
    if (CACHE_ENABLE == true) {
      var cacheData = StorageUtil().getJSON(STORAGE_INDEX_NEWS_CACHE_KEY);
      if (cacheData != null) {
        Timer(Duration(seconds: 3), () {
          _controller.callRefresh();
        });
      }
    }
  }
 
   // 读取所有数据
  _loadAllData() async {
    // _categories = await NewsAPI.categories(
    //   context: context,
    //   cacheDisk: true,
    // );
    // _channels = await NewsAPI.channels(
    //   context: context,
    //   cacheDisk: true,
    // );
    // _newsRecommend = await NewsAPI.newsRecommend(
    //   context: context,
    //   cacheDisk: true,
    // );
    // _newsPageList = await NewsAPI.newsPageList(
    //   context: context,
    //   cacheDisk: true,
    // );

    // _selCategoryCode = _categories.first.code!;

    if (mounted) {
      setState(() {});
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Text("hello");
  }
}