import 'package:daily_flyers_app/utils/constants/exports.dart';

class ChangeLanguageWidget extends StatefulWidget {
  const ChangeLanguageWidget({super.key});

  @override
  State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: DDeviceUtils.getScreenHeight(context) / 3.6,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))),
      child: Column(
        children: [
          /// Make Space
          SizedBox(height: 35.h),

          SizedBox(width: double.infinity, height: DDeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('changeLanguage')!, style: DStyles.h4Bold.copyWith(color: DColors.alertsAndStatusError), textAlign: TextAlign.center)),

          /// Make Space
          SizedBox(height: 24.h),

          Container(width: double.infinity, height: 1.w, color: DColors.greyScale200,),

          /// Make Space
          SizedBox(height: 24.h),

          SizedBox(width: double.infinity, height: DDeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('choiceFromTwoLanguages')!, style: DStyles.h5Bold.copyWith(color: DColors.greyScale800), textAlign: TextAlign.center)),

          /// Make Space
          SizedBox(height: 12.h),

          InkWellWidget(
            onTap: () {
              DCacheHelper.putString(key: CacheKeys.lang, value: 'ar');
              BlocProvider.of<LocaleCubit>(context).toArabic();
              context.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: DDeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('arabic')!, style: DStyles.h5Bold.copyWith(color: AppLocalizations.of(context)!.isEnLocale ? DColors.greyScale800 : DColors.primaryColor500))),
                SvgPicture.asset(
                  DImages.checkIcon,
                  height: 18.h,
                  colorFilter: ColorFilter.mode(
                    AppLocalizations.of(context)!.isEnLocale ? DColors.greyScale900 : DColors.primaryColor500,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),

          /// Make Space
          SizedBox(height: 12.h),

          InkWellWidget(
            onTap: () {
              DCacheHelper.putString(key: CacheKeys.lang, value: 'en');
              BlocProvider.of<LocaleCubit>(context).toEnglish();
              context.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: DDeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('english')!, style: DStyles.h5Bold.copyWith(color: AppLocalizations.of(context)!.isEnLocale ? DColors.primaryColor500 : DColors.greyScale800))),
                SvgPicture.asset(
                  DImages.checkIcon,
                  height: 18.h,
                  colorFilter: ColorFilter.mode(
                    AppLocalizations.of(context)!.isEnLocale ? DColors.primaryColor500 : DColors.greyScale900,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
