
import 'package:daily_flyers_app/features/auth/managers/auth_cubit.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key, required this.message});

  final String message;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  bool isEmailFieldFocused = false;
  bool isPasswordFieldFocused = false;
  bool isPhoneFieldFocused = false;
  bool isChecked = false;
  bool isShown = false;

  @override
  void initState() {
    super.initState();

    /// Add listener to focus node
    emailFocusNode.addListener(
            () => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
    passwordFocusNode.addListener(
            () => setState(() => isPasswordFieldFocused = passwordFocusNode.hasFocus));
    phoneFocusNode.addListener(
            () => setState(() => isPhoneFieldFocused = phoneFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is LoginSuccessState) {
          context.pushNamedAndRemoveUntil(DRoutesName.homeRoute, predicate: (route) => false);
        } else if(state is LoginErrorState) {
          String messageError = state.message;
          
          // SnackBar snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.translate('loginError')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)), backgroundColor: DColors.error);
          SnackBar snackBar = SnackBar(
            content: Text(
                messageError == 'Not Found: Customer Not Fount'
                    ? AppLocalizations.of(context)!.translate('unAuth')!
                    : messageError == 'Un authorized: Invalid Credentials'
                    ? AppLocalizations.of(context)!.translate('unAuth')!
                    : 'Not Found: Customer Not Found',
                style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor),
            ),
            backgroundColor: DColors.error,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);

        return Container(
          width: double.infinity,
          // height: 335.h,
          // color: Colors.red,
          child: Column(
            children: [
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

              /// Make Space
              SizedBox(height: 48.h),

              /// Sign in Button
              MainButtonWidget(
                centerWidgetInButton: state is LoginLoadingState
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(AppLocalizations.of(context)!.translate('continue')!, style: DStyles.bodyLargeBold.copyWith(color: DColors.whiteColor)),
                // onTap: () => context.pushNamedAndRemoveUntil(DRoutesName.navigationMenuRoute, predicate: (route) => false),
                onTap: () {
                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                    DCacheHelper.putString(key: CacheKeys.skipLogin, value: '');
                    authCubit.loginFunction(email: emailController.text, password: passwordController.text);
                  } else {
                    SnackBar snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.translate('mustBeFillAllFields')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.whiteColor)), backgroundColor: DColors.warning);

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                margin: EdgeInsets.zero,
                // onTap: () => log(phoneController.text),
                buttonColor: emailController.text.isEmpty || phoneController.text.isEmpty ? DColors.disabledButton : DColors.primaryColor500,
                boxShadow: emailController.text.isEmpty || phoneController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
              ),

              /// Make Space
              SizedBox(height: 30.h),

              InkWellWidget(
                onTap: () => context.pushNamed(DRoutesName.registerRoute),
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.translate('doNotHaveAnAccount'),
                    style: DStyles.bodyMediumBold.copyWith(color: DColors.greyScale900),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.translate('singUp'),
                        style: DStyles.bodyLargeBold.copyWith(color: DColors.primaryColor500),
                      ),
                    ],
                  ),
                ),
              ),

              /// Make Space
              SizedBox(height: 24.h),

              if(widget.message.isEmpty) InkWellWidget(
                onTap: () {
                  DCacheHelper.putString(key: CacheKeys.skipLogin, value: 'skipped');
                  context.pushNamedAndRemoveUntil(DRoutesName.navigationMenuRoute, predicate: (route) => false);
                },
                child: Text(AppLocalizations.of(context)!.translate('skipMakeLogin')!, style: DStyles.bodyMediumBold.copyWith(color: DColors.info, decoration: TextDecoration.underline, decorationColor: DColors.info)),
              ),
            ],
          ),
        );
      },
    );
  }
}
