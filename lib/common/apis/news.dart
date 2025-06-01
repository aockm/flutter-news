import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news/common/entitys/entitys.dart';
import 'package:news/common/utils/utils.dart';
import 'package:news/common/values/values.dart';

/// 新闻
class NewsAPI {
  /// 翻页
  static Future<NewsPageListResponseEntity> newsPageList({
    required BuildContext context,
    Map<String,dynamic>? params,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get(
      '/home/news', 
      context: context,
      params: params,
      refresh: refresh,
      cacheDisk: cacheDisk,
      cacheKey: STORAGE_INDEX_NEWS_CACHE_KEY,
    );
    return NewsPageListResponseEntity.fromJson(response['data']);
  }

  /// 推荐
  static Future<NewsRecommendResponseEntity> newsRecommend({
    required BuildContext context,
    Map<String,dynamic>? params,
    bool refresh = false,
    bool cacheDisk = false
  }) async {
    var response = await HttpUtil().get(
      '/home/recommend',
      context: context,
      params: params,
      refresh: refresh,
      cacheDisk: cacheDisk,
    );
    return NewsRecommendResponseEntity.fromJson(response['data']);
  }

  /// 分类
  static Future<List<CategoryResponseEntity>> categories({
    required BuildContext context,
    bool cacheDisk = false,
    } ) async {
    log("HttpUtil().get:$cacheDisk");
    var response = await HttpUtil().get(
      '/home/categories',
      context: context,
      cacheDisk: cacheDisk,
    );
    var dataList = Response.fromJson(response).data['list'];
    return dataList.map<CategoryResponseEntity>(
            (item) => CategoryResponseEntity.fromJson(item))
        .toList();
  }

  /// 频道
  static Future<List<ChannelResponseEntity>> channels({
    required BuildContext context,
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get(
      '/home/channels',
      context: context,
      cacheDisk: cacheDisk,
    );
    var dataList = Response.fromJson(response).data['list'];
    return dataList
        .map<ChannelResponseEntity>(
            (item) => ChannelResponseEntity.fromJson(item))
        .toList();
  }

  /// 标签列表
  // static Future<List<TagResponseEntity>> tags({Map<String,dynamic>? params}) async {
  //   var response = await HttpUtil().get('/home/tags', params: params);
  //     var dataList = Response.fromJson(response).data['list'];
  //   return dataList
  //       .map<TagResponseEntity>((item) => TagResponseEntity.fromJson(item))
  //       .toList();
  // }
}
