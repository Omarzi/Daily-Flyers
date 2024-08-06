import '../../../../utils/constants/exports.dart';

class CheckContainerWidget extends StatelessWidget {
  const CheckContainerWidget({super.key, required this.mainText, required this.hintText, required this.iconData, required this.onTap, required this.borderColor});

  final String mainText, hintText;

  final IconData  iconData;
  final Function()  onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(mainText,style: DStyles.bodyMediumRegular.copyWith(color: DColors.greyScale500)),
        SizedBox(height: 10.h),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
            decoration: BoxDecoration(
                color: DColors.greyScale100,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    width: 1.w,
                    color: borderColor,
                ),
            ),
            child: Row(
              children: [
                Icon(iconData),
                SizedBox(width: 20.w),
                Text(hintText, style: DStyles.bodyMediumSemiBold),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
        ),
      ],
    );
  }
}