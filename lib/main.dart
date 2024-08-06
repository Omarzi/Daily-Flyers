import 'dart:async';
import 'package:daily_flyers_app/utils/constants/bloc_observer.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:daily_flyers_app/utils/device/device_utility.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Bloc.observer = MyBlocObserver();
  /// Shared Pref
  // await DDeviceUtils.initCacheHelper();
  await DCacheHelper.init();
  /// Status Bar
  DDeviceUtils.setStatusBarColor(DColors.primaryColor500);
  DDeviceUtils.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const DailyFlyersApp());
}