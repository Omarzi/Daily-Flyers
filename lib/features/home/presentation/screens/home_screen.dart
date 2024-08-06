import 'package:daily_flyers_app/common/widgets/change_widgets/change_language_widget.dart';
import 'package:daily_flyers_app/features/home/managers/home_cubit.dart';
import 'package:daily_flyers_app/features/wishlist/ads/ads.dart';
import 'package:daily_flyers_app/utils/constants/ad_managers.dart';
import 'package:daily_flyers_app/utils/constants/api_constants.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:daily_flyers_app/utils/device/device_utility.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../check_country/managers/counties_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? bannerAd;
  bool isBannerLoaded = false;

  String selectedCountry = '';
  String? selectedCountryId;
  String? selectedCountryImage;
  String? selectedCountryNameAr;
  String? selectedCountryNameEn;
  bool selectOnTap = false;
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  TextEditingController searchController = SearchController();
  bool isClearIcon = false;

  late final PageController pageController;
  int pageNumber = 0;
  Timer? pageChangeTimer;

  late Timer carouselTimer = getTimer();

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;

      if (pageController.hasClients) {
        setState(() {
          pageNumber = (pageNumber + 1) % HomeCubit.get(context).getAllBannersModel.data!.length;
        });
        pageController.animateToPage(
          pageNumber,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCirc,
        );
      }
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isOnNotificationEnabled = false;

  // bool isSelectedOnOneCategory = false;
  int selectedCategoryIndex = 0;
  // List<int> selectedCompanyIndices = [];

  bool isFavorite = false; /// Track whether the item is favorite

  @override
  void initState() {
    // HomeCubit.get(context).getAllBannersFunction();
    HomeCubit.get(context).getAllBannersFunction();
    HomeCubit.get(context).getAllCategoriesFunction();
    HomeCubit.get(context).getAllCompaniesFunction(page: 1, limit: 8);
    logError(DCacheHelper.getString(key: CacheKeys.countryNameEn).toString());
    CountiesCubit.get(context).getAllCountriesFunction();
    selectedCountryNameAr = DCacheHelper.getString(key: CacheKeys.countryNameAr);
    selectedCountryNameEn = DCacheHelper.getString(key: CacheKeys.countryNameEn);
    selectedCountryImage = DCacheHelper.getString(key: CacheKeys.countryImage);
    _loadNotificationPreference();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );
    _fetchNotificationStatus();
    /// Delay the start of the timer until after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        carouselTimer = getTimer();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(HomeCubit.get(context).companiesList.length < HomeCubit.get(context).totalCompaniesCount) {
          setState(() {
            isLoadingMore = true;
            page++;
          });

          HomeCubit.get(context).getAllCompaniesFunction(page: page).then((value) {
            setState(() {
              isLoadingMore = false;
            });
          });
        }
      }
    });
    // // Initialize the banner ad
    // bannerAd = BannerAd(
    //   adUnitId: 'ca-app-pub-1629700119082334/3820906761',
    //   size: AdSize.banner,
    //   request: const AdRequest(),
    //   listener: BannerAdListener(
    //     onAdLoaded: (ad) {
    //       setState(() {
    //         isBannerLoaded = true;
    //       });
    //       logSuccess('Ad Loaded Success');
    //     },
    //     onAdFailedToLoad: (ad, error) {
    //       logError('Ad Loaded Failed $error');
    //       setState(() {
    //         isBannerLoaded = false;
    //       });
    //       ad.dispose();
    //     },
    //     onAdOpened: (ad) {
    //       logSuccess('Ad Loaded Success');
    //     },
    //   ),
    // );
    // bannerAd.load();
    load();
    super.initState();
  }

  @override
  void dispose() {
    // if(isBannerLoaded) {
    //   bannerAd!.dispose();
    // }
    bannerAd?.dispose();
    pageController.dispose();
    carouselTimer.cancel();
    super.dispose();
  }

  Future<void> _loadNotificationPreference() async {
    setState(() {
      isOnNotificationEnabled = DCacheHelper.getBoolean(
          defaultValue: false, key: CacheKeys.notificationVariable);
    });
    if (!isOnNotificationEnabled) {
      await openNotifications();
    }
  }

  Future<void> _saveNotificationPreference(bool value) async {
    DCacheHelper.putBoolean(key: CacheKeys.notificationVariable, value: value);
  }

  Future<void> openNotifications() async {
    bool isAllowed = await LocalNotifications.isNotificationAllowed();
    if (!isAllowed) {
      await LocalNotifications.requestPermissionToSendNotifications();
    }

    if (isAllowed) {
      /// Initialize notifications
      await LocalNotifications.init();

      /// Show periodic notification
      LocalNotifications.showPeriodicNotification(
        title: AppLocalizations.of(context)!.translate('dailyFlyers')!,
        body: AppLocalizations.of(context)!.translate('pleaseGoToAppToSeeNew')!,
        payload: AppLocalizations.of(context)!.translate('pleaseGoToAppToSeeNew')!,
        // 'Please, go to app to see new offers',
      );
    } else {
      setState(() {
        isOnNotificationEnabled = false;
      });
      await _saveNotificationPreference(false);
    }
  }

  Future<void> closeNotifications() async {
    await LocalNotifications.openNotificationSettings();
    await LocalNotifications.cancelAll();
    setState(() {
      isOnNotificationEnabled = false;
    });
    await _saveNotificationPreference(false);
  }

  void onSearchChanged(String query) {
    setState(() {
      page = 1;
    });
    HomeCubit.get(context).getAllCompaniesFunction(search: query, page: page);
  }

  // BannerAd bannerAd = BannerAd(
  //   size: AdSize.banner,
  //   adUnitId: 'ca-app-pub-1629700119082334/2974728956',
  //   listener: BannerAdListener(
  //     onAdLoaded: (ad) {
  //       logSuccess('Ad Loaded Success');
  //     },
  //     onAdFailedToLoad: (ad, error) {
  //       logError('Ad Loaded Failed');
  //       ad.dispose();
  //     },
  //     onAdOpened: (ad) {
  //       logSuccess('Ad Loaded Success');
  //     },
  //   ),
  //   request: const AdRequest(),
  // );
  
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

  Future<void> _fetchNotificationStatus() async {
    final isAllowed = await LocalNotifications.isNotificationAllowed();
    setState(() {
      isOnNotificationEnabled = isAllowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.greyScale50,
      key: scaffoldKey,
      drawer: Drawer(
        backgroundColor: DColors.greyScale50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            /// App Logo - Name
            DrawerHeader(
                decoration: BoxDecoration(
                  color: DColors.primaryColor500,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundColor: DColors.whiteColor,
                      // backgroundImage: const AssetImage(DImages.appLogo),
                      child: Image.asset(DImages.appLogo,
                          width: DDeviceUtils.getScreenWidth(context) / 6),
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate('dailyFlyers')!,
                      style: TextStyle(
                        color: DColors.whiteColor,
                        fontSize: 24,
                      ),
                    ),
                  ],
                )),

            /// Make Login
            if(DCacheHelper.getString(key: CacheKeys.skipLogin)!.isNotEmpty) ListTile(
              leading: const Icon(Iconsax.login),
              title: Text(AppLocalizations.of(context)!.translate('makeLogin')!, style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () {
                context.pushNamed(DRoutesName.loginRoute, arguments: 'makeLoginFromNavigation');
              },
            ),


            if (selectedCountryNameAr != null || selectedCountryNameEn != null)
            /// Country name
            ListTile(
              leading: selectedCountryImage != null
                  ? Image.network(selectedCountryImage!, height: 30.h, width: 30.w, errorBuilder: (context, error, stackTrace) {return Lottie.asset('assets/lotties/loadingImage.json');},)
                  : null,
              title: Text(AppLocalizations.of(context)!.isEnLocale ? selectedCountryNameEn ?? '' : selectedCountryNameAr ?? '', style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.check, size: 26.sp, color: DColors.primaryColor500),
              onTap: () {
                // showCountriesDialog();
                // DDeviceUtils.showCustomBottomSheet(context: context, widget: const ChangeCountryWidget());
              },
            ),

            /// Home
            ListTile(
              leading: const Icon(Iconsax.home),
              title: Text(AppLocalizations.of(context)!.translate('home')!, style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () {
                // Handle drawer item tap
              },
            ),

            /// Profile
            ListTile(
              leading: const Icon(Iconsax.personalcard),
              title: Text(AppLocalizations.of(context)!.translate('profile')!, style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () {
                // Handle drawer item tap
                context.pushNamed(DRoutesName.profileRoute);
                // DDeviceUtils.showCustomBottomSheet(context: context, widget: const ChangeLanguageWidget());
              },
            ),

            /// Settings
            // ListTile(
            //   leading: const Icon(Iconsax.settings),
            //   title: Text('Settings', style: DStyles.bodyXLargeRegular),
            //   trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
            //   onTap: () {
            //     // Handle drawer item tap
            //   },
            // ),
            ListTile(
              leading: const Icon(Iconsax.language_circle),
              title: Text(AppLocalizations.of(context)!.translate('changeLanguage')!, style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () {
                // Handle drawer item tap
                DDeviceUtils.showCustomBottomSheet(context: context, widget: const ChangeLanguageWidget());
              },
            ),

            /// Notifications
            // ListTile(
            //   leading: const Icon(Iconsax.notification),
            //   title: Text(AppLocalizations.of(context)!.translate('notifications')!, style: DStyles.bodyXLargeRegular),
            //   trailing: SwitchWidget(
            //     // valueData: isOnNotificationEnabled,
            //     valueData: isOnNotificationEnabled,
            //     onChanged: (value) async {
            //       logSuccess(value.toString());
            //       setState(() {
            //         isOnNotificationEnabled = value;
            //       });
            //
            //       await _saveNotificationPreference(value);
            //
            //       if (isOnNotificationEnabled) {
            //         logError('Load');
            //         await _fetchNotificationStatus();
            //         await _loadNotificationPreference();
            //         await openNotifications();
            //       } else {
            //         await LocalNotifications.cancelAll();
            //       }
            //
            //       if (mounted) {
            //         setState(() {
            //           isOnNotificationEnabled = value;
            //         });
            //       }
            //     },
            //   ),
            // ),

            /// Share the app
            ListTile(
              leading: const Icon(Iconsax.share),
              title: Text(AppLocalizations.of(context)!.translate('shareTheApp')!, style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () async {
                // Handle drawer item tap
                // logSuccess(DCacheHelper.getBoolean(defaultValue: false, key: CacheKeys.notificationVariable).toString());
                bool boo = await LocalNotifications.isNotificationAllowed();
                logSuccess(boo.toString());
              },
            ),

            /// About us
            ListTile(
              leading: const Icon(Iconsax.info_circle),
              title: Text(AppLocalizations.of(context)!.translate('aboutUs')!, style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () {
                // Handle drawer item tap
              },
            ),

            /// Logout
            ListTile(
              leading: Icon(Iconsax.logout, color: DColors.error),
              title: Text(AppLocalizations.of(context)!.translate('logout')!, style: DStyles.bodyXLargeRegular.copyWith(color: DColors.error)),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp, color: DColors.error),
              onTap: () {
                // Handle drawer item tap
                DCacheHelper.removeFromShared(key: CacheKeys.token);
                context.pushNamedAndRemoveUntil(DRoutesName.loginRoute, predicate: (Route<dynamic> route) => false, arguments: '');
              },
            ),

            /// Remove account
            ListTile(
              leading: Icon(Iconsax.card_remove, color: DColors.error),
              title: Text(AppLocalizations.of(context)!.translate('removeAccount')!, style: DStyles.bodyXLargeRegular.copyWith(color: DColors.error)),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp, color: DColors.error),
              onTap: () {
                // Handle drawer item tap
              },
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..getAllCompaniesFunction(page: 1, limit: 8)..getAllCategoriesFunction()..getAllBannersFunction(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if(state is AddToFavoriteSuccessState) {
              SnackBar snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.translate('addToFav')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)), backgroundColor: DColors.success);
              HomeCubit.get(context).getAllCompaniesFunction(page: 1, limit: 8);

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if(state is AddToFavoriteErrorState) {
              SnackBar snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.translate('youMustGoToYourFav')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)), backgroundColor: DColors.error);

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);

            return SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      children: [
                        /// AppBar
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              top: 15.h, left: 15.w, right: 15.w, bottom: 6.h),
                          decoration: BoxDecoration(
                            color: DColors.primaryColor500,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.r),
                              bottomRight: Radius.circular(20.r),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// Menu - Notification Icons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _fetchNotificationStatus();
                                      scaffoldKey.currentState?.openDrawer();
                                    },
                                    child: Icon(Icons.menu, color: DColors.whiteColor, size: 30.sp),
                                  ),

                                  GestureDetector(
                                    onTap: () => context.pushNamed(DRoutesName.wishListRoute),
                                    child: Row(
                                      children: [
                                        Text(AppLocalizations.of(context)!.translate('favourites')!, style: DStyles.h5Bold.copyWith(color: DColors.whiteColor)),
                                        SizedBox(width: 15.w),
                                        Icon(Iconsax.heart, color: DColors.whiteColor, size: 30.sp),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 15.h),

                              /// App Name
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 3.w, bottom: 15.h),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('dailyFlyers')!,
                                      style: DStyles.h4Bold
                                          .copyWith(color: DColors.whiteColor),
                                    ),
                                  ),
                                ],
                              ),

                              /// Search Bar
                              Container(
                                margin: EdgeInsets.only(left: 5.w, bottom: 20.h),
                                width: DDeviceUtils.getScreenWidth(context),
                                height: 55.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: DColors.whiteColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: TextFormField(
                                  controller: searchController,
                                  style: DStyles.bodyLargeBold.copyWith(fontSize: 16.sp),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalizations.of(context)!.translate('searchHere')!,
                                    hintStyle: DStyles.bodyLargeBold
                                        .copyWith(color: DColors.greyScale600),
                                    prefixIcon: Icon(Iconsax.search_normal, size: 25.sp),
                                    suffixIcon: isClearIcon
                                        ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          searchController.clear();
                                          isClearIcon = false;
                                          onSearchChanged('');
                                        });
                                      },
                                      child:
                                      Icon(Iconsax.close_circle, size: 25.sp),
                                    )
                                        : null,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                        DDeviceUtils.getScreenHeight(context) / 55),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      isClearIcon = searchController.text.isNotEmpty;
                                    });
                                    onSearchChanged(value);
                                    logError(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: homeCubit.getAllBannersModel.data == null && homeCubit.categoriesList.isEmpty && homeCubit.companiesList.isEmpty
                              ? Column(
                            children: [
                              DDeviceUtils.buildBannersShimmer(context),
                              DDeviceUtils.buildCategoriesShimmer(context),
                              Expanded(child: DDeviceUtils.buildCompaniesShimmer(context)),
                            ],
                          )
                              : RefreshIndicator(
                            onRefresh: () {
                              return homeCubit.getAllCompaniesFunction(page: page, limit: 8);
                            },
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                children: [
                                  /// Banners
                                  (homeCubit.getAllBannersModel.data?.isEmpty ?? true)
                                      // ? const SizedBox.shrink()
                                      ? DDeviceUtils.buildBannersShimmer(context)
                                      : SizedBox(
                                    height: DDeviceUtils.getScreenHeight(context) / 4.8,
                                    child: PageView.builder(
                                      controller: pageController,
                                      onPageChanged: (value) {
                                        pageNumber = value;
                                        setState(() {});
                                      },
                                      itemCount: homeCubit.getAllBannersModel.data?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        var bannersList = homeCubit.getAllBannersModel.data;

                                        return AnimatedBuilder(
                                          animation: pageController,
                                          builder: (context, child) {
                                            return child!;
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(12.sp),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(24.r),
                                              // image: DecorationImage(image: AssetImage(DConstants.bannerImages[index]), fit: BoxFit.cover,
                                              image: DecorationImage(image: NetworkImage('${ApiConstants.baseUrlForImageInBanner}${bannersList![index].image!}'), fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  /// Dots
                                  (homeCubit.getAllBannersModel.data?.isEmpty ?? true)
                                      ? const SizedBox.shrink()
                                      : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      homeCubit.getAllBannersModel.data?.length ?? 0,
                                          (index) => Container(
                                        margin: EdgeInsets.all(1.w),
                                        child: Icon(Icons.circle, size: 12.sp, color: pageNumber == index ? DColors.primaryColor500 : DColors.greyScale300),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10.h),

                                  /// Categories
                                  Container(
                                    height: DDeviceUtils.getScreenHeight(context) / 12,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      // itemCount: DConstants.categoriesName.length,
                                      itemCount: homeCubit.categoriesList.length,
                                      itemBuilder: (context, index) {
                                        bool isSelected = selectedCategoryIndex == index;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedCategoryIndex = index;
                                            });
                                            if (homeCubit.categoriesList[index].enName == 'All' || homeCubit.categoriesList[index].arName == 'الكل') {
                                              homeCubit.getAllCompaniesFunction(page: 1, limit: 8, filter: null);
                                            } else {
                                              homeCubit.getAllCompaniesFunction(page: 1, limit: 8, filter: homeCubit.categoriesList[index].id.toString());
                                            }
                                          },
                                          child: Center(
                                            child: AnimatedContainer(
                                              duration: const Duration(milliseconds: 300),
                                              margin: AppLocalizations.of(context)!.isEnLocale ? EdgeInsets.only(left: 15.w, right: index == homeCubit.categoriesList.length - 1 ? 10.w : 0) : EdgeInsets.only(right: 15.w, left: index == homeCubit.categoriesList.length - 1 ? 10.w : 0),
                                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? DColors.primaryColor500
                                                    : DColors.whiteColor,
                                                borderRadius: BorderRadius.circular(6.r),
                                                border: isSelected
                                                    ? null
                                                    : Border.all(color: DColors.greyScale600, width: .8.w),
                                                boxShadow: [AppBoxShadows.containersShadow],
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)!.isEnLocale ? homeCubit.categoriesList[index].enName! : homeCubit.categoriesList[index].arName!,
                                                style: DStyles.bodyMediumMedium.copyWith(color: selectedCategoryIndex == index ? DColors.whiteColor : DColors.greyScale900),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  /// Data
                                  homeCubit.companiesList == []
                                      ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset('assets/lotties/emptyCompanies.json', height: DDeviceUtils.getScreenHeight(context) / 6),
                                      SizedBox(height: DDeviceUtils.getScreenHeight(context) / 15),
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('thereIsNoCompaniesIn')} ${AppLocalizations.of(context)!.isEnLocale ? DCacheHelper.getString(key: CacheKeys.countryNameEn) : DCacheHelper.getString(key: CacheKeys.countryNameAr)}',
                                        style: DStyles.h4Bold.copyWith(color: DColors.blackColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                      : state is GetAllCompaniesLoadingState || homeCubit.companiesList.isEmpty
                                      ? CircularProgressIndicator()
                                      : Padding(
                                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                    child: GridView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: homeCubit.companiesList.length,
                                      shrinkWrap: true,
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio:
                                        DDeviceUtils.getScreenHeight(context) / 1200,
                                      ),
                                      itemBuilder: (context, index) {
                                        List<Company> companyData = [];
                                        List<int> companyId = [];

                                        for (int i = 0; i < DConstants.companiesLogos.length; i++) {
                                          Company company = Company(
                                            id: i,
                                            logo: DConstants.companiesLogos[i],
                                            name: DConstants.categoriesName[i],
                                            offers: DConstants.companiesOffers[i],
                                          );
                                          companyData.add(company);
                                        }

                                        List<bool> isFavoriteList = List.generate(companyData.length, (index) => false);

                                        // for (int i = 0; i < companyData.length; i++) {
                                        //   companyId.add(companyData[i].id);
                                        // }
                                        return GestureDetector(
                                          onTap: () {
                                            context.pushNamed(DRoutesName.offersRoute, arguments: {
                                              'countryId': DCacheHelper.getString(key: CacheKeys.countryId),
                                              'companyId': homeCubit.companiesList[index].id.toString(),
                                              'companyNameAr': homeCubit.companiesList[index].arName.toString(),
                                              'companyNameEn': homeCubit.companiesList[index].enName.toString(),
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10.h),
                                              Container(
                                                width: DDeviceUtils.getScreenWidth(context) / 3.5,
                                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                                                decoration: BoxDecoration(
                                                    color: DColors.whiteColor,
                                                    boxShadow: [AppBoxShadows.containersShadow],
                                                    borderRadius: BorderRadius.circular(12.r)),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      // onTap: () async {
                                                      //   setState(() {
                                                      //     if (selectedCompanyIndices.contains(index)) {
                                                      //       selectedCompanyIndices.remove(index);
                                                      //
                                                      //       DCacheHelper.deleteIntListItem(key: CacheKeys.companiesId, indexToDelete: index);
                                                      //
                                                      //       final snackBar = SnackBar(
                                                      //         content: Text('Removed from favorites', style: DStyles.bodyMediumRegular.copyWith(color: DColors.whiteColor)),
                                                      //         backgroundColor: DColors.error,
                                                      //       );
                                                      //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                      //     }
                                                      //     else {
                                                      //       // selectedCompanyIndices.add(index);
                                                      //
                                                      //       // DCacheHelper.putIntList(key: CacheKeys.companiesId, value: selectedCompanyIndices);
                                                      //
                                                      //       // final snackBar = SnackBar(
                                                      //       //   content: Text('Added from favorites', style: DStyles.bodyMediumRegular.copyWith(color: DColors.whiteColor)),
                                                      //       //   backgroundColor: DColors.success,
                                                      //       // );
                                                      //       // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                      //     }
                                                      //   });
                                                      //
                                                      //   logSuccess('$selectedCompanyIndices -------------------------');
                                                      //   // setState(() {
                                                      //   //   isFavoriteList[index] = !isFavoriteList[index];
                                                      //   // });
                                                      //   //
                                                      //   // if(isFavoriteList[index]) {
                                                      //   //   /// Delete
                                                      //   //   logError('Deleted');
                                                      //   //   DCacheHelper.deleteIntListItem(key: CacheKeys.companiesId, indexToDelete: index);
                                                      //   // } else {
                                                      //   //   logError('Putted');
                                                      //   //   isFavoriteList[index] = true;
                                                      //   //   DCacheHelper.putIntList(key: CacheKeys.companiesId, value: companyId);
                                                      //   // }
                                                      //   // final snackBar = SnackBar(
                                                      //   //   content: Text(isFavoriteList[index] ? 'Added Successfully' : 'Removed from favorites', style: DStyles.bodyMediumRegular.copyWith(color: DColors.whiteColor)),
                                                      //   //   backgroundColor: isFavoriteList[index] ? DColors.success : DColors.error,
                                                      //   // );
                                                      //   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                      // },
                                                      onTap: () {
                                                        // logSuccess('Love');
                                                        if(DCacheHelper.getString(key: CacheKeys.skipLogin)!.isNotEmpty) {
                                                          DDeviceUtils.showLoginMessageDialog(context);
                                                        } else {
                                                          logError('Love');
                                                          /// Call Add Favorite Function
                                                          homeCubit.addToFavoriteFunction(companyId: homeCubit.companiesList[index].id.toString());
                                                        }
                                                      },
                                                      // child: SvgPicture.asset(
                                                      // selectedCompanyIndices.contains(index)
                                                      //     ? DImages.heartSelected : DImages.heartNotSelected, colorFilter: ColorFilter.mode(selectedCompanyIndices.contains(index)
                                                      //   ? DColors.error
                                                      //   : DColors.error,
                                                      //   BlendMode.srcIn),),
                                                      child: SvgPicture.asset(
                                                        homeCubit.companiesList[index].favorites == 0
                                                            ? DImages.heartNotSelected
                                                            : DImages.heartSelected,
                                                        height: DDeviceUtils.getScreenHeight(context) / 40,
                                                        color: homeCubit.companiesList[index].favorites == 1
                                                            ? DColors.error
                                                            : DColors.blackColor,
                                                      ),
                                                    ),

                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                    //   children: [
                                                    //   ],
                                                    // ),
                                                    SizedBox(height: 12.h),
                                                    Container(
                                                      height: DDeviceUtils.getScreenHeight(context) / 15,
                                                      margin: EdgeInsets.symmetric(horizontal: 14.w),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(12.r),
                                                        child: Image.network(
                                                          homeCubit.companiesList[index].nonExpiredOffers == 0
                                                              ?  '${ApiConstants.baseUrlForImage}${homeCubit.companiesList[index].grayLogo}'
                                                              : '${ApiConstants.baseUrlForImage}${homeCubit.companiesList[index].colorLogo}',
                                                          // DConstants.companiesLogos[index],
                                                          height: double.infinity,
                                                          width: double.infinity,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context, error, stackTrace) {
                                                            return Center(child: Lottie.asset('assets/lotties/loadingImage.json', fit: BoxFit.cover));
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 12.h),
                                                    Text(AppLocalizations.of(context)!.isEnLocale ? homeCubit.companiesList[index].enName! : homeCubit.companiesList[index].arName!,
                                                        style: DStyles.bodyLargeBold.copyWith(fontSize: 14.sp), overflow: TextOverflow.ellipsis),
                                                    SizedBox(height: 4.h),
                                                    Text('${homeCubit.companiesList[index].views} ${AppLocalizations.of(context)!.translate('views')}',
                                                        style: DStyles.bodyMediumRegular.copyWith(fontSize: 10.sp)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  if (isLoadingMore)
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20.h),
                                      child: const CircularProgressIndicator(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // if (isBannerLoaded)
                  //   Positioned(
                  //     bottom: 10.h,
                  //     left: 10.w,
                  //     right: 10.w,
                  //     child: Container(
                  //       width: bannerAd!.size.width.toDouble(),
                  //       height: bannerAd!.size.height.toDouble(),
                  //       color: Colors.white,
                  //       // child: AdWidget(
                  //       //   ad: bannerAd!,
                  //       //   key: UniqueKey(),
                  //       // ),
                  //       child: AdWidget(
                  //         ad: bannerAd!,
                  //       ),
                  //     ),
                  //   )
                  // else
                  //   const SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  // void showCountriesDialog() {
  //   var getAllCountriesAndCities = CountiesCubit.get(context);
  //   var homeCubit = HomeCubit.get(context);
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: DColors.greyScale50,
  //         title: Text(AppLocalizations.of(context)!.translate('selectCountry')!, style: DStyles.bodyLargeBold),
  //         content: SizedBox(
  //           width: double.infinity,
  //           height: DDeviceUtils.getScreenHeight(context) / 2,
  //           child: ListView.separated(
  //             itemCount: getAllCountriesAndCities.getAllCountriesModel.length,
  //             separatorBuilder: (context, index) => const Divider(),
  //             itemBuilder: (context, index) {
  //               final country = getAllCountriesAndCities.getAllCountriesModel[index];
  //               return ListTile(
  //                 leading: Image.network(
  //                   'https://book.elostora-hub.com${country.image}',
  //                   height: 30.h,
  //                   width: 30.w,
  //                   errorBuilder: (context, error, stackTrace) {
  //                     return Lottie.asset('assets/lotties/loadingImage.json');
  //                   },
  //                 ),
  //                 title: Text(AppLocalizations.of(context)!.isEnLocale ? country.enName : country.arName, style: DStyles.bodyLargeBold),
  //                 onTap: () async {
  //                   setState(() {
  //                     selectedCountry = AppLocalizations.of(context)!.isEnLocale ? country.enName : country.arName;
  //                     selectedCountryId = country.id.toString();
  //                     selectedCountryImage = 'https://book.elostora-hub.com${country.image}';
  //                     selectedCountryNameAr = country.arName;
  //                     selectedCountryNameEn = country.enName;
  //                   });
  //                   await DCacheHelper.putString(key: CacheKeys.countryId, value: selectedCountryId.toString());
  //                   await DCacheHelper.putString(key: CacheKeys.countryImage, value: selectedCountryImage.toString());
  //                   await DCacheHelper.putString(key: CacheKeys.countryNameEn, value: selectedCountryNameEn.toString());
  //                   await DCacheHelper.putString(key: CacheKeys.countryNameAr, value: selectedCountryNameAr.toString());
  //                   // if(homeCubit.categoriesList[index].enName == 'All' || homeCubit.categoriesList[index].arName = 'الكل') {
  //                   //   homeCubit.getAllCompaniesFunction(page: 1, limit: 8);
  //                   // }
  //                   // homeCubit.getAllCompaniesFunction(page: 1, limit: 8);
  //                   // homeCubit.getAllBannersFunction();
  //
  //                   if (homeCubit.categoriesList.isNotEmpty) {
  //                     var category = homeCubit.categoriesList[index];
  //                     if (category.enName == 'All' || category.arName == 'الكل') {
  //                       homeCubit.getAllCompaniesFunction(page: 1, limit: 8);
  //                     } else {
  //                       homeCubit.getAllCompaniesFunction(page: 1, limit: 8);
  //                     }
  //                   }
  //                   // HomeCubit.get(context).getAllCompaniesFunction(page: 1, limit: 8);
  //                   // HomeCubit.get(context).getAllBannersFunction();
  //                   // if (HomeCubit.get(context).categoriesList[index].enName == 'All' || HomeCubit.get(context).categoriesList[index].arName == 'الكل') {
  //                   //   HomeCubit.get(context).getAllCompaniesFunction(page: 1, limit: 8, );
  //                   // }
  //                   Navigator.pop(context);
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text(AppLocalizations.of(context)!.translate('cancel')!, style: DStyles.bodyLargeBold.copyWith(color: DColors.error)),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}


