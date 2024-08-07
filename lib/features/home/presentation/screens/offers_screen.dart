// import 'package:daily_flyers_app/features/home/managers/home_cubit.dart';
// import 'package:daily_flyers_app/utils/constants/exports.dart';
//
// class OffersScreen extends StatefulWidget {
//   const OffersScreen({super.key, required this.data});
//
//   final Map<String, dynamic> data;
//
//   @override
//   State<OffersScreen> createState() => _OffersScreenState();
// }
//
// class _OffersScreenState extends State<OffersScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _fetchOffers();
//   }
//
//   @override
//   void didUpdateWidget(OffersScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.data['countryId'] != oldWidget.data['countryId'] || widget.data['companyId'] != oldWidget.data['companyId']) {
//       _fetchOffers();
//     }
//   }
//
//   void _fetchOffers() {
//     HomeCubit.get(context).getAllOffersFunction(
//       countryId: widget.data['countryId'],
//       companyId: widget.data['companyId'],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: DColors.greyScale50,
//       body: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           var offersCubit = HomeCubit.get(context);
//           return offersCubit.allOffersModel.data == null && offersCubit.offersDataList.isEmpty
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//             itemCount: offersCubit.offersDataList.length,
//             itemBuilder: (context, index) {
//               return Column(
//                 children: [
//                   Text('Views: ${offersCubit.offersDataList[index].views}'),
//                   Text('Ar Title: ${offersCubit.offersDataList[index].arTitle}'),
//                   Text('En Title: ${offersCubit.offersDataList[index].enTitle}'),
//                   Text('Ar Description: ${offersCubit.offersDataList[index].arDescription}'),
//                   Text('En Description: ${offersCubit.offersDataList[index].enDescription}'),
//                   Text('Start Date: ${offersCubit.offersDataList[index].startDate}'),
//                   Text('End Date: ${offersCubit.offersDataList[index].endDate}'),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:daily_flyers_app/features/home/managers/home_cubit.dart';
import 'package:daily_flyers_app/features/home/presentation/screens/offers/all_photos_screen.dart';
import 'package:daily_flyers_app/utils/constants/api_constants.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:lottie/lottie.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    super.initState();
    // _fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.greyScale50,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HomeCubit()..getAllOffersFunction(countryId: widget.data['countryId'], companyId: widget.data['companyId']),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              var offersCubit = HomeCubit.get(context);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    /// AppBar
                    Container(
                      width: double.infinity,
                      height: 75.h,
                      color: DColors.primaryColor500,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          InkWellWidget(onTap: () => context.pop(), child: Icon((Icons.arrow_back), color: DColors.whiteColor)),
                          SizedBox(width: 16.w),
                          Text(AppLocalizations.of(context)!.isEnLocale ? widget.data['companyNameEn'] : widget.data['companyNameAr'], style: DStyles.h4Bold.copyWith(color: DColors.whiteColor)),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h, bottom: 48.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          offersCubit.allOffersModel.data == null
                              ? const Center(child: CircularProgressIndicator())
                          //     : Container(
                          //   color: Colors.red,
                          //   height: DDeviceUtils.getScreenHeight(context) / 1.2,
                          //   child: ListView.separated(
                          //     shrinkWrap: true,
                          //     itemCount: offersCubit.offersDataList.length,
                          //     separatorBuilder: (context, index) {
                          //       return Divider(color: Colors.red);
                          //     },
                          //     itemBuilder: (context, index) {
                          //       return Column(
                          //         children: [
                          //           Image.network('${ApiConstants.baseUrlForImageInBanner}${offersCubit.offersDataList[index].image}', height: 100.h, width: 100.w),
                          //           Text('Views: ${offersCubit.offersDataList[index].views}'),
                          //           Text('Ar Title: ${offersCubit.offersDataList[index].arTitle}'),
                          //           Text('En Title: ${offersCubit.offersDataList[index].enTitle}'),
                          //           Text('Ar Description: ${offersCubit.offersDataList[index].arDescription}'),
                          //           Text('En Description: ${offersCubit.offersDataList[index].enDescription}'),
                          //           Text('Start Date: ${offersCubit.offersDataList[index].startDate}'),
                          //           Text('End Date: ${offersCubit.offersDataList[index].endDate}'),
                          //         ],
                          //       );
                          //     },
                          //   ),
                          // )
                          : offersCubit.offersDataList == [] || offersCubit.offersDataList.isEmpty
                              ? Lottie.asset('assets/lotties/emptyCompanies.json', height: DDeviceUtils.getScreenHeight(context) / 6)
                              : GridView.builder(
                            shrinkWrap: true,
                            itemCount: offersCubit.offersDataList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: DDeviceUtils.getScreenHeight(context) / 1000,
                              crossAxisSpacing: DDeviceUtils.getScreenWidth(context) / 30,
                              mainAxisSpacing: DDeviceUtils.getScreenHeight(context) / .2,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => Test(),));
                                    context.pushNamed(DRoutesName.allPhotosRoute, arguments: {
                                      'titleAr': offersCubit.offersDataList[index].arTitle,
                                      'titleEn': offersCubit.offersDataList[index].enTitle,
                                    });
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 400.h,
                                      width: 200.w,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          image: DecorationImage(
                                            image: NetworkImage('${ApiConstants.baseUrlForImageInBanner}${offersCubit.offersDataList[index].image}'),
                                            fit: BoxFit.cover,
                                          )
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 0.h,
                                      child: Container(
                                        height: 90.h,
                                        width: 200.w,
                                        color: DColors.blackColor.withOpacity(.4),
                                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${offersCubit.offersDataList[index].views} ${AppLocalizations.of(context)!.translate('views')}', style: DStyles.bodyMediumBold.copyWith(color: DColors.primaryColor500)),
                                            Text('${AppLocalizations.of(context)!.isEnLocale ? offersCubit.offersDataList[index].enTitle : offersCubit.offersDataList[index].arTitle}', style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)),
                                            Text('${AppLocalizations.of(context)!.isEnLocale ? offersCubit.offersDataList[index].enDescription : offersCubit.offersDataList[index].arDescription}', style: DStyles.bodySmallMedium.copyWith(color: DColors.whiteColor)),
                                            Text('${AppLocalizations.of(context)!.translate('from')}: ${offersCubit.offersDataList[index].startDate}', style: DStyles.bodySmallMedium.copyWith(color: DColors.whiteColor)),
                                            Text('${AppLocalizations.of(context)!.translate('to')}: ${offersCubit.offersDataList[index].endDate}', style: DStyles.bodySmallMedium.copyWith(color: DColors.whiteColor))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );

              if (offersCubit.allOffersModel.data == null && offersCubit.offersDataList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.separated(
                  itemCount: offersCubit.offersDataList.length,
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.red);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text('Views: ${offersCubit.offersDataList[index].views}'),
                        Text('Ar Title: ${offersCubit.offersDataList[index].arTitle}'),
                        Text('En Title: ${offersCubit.offersDataList[index].enTitle}'),
                        Text('Ar Description: ${offersCubit.offersDataList[index].arDescription}'),
                        Text('En Description: ${offersCubit.offersDataList[index].enDescription}'),
                        Text('Start Date: ${offersCubit.offersDataList[index].startDate}'),
                        Text('End Date: ${offersCubit.offersDataList[index].endDate}'),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
