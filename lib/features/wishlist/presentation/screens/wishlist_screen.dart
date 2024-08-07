import 'package:daily_flyers_app/common/styles/shadows/app_box_shadows.dart';
import 'package:daily_flyers_app/features/home/managers/home_cubit.dart';
import 'package:daily_flyers_app/features/wishlist/ads/ads.dart';
import 'package:daily_flyers_app/utils/constants/api_constants.dart';
import 'package:daily_flyers_app/utils/constants/constants.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:daily_flyers_app/utils/constants/log_util.dart';
import 'package:daily_flyers_app/utils/device/device_utility.dart';
import 'package:lottie/lottie.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  TextEditingController searchController = SearchController();
  bool isOnNotificationEnabled = false;
  bool isClearIcon = false;
  List<int> selectedCompanyIndices = [];
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
        title: 'Daily Flyers',
        body: 'Please, go to app to see new offers',
        payload: 'Please, go to app to see new offers',
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

  @override
  void initState() {
    // if(HomeCubit.get(context).profileDataModel.favCompanies == null || HomeCubit.get(context).favCompanies.isEmpty)  HomeCubit.get(context).profileDataFunction();
    _loadNotificationPreference();
    // Ads().showAd();
    super.initState();
    getIntList();
  }

  Future<void> getIntList() async {
    selectedCompanyIndices = await DCacheHelper.getIntList(key: CacheKeys.companiesId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.greyScale50,
      key: scaffoldKey,
      body: BlocProvider(
        create: (context) => HomeCubit()..profileDataFunction(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if(state is RemoveFromFavoriteSuccessState) {
              SnackBar snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.translate('removeFromFavSuccess')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)), backgroundColor: DColors.success);
              // HomeCubit.get(context).profileDataFunction();

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if(state is AddToFavoriteErrorState) {
              SnackBar snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.translate('removeFromFavFailure')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)), backgroundColor: DColors.error);

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            var wishListCubit = HomeCubit.get(context);

            return SafeArea(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    /// AppBar
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: 15.h, left: 15.w, right: 15.w, bottom: 15.h),
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
                                  // wishListCubit.getAllCompaniesFunction(limit: 8, page: 1);
                                  context.pop();
                                },
                                child: Icon(Icons.arrow_back_outlined,
                                    color: DColors.whiteColor, size: 30.sp),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

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
                        ],
                      ),
                    ),

                    Expanded(
                      child: state is ProfileLoadingState
                          ? Column(
                        children: [
                          DDeviceUtils.buildBannersShimmer(context),
                          DDeviceUtils.buildCategoriesShimmer(context),
                          Expanded(child: DDeviceUtils.buildCompaniesShimmer(context)),
                        ],
                      )
                          : RefreshIndicator(
                        onRefresh: () {
                          return wishListCubit.profileDataFunction();
                        },
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              SizedBox(height: 20.h),
                              /// Data
                              wishListCubit.favCompanies == [] || wishListCubit.favCompanies.isEmpty
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
                                  : Padding(
                                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: wishListCubit.favCompanies.length,
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

                                    return Column(
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
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // logSuccess('Love');
                                                      if(DCacheHelper.getString(key: CacheKeys.skipLogin)!.isNotEmpty) {
                                                        DDeviceUtils.showLoginMessageDialog(context);
                                                      } else {
                                                        logError('Remove Love');
                                                        // wishListCubit.favCompanies[index].favorites = 0;
                                                        // wishListCubit.removeFromFavoriteFunction(companyId: wishListCubit.favCompanies[index].id.toString());
                                                        wishListCubit.removeFromFavoriteFunction(companyId: wishListCubit.favCompanies[index].id.toString()).then((_) {
                                                          // Refresh the data after removal
                                                          wishListCubit.profileDataFunction();
                                                        });
                                                        // HomeCubit.get(context).profileDataFunction();
                                                      }
                                                    },
                                                    child: SvgPicture.asset(DImages.heartSelected, height: DDeviceUtils.getScreenHeight(context) / 40, color: DColors.error),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 12.h),
                                              Container(
                                                height: DDeviceUtils.getScreenHeight(context) / 15,
                                                margin: EdgeInsets.symmetric(horizontal: 14.w),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12.r),
                                                  child: Image.network(
                                                    // wishListCubit.favCompanies[index].nonExpiredOffers == 0
                                                    //     ?  '${ApiConstants.baseUrlForImage}${wishListCubit.favCompanies[index].grayLogo}'
                                                    //     :
                                                    '${ApiConstants.baseUrlForImage}${wishListCubit.favCompanies[index].colorLogo}',
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
                                              Text(AppLocalizations.of(context)!.isEnLocale ? wishListCubit.favCompanies[index].enName! : wishListCubit.favCompanies[index].arName!,
                                                  style: DStyles.bodyLargeBold.copyWith(fontSize: 14.sp), overflow: TextOverflow.ellipsis),
                                              SizedBox(height: 4.h),
                                              Text('${wishListCubit.favCompanies[index].views} ${AppLocalizations.of(context)!.translate('views')}',
                                                  style: DStyles.bodyMediumRegular.copyWith(fontSize: 10.sp)),
                                            ],
                                          ),
                                        ),
                                      ],
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
            );
          },
        ),
      ),
    );
  }
}
