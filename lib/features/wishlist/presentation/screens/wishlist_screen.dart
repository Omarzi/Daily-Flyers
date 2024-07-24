import 'package:daily_flyers_app/common/styles/shadows/app_box_shadows.dart';
import 'package:daily_flyers_app/common/widgets/switches/switch_widget.dart';
import 'package:daily_flyers_app/utils/constants/constants.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:daily_flyers_app/utils/constants/log_util.dart';
import 'package:daily_flyers_app/utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';

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
    _loadNotificationPreference();
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
                      'Daily Flyer',
                      style: TextStyle(
                        color: DColors.whiteColor,
                        fontSize: 24,
                      ),
                    ),
                  ],
                )),

            /// Home
            ListTile(
              leading: const Icon(Iconsax.home),
              title: Text('Home', style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () {
                // Handle drawer item tap
              },
            ),

            /// Settings
            ListTile(
              leading: const Icon(Iconsax.settings),
              title: Text('Settings', style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () {
                // Handle drawer item tap
              },
            ),

            /// Notifications
            ListTile(
              leading: const Icon(Iconsax.notification),
              title: Text('Notifications', style: DStyles.bodyXLargeRegular),
              trailing: SwitchWidget(
                valueData: isOnNotificationEnabled,
                onChanged: (value) async {
                  setState(() {
                    isOnNotificationEnabled = value;
                  });
                  await _saveNotificationPreference(value);
                  if (isOnNotificationEnabled) {
                    logSuccess('Open Notifications');
                    await openNotifications();
                  } else {
                    logError('Clear All Notifications');
                    await LocalNotifications.cancelAll();
                  }
                },
              ),
            ),

            /// Share the app
            ListTile(
              leading: const Icon(Iconsax.share),
              title: Text('Share the app', style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () {
                // Handle drawer item tap
              },
            ),

            /// About us
            ListTile(
              leading: const Icon(Iconsax.info_circle),
              title: Text('About us', style: DStyles.bodyXLargeRegular),
              trailing: Icon(Icons.arrow_forward_ios, size: 22.sp),
              onTap: () {
                // Handle drawer item tap
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
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
                      bottomRight: Radius.circular(20.r)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Menu - Notification Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => scaffoldKey.currentState?.openDrawer(),
                          child: Icon(Icons.menu,
                              color: DColors.whiteColor, size: 30.sp),
                        ),
                        Icon(Iconsax.share,
                            color: DColors.whiteColor, size: 30.sp),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    /// App Name
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 3.w, bottom: 15.h),
                          child: Text(
                            'Daily Flyers',
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
                          hintText: 'Search here',
                          hintStyle: DStyles.bodyLargeBold
                              .copyWith(color: DColors.greyScale600),
                          prefixIcon: Icon(Iconsax.search_normal, size: 25.sp),
                          suffixIcon: isClearIcon
                              ? GestureDetector(
                            onTap: () {
                              setState(() {
                                searchController.clear();
                                isClearIcon = false;
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
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      /// Data
                      Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: DConstants.companiesLogos.length,
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
                                            onTap: () async {
                                              setState(() {
                                                if (selectedCompanyIndices.contains(index)) {
                                                  selectedCompanyIndices.remove(index);
                                                  DCacheHelper.deleteIntListItem(key: CacheKeys.companiesId, indexToDelete: index);

                                                  final snackBar = SnackBar(
                                                    content: Text('Removed from favorites', style: DStyles.bodyMediumRegular.copyWith(color: DColors.whiteColor)),
                                                    backgroundColor: DColors.error,
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                } else {
                                                  selectedCompanyIndices.add(index);
                                                  DCacheHelper.putIntList(key: CacheKeys.companiesId, value: selectedCompanyIndices);
                                                  final snackBar = SnackBar(
                                                    content: Text('Added from favorites', style: DStyles.bodyMediumRegular.copyWith(color: DColors.whiteColor)),
                                                    backgroundColor: DColors.success,
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                }
                                              });

                                              logSuccess(selectedCompanyIndices.toString());
                                              // setState(() {
                                              //   isFavoriteList[index] = !isFavoriteList[index];
                                              // });
                                              //
                                              // if(isFavoriteList[index]) {
                                              //   /// Delete
                                              //   logError('Deleted');
                                              //   DCacheHelper.deleteIntListItem(key: CacheKeys.companiesId, indexToDelete: index);
                                              // } else {
                                              //   logError('Putted');
                                              //   isFavoriteList[index] = true;
                                              //   DCacheHelper.putIntList(key: CacheKeys.companiesId, value: companyId);
                                              // }
                                              // final snackBar = SnackBar(
                                              //   content: Text(isFavoriteList[index] ? 'Added Successfully' : 'Removed from favorites', style: DStyles.bodyMediumRegular.copyWith(color: DColors.whiteColor)),
                                              //   backgroundColor: isFavoriteList[index] ? DColors.success : DColors.error,
                                              // );
                                              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            child: SvgPicture.asset(
                                              selectedCompanyIndices.contains(index)
                                                  ? DImages.heartSelected : DImages.heartNotSelected, colorFilter: ColorFilter.mode(selectedCompanyIndices.contains(index)
                                                ? DColors.error
                                                : DColors.error,
                                                BlendMode.srcIn),),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      SizedBox(
                                        height: DDeviceUtils.getScreenHeight(
                                            context) /
                                            15,
                                        child: Image.asset(
                                            DConstants.companiesLogos[index],
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover),
                                      ),
                                      SizedBox(height: 18.h),
                                      Text(DConstants.companiesName[index],
                                          style: DStyles.bodyLargeBold
                                              .copyWith(fontSize: 14.sp),
                                          overflow: TextOverflow.ellipsis),
                                      SizedBox(height: 4.h),
                                      Text(DConstants.companiesOffers[index],
                                          style: DStyles.bodyMediumRegular
                                              .copyWith(fontSize: 10.sp)),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
