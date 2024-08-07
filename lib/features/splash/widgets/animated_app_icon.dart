import '../../../utils/constants/exports.dart';

class AnimatedAppIcon extends StatefulWidget {
  const AnimatedAppIcon({super.key});

  @override
  State<AnimatedAppIcon> createState() => _AnimatedAppIconState();
}

class _AnimatedAppIconState extends State<AnimatedAppIcon>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<Offset>? slideAnimation;

  @override
  void initState() {
    logWarning(DCacheHelper.getString(key: CacheKeys.token).toString());
    super.initState();
    initSlidingAnimation();
    navigationToHome(context);
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut,
    ));

    animationController!.forward();
  }

  void navigationToHome(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        DCacheHelper.getString(key: CacheKeys.skipLogin)!.isNotEmpty || DCacheHelper.getString(key: CacheKeys.token)!.isNotEmpty
            // ? context.pushReplacementNamed(DRoutesName.navigationMenuRoute)
            ? context.pushReplacementNamed(DRoutesName.homeRoute)
            : context.pushReplacementNamed(DRoutesName.checkLanguageRoute, arguments: '');
      },
    );
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation!,
      child: Image.asset(DImages.appLogo),
    );
  }
}
