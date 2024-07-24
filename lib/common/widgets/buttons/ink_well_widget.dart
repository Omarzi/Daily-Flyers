import 'package:daily_flyers_app/utils/constants/exports.dart';

class InkWellWidget extends StatelessWidget {
  const InkWellWidget({super.key, required this.onTap, required this.child});

  final void Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 100.r,
      borderRadius: BorderRadius.circular(100.r),
      overlayColor: MaterialStateProperty.all(DColors.greyScale900.withOpacity(.2),),
      child: child,
    );
  }
}
