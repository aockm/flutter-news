import 'package:flutter_news/common/entitys/entitys.dart';
import 'package:flutter_news/common/utils/utils.dart';

/// 新闻
class NewsAPI {
  /// 翻页
  static Future<NewsPageListResponseEntity> newsPageList({
    Map<String,dynamic>? params,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get('/home/news', params: params);
    return NewsPageListResponseEntity.fromJson(response['data']);
  }

  /// 推荐
  static Future<NewsRecommendResponseEntity> newsRecommend({
    Map<String,dynamic>? params,
    bool refresh = false,
    bool cacheDisk = false
  }) async {
    var response = await HttpUtil().get('/home/recommend', params: params);
    return NewsRecommendResponseEntity.fromJson(response['data']);
  }

  /// 分类
  static Future<List<CategoryResponseEntity>> categories() async {
    var response = await HttpUtil().get('/home/categories');
    var dataList = Response.fromJson(response).data['list'];
    return dataList.map<CategoryResponseEntity>(
            (item) => CategoryResponseEntity.fromJson(item))
        .toList();
  }

  /// 频道
  static Future<List<ChannelResponseEntity>> channels() async {
    var response = await HttpUtil().get('/home/channels');
    var dataList = Response.fromJson(response).data['list'];
    return dataList
        .map<ChannelResponseEntity>(
            (item) => ChannelResponseEntity.fromJson(item))
        .toList();
  }

  /// 标签列表
  static Future<List<TagResponseEntity>> tags({Map<String,dynamic>? params}) async {
    var response = await HttpUtil().get('/home/tags', params: params);
      var dataList = Response.fromJson(response).data['list'];
    return dataList
        .map<TagResponseEntity>((item) => TagResponseEntity.fromJson(item))
        .toList();
  }
}
