import 'package:daily_flyers_app/utils/constants/exports.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({super.key, this.onTap, required this.centerWidgetInButton, required this.margin, required this.buttonColor, required this.boxShadow});

  final void Function()? onTap;
  final Widget centerWidgetInButton;
  final Color buttonColor;
  final EdgeInsetsGeometry margin;
  final List<BoxShadow> boxShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 380.w,
        height: 58.h,
        margin: margin,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: boxShadow,
        ),
        child: Center(
          child: centerWidgetInButton,
        ),
      ),
    );
  }
}
