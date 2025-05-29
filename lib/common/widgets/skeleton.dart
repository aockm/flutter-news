import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


/// shimmer 实现 - 骨架屏卡片列表
Widget cardListSkeletonWithShimmer({int length = 10}) {
  return ListView.builder(
    itemCount: length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 左边圆形头像
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16.0),
              // 右侧文本行
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12.0,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      height: 12.0,
                      width: MediaQuery.of(context).size.width * 0.6,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// shimmer 实现 - 页面骨架屏
Widget pageSkeletonWithShimmer({int totalLines = 5}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(totalLines, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              height: 12.0,
              width: (index % 3 == 0)
                  ? double.infinity
                  : MediaQueryData.fromView(WidgetsBinding.instance.window)
                          .size
                          .width *
                      (0.5 + 0.3 * (index % 2)),
              color: Colors.white,
            ),
          );
        }),
      ),
    ),
  );
}


  /// 骨架屏-卡片
// Widget cardListSkeleton() {
//   return PKCardListSkeleton(
//     isCircularImage: true,
//     isBottomLinesActive: false,
//     length: 10,
//   );
// }

/// 页面骨架屏
// Widget pageSkeleton() {
//   return PKCardPageSkeleton(
//     totalLines: 5,
//   );
// }