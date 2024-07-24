import 'package:daily_flyers_app/utils/constants/exports.dart';

class AppBoxShadows {
  /// Button Shadows

  /// Button Shadow One
  static final BoxShadow buttonShadowOne = BoxShadow(
    color: DColors.primaryColor500.withOpacity(.25),
    spreadRadius: 0,
    blurRadius: 24.r,
    offset: Offset(4.w, 8.h),
  );

  static final BoxShadow containersShadow = BoxShadow(
    color: DColors.greyScale200,
    blurRadius: 3.r,
    offset: Offset(1.w, 1.w),
    spreadRadius: 3.r,
  );
}