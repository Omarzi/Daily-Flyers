import 'package:daily_flyers_app/features/check_country/managers/counties_cubit.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:lottie/lottie.dart';
import 'package:vibration/vibration.dart';

class CheckSCountryScreen extends StatefulWidget {
  const CheckSCountryScreen({super.key});

  @override
  State<CheckSCountryScreen> createState() => _CheckSCountryScreenState();
}

class _CheckSCountryScreenState extends State<CheckSCountryScreen> {
  String selectedCountry = '';
  String? selectedCountryId;
  String? selectedCountryImage;
  String? selectedCountryNameAr;
  String? selectedCountryNameEn;
  bool selectOnTap = false;

  @override
  void initState() {
    super.initState();
    CountiesCubit.get(context).getAllCountriesFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.greyScale50,
      body: BlocBuilder<CountiesCubit, CountiesState>(
        builder: (context, state) {
          var getAllCountriesAndCities = CountiesCubit.get(context);

          return Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 31.h),
                Text(AppLocalizations.of(context)!.translate('welcome')!, style: DStyles.bodyLargeRegular.copyWith(color: DColors.primaryColor500, fontSize: 32.sp)),
                SizedBox(height: 10.h),
                Text(AppLocalizations.of(context)!.translate('getStartedWithDailyFlyers')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.greyScale500, fontSize: 16.sp)),
                SizedBox(height: 30.h),
                CheckContainerWidget(
                  mainText: AppLocalizations.of(context)!.translate('whichCountryDoYouLiveIn')!,
                  hintText: selectedCountry == '' ? AppLocalizations.of(context)!.translate('selectCountry')! : selectedCountry,
                  iconData: Iconsax.location,
                  borderColor: selectedCountry == '' && selectOnTap ? DColors.error : DColors.primaryColor500,
                  onTap: () {
                    showCountriesDialog();
                  },
                ),
                SizedBox(height: 30.h),
                // if (selectedCountry != '') ...[
                //   SizedBox(height: 10.h),
                //   Row(
                //     children: [
                //       if (selectedCountryImage != null)
                //         Image.network(
                //           selectedCountryImage!,
                //           height: 50.h,
                //           width: 50.w,
                //           errorBuilder: (context, error, stackTrace) {
                //             return Lottie.asset('assets/lotties/loadingImage.json');
                //           },
                //         ),
                //       SizedBox(width: 10.w),
                //       if (selectedCountryName != null)
                //         Text(
                //           selectedCountryName!,
                //           style: DStyles.bodyLargeBold.copyWith(color: DColors.greyScale700),
                //         ),
                //     ],
                //   ),
                // ],

                const Spacer(),
                MainButtonWidget(
                  centerWidgetInButton: Text(AppLocalizations.of(context)!.translate('continue')!, style: DStyles.bodyLargeBold.copyWith(color: DColors.whiteColor)),
                  onTap: () async {
                    setState(() {
                      selectOnTap = true;
                    });
                    if(selectedCountry == '') {
                      if (await Vibration.hasVibrator() ?? false) {
                        Vibration.vibrate();
                      }
                      // setState(() {
                      //
                      // });
                    } else {
                      await DCacheHelper.putString(key: CacheKeys.countryId, value: selectedCountryId.toString());
                      await DCacheHelper.putString(key: CacheKeys.countryImage, value: selectedCountryImage.toString());
                      await DCacheHelper.putString(key: CacheKeys.countryNameEn, value: selectedCountryNameEn.toString());
                      await DCacheHelper.putString(key: CacheKeys.countryNameAr, value: selectedCountryNameAr.toString());
                      // await DCacheHelper.putString(key: CacheKeys.countryName, value: selectedCountryNameEn.toString());
                      // context.pushNamedAndRemoveUntil(DRoutesName.loginRoute, predicate: (route) => false, arguments: '');
                      logSuccess(DCacheHelper.getString(key: CacheKeys.countryId)!);
                      // logSuccess(DCacheHelper.getString(key: CacheKeys.countryName)!);
                      logSuccess(DCacheHelper.getString(key: CacheKeys.countryImage)!);
                      context.pushNamedAndRemoveUntil(DRoutesName.loginRoute, predicate: (route) => false, arguments: '');
                    }
                  },
                  margin: EdgeInsets.zero,
                  buttonColor: DColors.primaryColor500,
                  boxShadow: [AppBoxShadows.buttonShadowOne],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showCountriesDialog() {
    var getAllCountriesAndCities = CountiesCubit.get(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: DColors.greyScale50,
          title: Text(AppLocalizations.of(context)!.translate('selectCountry')!, style: DStyles.bodyLargeBold),
          content: SizedBox(
            width: double.infinity,
            height: DDeviceUtils.getScreenHeight(context) / 2,
            child: ListView.separated(
              itemCount: getAllCountriesAndCities.getAllCountriesModel.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final country = getAllCountriesAndCities.getAllCountriesModel[index];
                return ListTile(
                  leading: Image.network(
                    'https://book.elostora-hub.com${country.image}',
                    height: 30.h,
                    width: 30.w,
                    errorBuilder: (context, error, stackTrace) {
                      return Lottie.asset('assets/lotties/loadingImage.json');
                    },
                  ),
                  title: Text(AppLocalizations.of(context)!.isEnLocale ? country.enName : country.arName, style: DStyles.bodyLargeBold),
                  onTap: () {
                    setState(() {
                      selectedCountry = AppLocalizations.of(context)!.isEnLocale ? country.enName : country.arName;
                      selectedCountryId = country.id.toString();
                      selectedCountryImage = 'https://book.elostora-hub.com${country.image}';
                      selectedCountryNameAr = country.arName;
                      selectedCountryNameEn = country.enName;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.translate('cancel')!, style: DStyles.bodyLargeBold.copyWith(color: DColors.error)),
            ),
          ],
        );
      },
    );
  }
}
