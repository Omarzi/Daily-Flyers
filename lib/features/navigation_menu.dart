import 'package:daily_flyers_app/features/home/presentation/screens/home_screen.dart';
import 'package:daily_flyers_app/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:daily_flyers_app/utils/constants/ad_managers.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;
  BannerAd? bannerAd;
  bool isBannerLoaded = false;

  void load() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdManagers.banner1,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isBannerLoaded = true;
          });
          logSuccess('Ad Loaded Success');
        },
        onAdFailedToLoad: (ad, error) {
          logError('Ad Loaded Failed');
          ad.dispose();
        },
        onAdOpened: (ad) {
          logSuccess('Ad Loaded Success');
        },
      ),
      request: const AdRequest(),
    )..load();
  }


  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    load();
  }

  Future<void> _initializeNotifications() async {
    bool isAllowed = await LocalNotifications.isNotificationAllowed();
    DCacheHelper.putBoolean(key: CacheKeys.notificationVariable, value: isAllowed);
    if (!isAllowed) {
      await LocalNotifications.requestPermissionToSendNotifications();
    }
    /// Initialize notifications
    await LocalNotifications.init();

    /// Show periodic notification
    LocalNotifications.showPeriodicNotification(
      title: '<b>${AppLocalizations.of(context)!.translate('dailyFlyers')!}</b>',
      body: AppLocalizations.of(context)!.translate('pleaseGoToAppToSeeNew')!,
      payload: AppLocalizations.of(context)!.translate('pleaseGoToAppToSeeNew')!,
    );
  }

  @override
  Widget build(BuildContext context) {
    List tabs = [
      const HomeScreen(),
      // const WishlistScreen(),
    ];
    return Scaffold(
    // if (isBannerLoaded)
    // Container(
    //   width: bannerAd!.size.width.toDouble(),
    //   height: bannerAd!.size.height.toDouble(),
    //   child: AdWidget(
    //     ad: bannerAd!,
    //     key: UniqueKey(),
    //   ),
    // )
    // else
    // SizedBox.shrink(),
    //
    // SizedBox(height: 10.h),
      backgroundColor: DColors.greyScale50,
      body: Stack(
        children: [
          tabs[currentIndex],

          // if (isBannerLoaded)
          //   Positioned(
          //     bottom: 0,
          //     child: Container(
          //       width: bannerAd!.size.width.toDouble(),
          //       height: bannerAd!.size.height.toDouble(),
          //       child: AdWidget(
          //         ad: bannerAd!,
          //         key: UniqueKey(),
          //       ),
          //     ),
          //   )
          // else
          //   const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.all(DStyles.bodySmallBold),
        ),
        child: NavigationBar(
          height: MediaQuery.of(context).size.width / 4,
          elevation: 0,
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: DColors.whiteColor,
          indicatorColor: DColors.primaryColor500.withOpacity(.1),
          destinations: [
            NavigationDestination(icon: const Icon(Iconsax.home), label: AppLocalizations.of(context)!.translate('home')!),
            // NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: const Icon(Iconsax.heart), label: AppLocalizations.of(context)!.translate('wishList')!),
            // NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
