import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';


/// 使用 skeletons 实现卡片骨架列表
Widget cardListSkeleton() {
  return SkeletonListView(
    itemCount: 10,
    itemBuilder: (context, index) => ListTile(
      leading: SkeletonAvatar(
        style: SkeletonAvatarStyle(
          shape: BoxShape.circle,
          width: 40,
          height: 40,
        ),
      ),
      title: SkeletonLine(
        style: SkeletonLineStyle(
          height: 12,
          borderRadius: BorderRadius.circular(8),
          width: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
      subtitle: SkeletonLine(
        style: SkeletonLineStyle(
          height: 12,
          borderRadius: BorderRadius.circular(8),
          width: MediaQuery.of(context).size.width * 0.4,
        ),
      ),
    ),
  );
}
/// 使用 skeletons 实现整页段落骨架
Widget pageSkeleton() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SkeletonParagraph(
      style: SkeletonParagraphStyle(
        lines: 5,
        spacing: 12,
        lineStyle: SkeletonLineStyle(
          randomLength: true,
          height: 12,
          borderRadius: BorderRadius.circular(8),
          minLength: MediaQueryData.fromView(WidgetsBinding.instance.window).size.width * 0.5,
          maxLength: MediaQueryData.fromView(WidgetsBinding.instance.window).size.width * 0.9,
        ),
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