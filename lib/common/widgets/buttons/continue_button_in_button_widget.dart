import 'package:daily_flyers_app/common/styles/shadows/app_box_shadows.dart';
import 'package:daily_flyers_app/common/widgets/buttons/main_button_widget.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';

class ContinueButtonInBottomWidget extends StatelessWidget {
  const ContinueButtonInBottomWidget({super.key, required this.onTap, required this.centerWidget});

  final void Function() onTap;
  final Widget centerWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105.h,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Sign up Button
          MainButtonWidget(
            centerWidgetInButton: centerWidget,
            onTap: onTap,
            margin: EdgeInsets.zero,
            buttonColor: DColors.primaryColor500,
            boxShadow:[AppBoxShadows.buttonShadowOne],
          ),
        ],
      ),
    );
  }
}
