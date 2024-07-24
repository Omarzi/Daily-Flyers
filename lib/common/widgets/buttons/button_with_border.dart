import '../../../utils/constants/exports.dart';

import '../../../utils/constants/exports.dart';

class ButtonWithBorderWidget extends StatelessWidget {
  const ButtonWithBorderWidget({Key? key, required this.textButton, this.onTap, required this.width, required this.height}) : super(key: key);
  final String textButton;
  final VoidCallback? onTap;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              width: 2.w,
              color: DColors.primaryColor500
          ),

        ),
        child: Center(
          child: Text(textButton,style: DStyles.bodyMediumSemiBold),
        ),
      ),
    );
  }
}