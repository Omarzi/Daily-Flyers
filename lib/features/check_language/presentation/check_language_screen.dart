import 'package:daily_flyers_app/utils/constants/exports.dart';

class CheckLanguageScreen extends StatefulWidget {
  const CheckLanguageScreen({super.key});

  @override
  State<CheckLanguageScreen> createState() => _CheckLanguageScreenState();
}

class _CheckLanguageScreenState extends State<CheckLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.greyScale50,
      body: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          LocaleCubit checkLangCubit = BlocProvider.of<LocaleCubit>(context);

          return Directionality(
            textDirection: AppLocalizations.of(context)!.isEnLocale ? TextDirection.ltr : TextDirection.rtl,
            child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: DDeviceUtils.getScreenHeight(context) / 3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(DImages.appLogo),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  Text(AppLocalizations.of(context)!.translate('selectLanguage')!, style: DStyles.bodyXLargeBold.copyWith(fontSize: 20.sp)),

                  SizedBox(height: 20.h),

                  AppLocalizations.of(context)!.isEnLocale
                  /// English
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomLangButton(
                        text: AppLocalizations.of(context)!.translate('english')!,
                        onTap: () {
                          checkLangCubit.toEnglish();
                          DCacheHelper.putString(key: CacheKeys.lang, value: 'en');
                        },
                        icon: state.locale == const Locale('en')
                            ? Icon(
                          Icons.check,
                          color: DColors.whiteColor,
                          size: 26.sp,
                        )
                            : Container(),
                      ),

                      SizedBox(width: 5.h),

                      CustomLangButton(
                        text: AppLocalizations.of(context)!.translate('arabic')!,
                        onTap: () {
                          checkLangCubit.toArabic();
                          DCacheHelper.putString(key: CacheKeys.lang, value: 'ar');
                        },
                        icon: state.locale == const Locale('ar')
                            ? Icon(
                          Icons.check,
                          color: DColors.whiteColor,
                          size: 26.sp,
                        )
                            : Container(),
                      ),
                    ],
                  )
                  /// Arabic
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomLangButton(
                        text: AppLocalizations.of(context)!.translate('arabic')!,
                        onTap: () {
                          checkLangCubit.toArabic();
                          DCacheHelper.putString(key: CacheKeys.lang, value: 'ar');
                        },
                        icon: state.locale == const Locale('ar')
                            ? Icon(
                          Icons.check,
                          color: DColors.whiteColor,
                          size: 26.sp,
                        )
                            : Container(),
                      ),

                      SizedBox(width: 5.h),

                      CustomLangButton(
                        text: AppLocalizations.of(context)!.translate('english')!,
                        onTap: () {
                          checkLangCubit.toEnglish();
                          DCacheHelper.putString(key: CacheKeys.lang, value: 'en');
                        },
                        icon: state.locale == const Locale('en')
                            ? Icon(
                          Icons.check,
                          color: DColors.whiteColor,
                          size: 26.sp,
                        )
                            : Container(),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 28.h),
                    child: MainButtonWidget(
                      centerWidgetInButton: Text(AppLocalizations.of(context)!.translate('save')!, style: DStyles.bodyLargeBold.copyWith(color: DColors.whiteColor)),
                      onTap: () => context.pushNamedAndRemoveUntil(DRoutesName.checkCountryRoute, predicate: (route) => false, arguments: ''),
                      margin: EdgeInsets.zero,
                      buttonColor: DColors.primaryColor500,
                      boxShadow: [AppBoxShadows.buttonShadowOne],
                    ),
                  ),

                ],
              ),
            ),
          ),
          );
        },
      ),
    );
  }
}



class CustomLangButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Widget icon;
  const CustomLangButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.44,
        child: Card(
          color: DColors.whiteColor,
          shadowColor: DColors.grey2ColorPlayed,
          elevation: 15,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40.w,
              vertical: 30.h,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: DColors.primaryColor500,
                    child: icon,
                  ),
                  SizedBox(height: 14.h),
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Text(
                      text,
                      style: DStyles.bodyXLargeBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
