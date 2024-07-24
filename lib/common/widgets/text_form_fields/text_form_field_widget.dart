import 'package:daily_flyers_app/utils/constants/exports.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.prefixIcon,
    required this.fillColor,
    required this.borderSide,
    this.suffixIcon,
    required this.textInputType,
    this.validator,
    required this.obscureText,
    required this.hintColor,
    this.textAlign,
    this.inputFormatters,
    this.isEdit = false,
    this.maxLines = 1, // Ensure maxLines is set to 1 by default
    this.onChanged,
    this.readOnly,
    this.textStyle,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final Color fillColor;
  final Color hintColor;
  final BorderSide borderSide;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool isEdit;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool? readOnly;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      focusNode: focusNode,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: textStyle ?? DStyles.bodyMediumSemiBold.copyWith(color: DColors.greyScale900),
      obscureText: obscureText,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: obscureText ? 1 : maxLines, // Set maxLines to 1 if obscureText is true
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        hintStyle: isEdit ? DStyles.bodyMediumSemiBold : DStyles.bodyMediumRegular.copyWith(color: hintColor),
        focusColor: DColors.purpleTransparent,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: DColors.primaryColor500),
        ),
      ),
    );
  }
}

