import 'package:daily_flyers_app/features/auth/managers/auth_cubit.dart';
import 'package:daily_flyers_app/features/check_country/managers/counties_cubit.dart';
import 'package:daily_flyers_app/features/home/managers/home_cubit.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:daily_flyers_app/utils/language/app_localizations_setup.dart';

class DailyFlyersApp extends StatelessWidget {
  const DailyFlyersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => LocaleCubit()),
              BlocProvider(create: (context) => AuthCubit()),
              BlocProvider(create: (context) => CountiesCubit()),
              BlocProvider(create: (context) => HomeCubit()),
            ],
            child: BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, localeState) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'DailyFlyer',
                  supportedLocales: AppLocalizationsSetup.supportedLocale,
                  localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
                  localeListResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
                  locale: localeState.locale,
                  onGenerateRoute: RouteGenerator.getRoute,
                  // initialRoute: DRoutesName.navigationMenuRoute,
                  initialRoute: DRoutesName.splashRoute,
                );
              },
            ),
          );
        },
    );
  }
}
