import 'dart:io';
import 'package:daily_flyers_app/utils/constants/exports.dart';

class DDeviceUtils {

//   static Future<void> showDialogFunction({required BuildContext context, required String imagePath}) async {
//     await showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 40.w),
//           child: AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(24.r),
//               ),
//             ),
//             insetPadding: EdgeInsets.symmetric(horizontal: 2.w),
//             content: SizedBox(
//               width: 340.w,
//               height: 487.h,
//               child: Align(
//                 alignment: Alignment.center,
//                 child: SingleChildScrollView(
//                   physics: const NeverScrollableScrollPhysics(),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 32.w),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(height: 40.h),
//                         SvgPicture.asset(imagePath, fit: BoxFit.scaleDown, width: 186.w, height: 180.h),
//                         SizedBox(height: 32.h),
//                         Text('Congratulations!', style: DStyles.h4Bold, textAlign: TextAlign.center),
//                         SizedBox(height: 16.h),
//                         Text('Your account is ready to use. You will be redirected to the Home page in a few seconds..', style: DStyles.bodyLargeRegular, textAlign: TextAlign.center),
//                         SizedBox(height: 32.h),
//                         /// Loading
//                         LoadingWidget(iconColor: OColors.primaryColor500),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
// }
//   static Future<void> showDialogFunction2({
//     required BuildContext context,
//     required void Function(String) onToggle,
//     required String check,
//   }) async {
//     await showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 28.w),
//           child: Toggle(onToggle: onToggle, check: check,),
//         );
//       },
//     );
// }

//   static Future<void> showDialogFunction3({
//     required BuildContext context,
//     required void Function(String, String) onToggle,
//     required String check,
//     required String price,
//   }) async {
//     await showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 28.w),
//           child: Toggle2(onToggle: onToggle, check: check, price: price),
//         );
//       },
//     );
// }

  static Container buildDotWidget(int index, int currentIndex, BuildContext context, Decoration decoration) {
    return Container(
      height: 8.h,
      width: currentIndex == index ? 32.w : 8.w,
      margin: EdgeInsets.only(right: 6.w),
      decoration: decoration,
    );
  }

  static void showCustomBottomSheet({required BuildContext context, required Widget widget}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return widget;
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))),
      backgroundColor: Colors.transparent,
    );
  }

  // static void showSnackBar({required BuildContext context, required String message, required Color textColor, required TextStyle textStyle, bgColor}) {
  //   return FloatingSnackBar(
  //     message: message,
  //     context: context,
  //     textColor: textColor,
  //     textStyle: textStyle,
  //     duration: const Duration(milliseconds: 4000),
  //     backgroundColor: bgColor,
  //   );
  // }

  // static void initCacheHelper() async {
  //   await DCacheHelper.init();
  // }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: DColors.primaryColor500,
      systemNavigationBarColor: DColors.primaryColor500,
    ));
  }

  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getKeyBarHeight(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom;
  }

  static Future<bool> isKeyboardVisible(BuildContext context) async {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }

  static isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  }

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  static Future<void> setPreferredOrientations(List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch(_) {
      return false;
    }
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static void launchUrl(String url) async {
    if(await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}