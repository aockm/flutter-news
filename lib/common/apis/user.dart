import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/common/entitys/entitys.dart';
import 'package:news/common/utils/utils.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserLoginResponseEntity> login({
    required BuildContext context,
    Map<String,dynamic>? params,
  }) async {
    var response = await HttpUtil().post(
      '/userInfo/login',
      context: context,
      params: params,
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  /// 注册
  static Future<Map<String, dynamic>> register({
    required BuildContext context,
    Map<String,dynamic>? params,
  }) async {
    var response = await HttpUtil().post(
      '/userInfo/register',
      context: context,
      params: params,
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return response;
  }
}
