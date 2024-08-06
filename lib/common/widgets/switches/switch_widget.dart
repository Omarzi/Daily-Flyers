import 'package:daily_flyers_app/utils/constants/exports.dart';

class SwitchWidget extends StatefulWidget {
  SwitchWidget({super.key, this.valueData = false, required this.onChanged});

  bool? valueData;
  // final ValueChanged<bool> onChanged;
  void Function(bool)? onChanged;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.valueData!,
      // onChanged: (bool value) {
      //   setState(() => widget.valueData = value);
      //   widget.onChanged(value);
      // },
      onChanged: widget.onChanged,
      activeColor: DColors.primaryColor500,
      activeTrackColor: DColors.primaryColor500,
      inactiveTrackColor: DColors.greyScale200,
      trackOutlineWidth: MaterialStateProperty.all(0.w),
      trackColor: MaterialStateProperty.all(widget.valueData! ? DColors.primaryColor500 : DColors.greyScale200),
      trackOutlineColor: MaterialStateProperty.all(widget.valueData! ? DColors.primaryColor500 : DColors.greyScale200),
      thumbColor: MaterialStateProperty.all(DColors.whiteColor),
      thumbIcon: MaterialStateProperty.all(Icon(Icons.circle, color: DColors.whiteColor)),
    );
  }
}
