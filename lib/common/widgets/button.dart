import 'package:flutter/material.dart';
import 'package:news/common/utils/utils.dart';
import 'package:news/common/values/values.dart';

/// 扁平圆角按钮
Widget btnFlatButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color gbColor = AppColors.primaryElement,
  String title = "button",
  Color fontColor = AppColors.primaryElementText,
  double fontSize = 18,
  String fontName = "Montserrat",
  FontWeight fontWeight = FontWeight.w400,
}) {
  return SizedBox(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: gbColor,
        shape: RoundedRectangleBorder(
        borderRadius: Radii.k6pxRadius,
      ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontFamily: fontName,
          fontWeight: fontWeight,
          fontSize: duSetFontSize(fontSize),
          height: 1,
        ),
      ),
    ),
  );
}

/// 第三方按钮
Widget btnFlatButtonBorderOnlyWidget({
  required VoidCallback onPressed,
  double width = 88,
  double height = 44,
  String? iconFileName,
}) {
  return SizedBox(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
              side: Borders.primaryBorder,
              borderRadius: Radii.k6pxRadius,
            ),
      ),
      
      child: Image.asset(
        "assets/images/icons-$iconFileName.png",
      ),
    ),
  );
}
