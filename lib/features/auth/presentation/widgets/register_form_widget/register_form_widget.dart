import 'package:daily_flyers_app/features/auth/managers/auth_cubit.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmNewPasswordFocusNode = FocusNode();

  bool isNameFieldFocused = false;
  bool isEmailFieldFocused = false;
  bool isPasswordFieldFocused = false;
  bool isConfirmPasswordFieldFocused = false;

  bool isShown = false;
  bool isShown2 = false;

  @override
  void initState() {
    super.initState();

    /// Add listener to focus node
    nameFocusNode.addListener(
            () => setState(() => isNameFieldFocused = nameFocusNode.hasFocus));
    emailFocusNode.addListener(
            () => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
    passwordFocusNode.addListener(
            () => setState(() => isPasswordFieldFocused = passwordFocusNode.hasFocus));
    confirmNewPasswordFocusNode.addListener(
            () => setState(() => isConfirmPasswordFieldFocused = confirmNewPasswordFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmNewPasswordFocusNode.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is SignUpSuccessState) {
          context.pushNamedAndRemoveUntil(DRoutesName.homeRoute, predicate: (route) => false);
        } else if(state is SignUpErrorState) {
          String messageError = state.message;

          // SnackBar snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.translate('loginError')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)), backgroundColor: DColors.error);
          SnackBar snackBar = SnackBar(
            content: Text(
              messageError == 'Not Found: Customer Not Fount'
                  ? AppLocalizations.of(context)!.translate('unAuth')!
                  : messageError.contains('Password: Password is too weak')
                  ? AppLocalizations.of(context)!.translate('passwordIsWeaK')!
                  : state.message,
              style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)),
            backgroundColor: DColors.error,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var registerCubit = AuthCubit.get(context);

        return Container(
          width: double.infinity,
          child: Column(
            children: [
              /// Name
              TextFormFieldWidget(
                controller: nameController,
                textInputType: TextInputType.name,
                focusNode: nameFocusNode,
                hintText: AppLocalizations.of(context)!.translate('userName')!,
                hintColor: isNameFieldFocused ? DColors.primaryColor500 : DColors.greyScale500,
                prefixIcon: SvgPicture.asset(DImages.email2Icon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isNameFieldFocused ? DColors.primaryColor500 : emailController.text.isNotEmpty ? DColors.greyScale900 : DColors.greyScale500, BlendMode.srcIn)),
                fillColor: isNameFieldFocused ? DColors.purpleTransparent.withOpacity(.08) : DColors.greyScale50,
                borderSide: isNameFieldFocused ? BorderSide(color: DColors.primaryColor500) : BorderSide(color: DColors.greyScale200),
                obscureText: false,
              ),

              /// Make Space
              SizedBox(height: 20.h),

              /// Email
              TextFormFieldWidget(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                hintText: AppLocalizations.of(context)!.translate('email')!,
                hintColor: isEmailFieldFocused ? DColors.primaryColor500 : DColors.greyScale500,
                prefixIcon: SvgPicture.asset(DImages.email2Icon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isEmailFieldFocused ? DColors.primaryColor500 : emailController.text.isNotEmpty ? DColors.greyScale900 : DColors.greyScale500, BlendMode.srcIn)),
                fillColor: isEmailFieldFocused ? DColors.purpleTransparent.withOpacity(.08) : DColors.greyScale50,
                borderSide: isEmailFieldFocused ? BorderSide(color: DColors.primaryColor500) : BorderSide(color: DColors.greyScale200),
                obscureText: false,
              ),

              /// Make Space
              SizedBox(height: 20.h),

              /// Password
              TextFormFieldWidget(
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                focusNode: passwordFocusNode,
                hintText: AppLocalizations.of(context)!.translate('password')!,
                hintColor: isPasswordFieldFocused ? DColors.primaryColor500 : DColors.greyScale500,
                prefixIcon: SvgPicture.asset(DImages.passwordIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isPasswordFieldFocused ? DColors.primaryColor500 : passwordController.text.isNotEmpty ? DColors.greyScale900 : DColors.greyScale500, BlendMode.srcIn)),
                fillColor: isPasswordFieldFocused ? DColors.purpleTransparent.withOpacity(.08) : DColors.greyScale50,
                borderSide: isPasswordFieldFocused ? BorderSide(color: DColors.primaryColor500) : BorderSide(color: DColors.greyScale200),
                obscureText: isShown,
                suffixIcon: InkWellWidget(
                  onTap: () {
                    setState(() {
                      isShown = !isShown;
                    });
                  },
                  child: SvgPicture.asset(
                      isShown ? DImages.unVisibleIcon : DImages.visibleIcon,
                      fit: BoxFit.scaleDown,
                      colorFilter:ColorFilter.mode(isPasswordFieldFocused ? DColors.primaryColor500 : passwordController.text.isNotEmpty ? DColors.greyScale900 : DColors.greyScale500, BlendMode.srcIn)
                  ),
                ),
              ),

              // /// Make Space
              // SizedBox(height: 20.h),
              //
              // /// Confirm Password
              // TextFormFieldWidget(
              //   controller: confirmNewPasswordController,
              //   textInputType: TextInputType.visiblePassword,
              //   focusNode: confirmNewPasswordFocusNode,
              //   hintText: 'Confirm Password',
              //   hintColor: isConfirmPasswordFieldFocused ? DColors.primaryColor500 : DColors.greyScale500,
              //   prefixIcon: SvgPicture.asset(DImages.passwordIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isConfirmPasswordFieldFocused ? DColors.primaryColor500 : passwordController.text.isNotEmpty ? DColors.greyScale900 : DColors.greyScale500, BlendMode.srcIn)),
              //   fillColor: isConfirmPasswordFieldFocused ? DColors.purpleTransparent.withOpacity(.08) : DColors.greyScale50,
              //   borderSide: isConfirmPasswordFieldFocused ? BorderSide(color: DColors.primaryColor500) : BorderSide(color: DColors.greyScale200),
              //   obscureText: isShown2,
              //   suffixIcon: InkWellWidget(
              //     onTap: () {
              //       setState(() {
              //         isShown2 = !isShown2;
              //       });
              //     },
              //     child: SvgPicture.asset(
              //         isShown2 ? DImages.unVisibleIcon : DImages.visibleIcon,
              //         fit: BoxFit.scaleDown,
              //         colorFilter:ColorFilter.mode(isConfirmPasswordFieldFocused ? DColors.primaryColor500 : confirmNewPasswordController.text.isNotEmpty ? DColors.greyScale900 : DColors.greyScale500, BlendMode.srcIn)
              //     ),
              //   ),
              // ),

              /// Make Space
              SizedBox(height: 48.h),

              /// Sign in Button
              MainButtonWidget(
                centerWidgetInButton: state is SignUpLoadingState
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(AppLocalizations.of(context)!.translate('continue')!, style: DStyles.bodyLargeBold.copyWith(color: DColors.whiteColor)),
                // onTap: () {},
                onTap: () {
                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                    registerCubit.registerFunction(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      countryId: int.parse(DCacheHelper.getString(key: CacheKeys.countryId)!),
                    );
                  } else {
                    SnackBar snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.translate('mustBeFillAllFields')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)), backgroundColor: DColors.warning);

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                margin: EdgeInsets.zero,
                // onTap: () => log(phoneController.text),
                buttonColor: emailController.text.isEmpty || passwordController.text.isEmpty || confirmNewPasswordController.text.isEmpty ? DColors.disabledButton : DColors.primaryColor500,
                boxShadow: emailController.text.isEmpty || passwordController.text.isEmpty || confirmNewPasswordController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
              ),

              /// Make Space
              SizedBox(height: 30.h),

              InkWellWidget(
                onTap: () => context.pop(),
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.translate('alreadyHaveAnAccount'),
                    // text: 'Already have an account ?   ',
                    style: DStyles.bodyMediumBold.copyWith(color: DColors.greyScale900),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.translate('login'),
                        style: DStyles.bodyLargeBold.copyWith(color: DColors.primaryColor500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
