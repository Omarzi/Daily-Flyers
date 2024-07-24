// import 'package:osta_user_app/utils/constants/exports.dart';
//
// class OTPTextFormFieldWidget extends StatelessWidget {
//   const OTPTextFormFieldWidget({super.key, required this.focusNode, required this.isFieldFocused, required this.controller});
//
//   final FocusNode focusNode;
//   final bool isFieldFocused;
//   final TextEditingController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 82.w,
//       height: 61.h,
//       child: TextFormField(
//         controller: controller,
//         onChanged: (value) {
//           if(value.length == 1) {
//             FocusScope.of(context).nextFocus();
//           }
//         },
//         style: OStyles.h4Bold.copyWith(height: 1.2.h),
//         textAlign: TextAlign.center,
//         autofocus: true,
//         keyboardType: TextInputType.number,
//         inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
//         focusNode: focusNode,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.zero,
//           filled: true,
//           fillColor: isFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.r),
//             borderSide: isFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide(color: OColors.greyScale200),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.r),
//             borderSide: BorderSide(color: OColors.primaryColor500),
//           ),
//         ),
//       ),
//     );
//   }
// }
