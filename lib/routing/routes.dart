import 'package:daily_flyers_app/utils/constants/exports.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case DRoutesName.splashRoute:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.leftToRight,
          settings: settings,
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 350),
        );
      case DRoutesName.navigationMenuRoute:
        return PageTransition(
          child: const NavigationMenu(),
          type: PageTransitionType.leftToRight,
          settings: settings,
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 350),
        );
      case DRoutesName.loginRoute:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.leftToRight,
          settings: settings,
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 350),
        );
      case DRoutesName.registerRoute:
        return PageTransition(
          child: const RegisterScreen(),
          type: PageTransitionType.leftToRight,
          settings: settings,
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 350),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '',
          ),
        ),
        body: const Center(
          child: Text(
            '',
          ),
        ),
      ),
    );
  }
}