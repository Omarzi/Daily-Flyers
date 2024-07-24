import 'package:daily_flyers_app/utils/constants/colors.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.greyScale50,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedAppIcon(),
          ],
        ),
      ),
    );
  }
}
