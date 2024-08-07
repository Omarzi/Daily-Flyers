import 'package:daily_flyers_app/features/check_country/presentation/screens/check_counrty_screen.dart';
import 'package:daily_flyers_app/features/check_language/presentation/check_language_screen.dart';
import 'package:daily_flyers_app/features/home/presentation/screens/home_screen.dart';
import 'package:daily_flyers_app/features/home/presentation/screens/offers/all_photos_screen.dart';
import 'package:daily_flyers_app/features/home/presentation/screens/offers_screen.dart';
import 'package:daily_flyers_app/features/home/presentation/screens/profile_screen.dart';
import 'package:daily_flyers_app/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
//
// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings settings) {
//     PageTransitionType getTransitionType(BuildContext context) {
//       return AppLocalizations.of(context)!.isEnLocale
//           ? PageTransitionType.rightToLeft
//           : PageTransitionType.leftToRight;
//     }
//
//     switch (settings.name) {
//       case DRoutesName.splashRoute:
//         return PageTransition(
//           child: const SplashScreen(),
//           type: getTransitionType(),
//           settings: settings,
//           duration: const Duration(milliseconds: 350),
//           reverseDuration: const Duration(milliseconds: 350),
//         );
//       case DRoutesName.checkLanguageRoute:
//         return PageTransition(
//           child: const CheckLanguageScreen(),
//           type: getTransitionType(),
//           settings: settings,
//           duration: const Duration(milliseconds: 350),
//           reverseDuration: const Duration(milliseconds: 350),
//         );
//       case DRoutesName.checkCountryRoute:
//         return PageTransition(
//           child: const CheckSCountryScreen(),
//           type: getTransitionType(),
//           settings: settings,
//           duration: const Duration(milliseconds: 350),
//           reverseDuration: const Duration(milliseconds: 350),
//         );
//       // case DRoutesName.navigationMenuRoute:
//       //   return PageTransition(
//       //     child: const NavigationMenu(),
//       //     type: AppLocalizations.of(context)!.isEnLocale ? PageTransitionType.rightToLeft : getTransitionType(),
//       //     settings: settings,
//       //     duration: const Duration(milliseconds: 350),
//       //     reverseDuration: const Duration(milliseconds: 350),
//       //   );
//       case DRoutesName.navigationMenuRoute:
//         return PageRouteBuilder(
//           settings: settings,
//           pageBuilder: (context, animation, secondaryAnimation) => const NavigationMenu(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             var begin = AppLocalizations.of(context)!.isEnLocale
//                 ? const Offset(1.0, 0.0)
//                 : const Offset(-1.0, 0.0);
//             var end = Offset.zero;
//             var curve = Curves.easeInOut;
//
//             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);
//
//             return SlideTransition(position: offsetAnimation, child: child);
//           },
//         );
//       // case DRoutesName.homeRoute:
//       //   return PageTransition(
//       //     child: const HomeScreen(),
//       //     type: getTransitionType(),
//       //     settings: settings,
//       //     duration: const Duration(milliseconds: 350),
//       //     reverseDuration: const Duration(milliseconds: 350),
//       //   );
//       case DRoutesName.homeRoute:
//         return PageRouteBuilder(
//           settings: settings,
//           pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             var begin = AppLocalizations.of(context)!.isEnLocale
//                 ? const Offset(1.0, 0.0)
//                 : const Offset(-1.0, 0.0);
//             var end = Offset.zero;
//             var curve = Curves.easeInOut;
//
//             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);
//
//             return SlideTransition(position: offsetAnimation, child: child);
//           },
//         );
//       case DRoutesName.wishListRoute:
//         return PageRouteBuilder(
//           settings: settings,
//           pageBuilder: (context, animation, secondaryAnimation) => const WishlistScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             var begin = AppLocalizations.of(context)!.isEnLocale
//                 ? const Offset(1.0, 0.0)
//                 : const Offset(-1.0, 0.0);
//             var end = Offset.zero;
//             var curve = Curves.easeInOut;
//
//             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);
//
//             return SlideTransition(position: offsetAnimation, child: child);
//           },
//         );
//       // case DRoutesName.wishListRoute:
//       //   return PageTransition(
//       //     child: const WishlistScreen(),
//       //     type: getTransitionType(),
//       //     settings: settings,
//       //     duration: const Duration(milliseconds: 350),
//       //     reverseDuration: const Duration(milliseconds: 350),
//       //   );
//       case DRoutesName.loginRoute:
//         final String message = settings.arguments as String;
//
//         return PageTransition(
//           child: LoginScreen(message: message),
//           type: getTransitionType(),
//           settings: settings,
//           duration: const Duration(milliseconds: 350),
//           reverseDuration: const Duration(milliseconds: 350),
//         );
//       case DRoutesName.registerRoute:
//         return PageTransition(
//           child: const RegisterScreen(),
//           type: getTransitionType(),
//           settings: settings,
//           duration: const Duration(milliseconds: 350),
//           reverseDuration: const Duration(milliseconds: 350),
//         );
//       default:
//         return unDefinedRoute();
//     }
//   }
//
//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             '',
//           ),
//         ),
//         body: const Center(
//           child: Text(
//             '',
//           ),
//         ),
//       ),
//     );
//   }
// }

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    PageTransitionType getTransitionType(BuildContext context) {
      return AppLocalizations.of(context)!.isEnLocale
          ? PageTransitionType.rightToLeft
          : PageTransitionType.leftToRight;
    }

    Widget getPageWidget(String? name, RouteSettings settings) {
      switch (name) {
        case DRoutesName.splashRoute:
          return const SplashScreen();
        case DRoutesName.checkLanguageRoute:
          return const CheckLanguageScreen();
        case DRoutesName.checkCountryRoute:
          return const CheckSCountryScreen();
        case DRoutesName.navigationMenuRoute:
          return const NavigationMenu();
        case DRoutesName.homeRoute:
          return const HomeScreen();
        case DRoutesName.wishListRoute:
          return const WishlistScreen();
        case DRoutesName.loginRoute:
          final String message = settings.arguments as String;
          return LoginScreen(message: message);
        case DRoutesName.offersRoute:
          final Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
          return OffersScreen(data: data);
        case DRoutesName.registerRoute:
          return const RegisterScreen();
        case DRoutesName.allPhotosRoute:
          final Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
          return AllPhotosScreen(map: data);
        case DRoutesName.profileRoute:
          return const ProfileScreen();
        default:
          return const UndefinedRouteScreen();
      }
    }

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) {
        return getPageWidget(settings.name, settings);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = AppLocalizations.of(context)!.isEnLocale
            ? const Offset(1.0, 0.0)
            : const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}


class UndefinedRouteScreen extends StatelessWidget {
  const UndefinedRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
