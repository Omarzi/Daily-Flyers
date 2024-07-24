import 'package:daily_flyers_app/utils/constants/exports.dart';

class SecondButtonWidget extends StatelessWidget {
  const SecondButtonWidget({super.key, required this.bgColor, required this.widget, required this.onTap, this.border, this.borderRadius});

  final Color bgColor;
  final Widget widget;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: onTap,
      child: Container(
        width: 184.w,
        height: 58.h,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: borderRadius ?? BorderRadius.circular(100.r),
          border: border,
        ),
        child: Center(child: widget),
      ),
    );
  }
}
