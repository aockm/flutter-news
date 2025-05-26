import 'package:flutter/material.dart';

/// 系统相应状态
class AppState extends ChangeNotifier {
  late bool _isGrayFilter;

  get isGrayFilter => _isGrayFilter;

  AppState({bool isGrayFilter = false}) {
    _isGrayFilter = isGrayFilter;
  }

  // 切换灰色滤镜
  void switchGrayFilter() {
    _isGrayFilter = !_isGrayFilter;
    notifyListeners();
  }
}
