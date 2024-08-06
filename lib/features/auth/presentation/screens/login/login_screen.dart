import 'package:daily_flyers_app/features/auth/presentation/widgets/login_form_widget/login_form_widget.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:daily_flyers_app/utils/device/device_utility.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.greyScale50,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Make Space
            SizedBox(height: 31.h),

            Container(
              width: double.infinity,
              height: DDeviceUtils.getScreenHeight(context) / 4,
              child: SvgPicture.asset(DImages.loginLogo, fit: BoxFit.scaleDown),
            ),

            /// Make Space
            SizedBox(height: 20.h),

            /// Create Account Text
            Text(AppLocalizations.of(context)!.translate('email')!, style: DStyles.h2Bold.copyWith(color: DColors.greyScale900)),

            /// Make Space
            SizedBox(height: 20.h),

            LoginFormWidget(message: message),
          ],
        ),
      ),
    );
  }
}
