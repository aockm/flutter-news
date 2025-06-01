import 'dart:collection';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news/common/utils/utils.dart';
import 'package:news/common/values/values.dart';

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    if (!CACHE_ENABLE) handler.next(options);

    // refresh标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;
    
    // 是否磁盘缓存
    bool cacheDisk = options.extra["cacheDisk"] == true;
    log("今日换成拦截");
    // 如果是下拉刷新，先删除相关缓存
    if (refresh) {
      log("下拉刷新，先删除相关缓存");
      if (options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        log("刷新删除list:${options.path}");
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        log("刷新删除:${options.path}");
        // 如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }

      // 删除磁盘缓存
      if (cacheDisk) {
        log("删除磁盘缓存");
        await StorageUtil().remove(options.uri.toString());
      }
    }

    log("${options.extra["noCache"]} ${options.method.toLowerCase()}");
    // get 请求，开启缓存
    if (options.extra["noCache"] != true &&
      options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 策略 1 内存缓存优先，2 然后才是磁盘缓存
      // 1 内存缓存
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            CACHE_MAXAGE) {
          log("返回缓存内容:$key");
          return handler.resolve(ob.response);
        } else {
          //若已过期则删除缓存，继续向服务器请求
          log("继续向服务器请求:$key");
          cache.remove(key);
        }
      }

      // 2 磁盘缓存
      if (cacheDisk) {
        log("磁盘缓存");
        var cacheData = StorageUtil().getJSON(key);
        // log("cacheData:$cacheData");
        if (cacheData != null) {
          log("返回磁盘缓存内容:$key");
          return handler.resolve(Response(
            requestOptions: options,
            statusCode: 200,
            data: cacheData,
          ));
        }
      }
      
    }
    log("其他请求:${options.path}");
    handler.next(options);
  }

  @override
  onError(DioException err,ErrorInterceptorHandler handler) async {
   
    // // 错误状态不缓存
    log(err.message??"缓存错误");
  }

  @override
  onResponse(Response response,ResponseInterceptorHandler handler) async {
    // 如果启用缓存，将返回结果保存到缓存
    if (CACHE_ENABLE) {
      log("返回结果保存到缓存");
      await _saveCache(response,handler);
    }
    log("缓存响应");
    handler.next(response);
  }

  Future<void> _saveCache(Response response,ResponseInterceptorHandler handler) async {
    RequestOptions options = response.requestOptions;

    // 只缓存 get 的请求
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      // 缓存key
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      // 策略：内存、磁盘都写缓存
      // 内存缓存
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == CACHE_MAXCOUNT) {
        cache.remove(cache[cache.keys.first]);
      }
      // 保存到内存缓存
      cache[key] = CacheObject(response);
      log("缓存:$key");

      // 磁盘缓存
      if (options.extra["cacheDisk"] == true) {
        log("磁盘缓存$key");
        await StorageUtil().setJSON(key, response.data);
      }

      // handler.next(response); // 继续响应
    }
    // handler.next(response);
  }

  void delete(String key) {
    cache.remove(key);
  }
}
