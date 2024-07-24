import 'package:daily_flyers_app/utils/constants/exports.dart';

class DailyFlyersApp extends StatelessWidget {
  const DailyFlyersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DailyFlyer',
            onGenerateRoute: RouteGenerator.getRoute,
            // initialRoute: DRoutesName.navigationMenuRoute,
            initialRoute: DRoutesName.splashRoute,
          );
        },
    );
  }
}
