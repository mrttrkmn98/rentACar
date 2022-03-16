import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/app/widgets/default_notification_banner.dart';
import 'package:shopping_list/domain/types/enums/banner_type.dart';

const kprimaryColor = Color(0xff2666CA);
const kBackgroundColor = Color(0xffF8F8F8);
const kprimaryTextColor = Color(0xffffffff);

const red = Color(0xFFE90909);
const black = Color(0xFF000000);
const orange = Color(0xFFF3770A);
const brown = Color(0xFF7A400D);
const white = Color(0xFFFCFAFA);
const blue = Color(0xFF35A3E7);

const double kDefaultPadding = 20;

TextStyle mainTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}

TextStyle defaultTextStyle(Color color) {
  return TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 15);
}

TextStyle carDefaultTitleStyle(Color color) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 30);
}

TextStyle carDefaultTextStyle(Color color) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20);
}

LinearGradient get kLinearGradient {
  return LinearGradient(
      colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
      stops: [0.1, 0.3, 0.4],
      begin: Alignment(-1.0, -0.3),
      end: Alignment(1.0, 0.3),
      tileMode: TileMode.clamp);
}

void showBanner(BannerType bannerType, String text, BuildContext context) {
  if (bannerType == BannerType.SUCCESS) {
    return DefaultNotificationBanner(
            Icon(Icons.done_outline_outlined, color: Colors.white),
            text,
            Colors.greenAccent.shade700,
            context)
        .show();
  } else if (bannerType == BannerType.ERROR) {
    return DefaultNotificationBanner(
            Icon(Icons.error, color: Colors.white), text, Colors.red, context)
        .show();
  } else {
    return;
  }
}
