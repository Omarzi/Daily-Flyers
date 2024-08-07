import 'package:daily_flyers_app/features/home/managers/home_cubit.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController countryController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  bool isNameFieldFocused = false;
  bool isEmailFieldFocused = false;

  @override
  void initState() {
    // if(HomeCubit.get(context).profileDataModel.favCompanies == null || HomeCubit.get(context).favCompanies.isEmpty)  HomeCubit.get(context).profileDataFunction();
    /// Add listener to focus node
    nameFocusNode.addListener(() => setState(() => isNameFieldFocused = nameFocusNode.hasFocus));
    emailFocusNode.addListener(() => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
    super.initState();
    HomeCubit.get(context).profileDataFunction();
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.whiteColor,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var profileCubit = HomeCubit.get(context);

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 38.h,
                    child: Row(
                      children: [
                        InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))),
                        SizedBox(width: 16.w),
                        Text('${AppLocalizations.of(context)!.translate('profile')}', style: DStyles.h4Bold),
                      ],
                    ),
                  ),

                  /// Make Space
                  SizedBox(height: 33.5.h),

                  Text('${AppLocalizations.of(context)!.translate('userName')}:', style: DStyles.h5Bold.copyWith(fontWeight: FontWeight.w500)),

                  SizedBox(height: 10.h),

                  TextFormFieldWidget(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    focusNode: nameFocusNode,
                    hintText: profileCubit.profileDataModel == null ? '...' : profileCubit.profileDataModel.name ?? '...',
                    hintColor: isNameFieldFocused ? DColors.primaryColor500 : DColors.greyScale900,
                    fillColor: isNameFieldFocused ? DColors.purpleTransparent.withOpacity(.08) : DColors.greyScale50,
                    borderSide: isNameFieldFocused ? BorderSide(color: DColors.primaryColor500) : BorderSide.none,
                    obscureText: false,
                  ),

                  SizedBox(height: 10.h),

                  Text('${AppLocalizations.of(context)!.translate('email')}:', style: DStyles.h5Bold.copyWith(fontWeight: FontWeight.w500)),

                  SizedBox(height: 10.h),

                  /// Email
                  TextFormFieldWidget(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    // hintText: '3omar@gmail.com',
                    hintText: profileCubit.profileDataModel == null ? '...' : profileCubit.profileDataModel.email ?? 'Email (Optional)',
                    hintColor: isEmailFieldFocused ? DColors.primaryColor500 : DColors.greyScale900,
                    prefixIcon: SvgPicture.asset(DImages.email2Icon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(DColors.greyScale900, BlendMode.srcIn)),
                    fillColor: isEmailFieldFocused ? DColors.purpleTransparent.withOpacity(.08) : DColors.greyScale50,
                    borderSide: isEmailFieldFocused ? BorderSide(color: DColors.primaryColor500) : BorderSide.none,
                    obscureText: false,
                    isEdit: true,
                  ),

                  SizedBox(height: 30.h),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MainButtonWidget(
                      // centerWidgetInButton: state is UpdateProfileDataLoadingState
                      //     ? LoadingWidget(iconColor: DColors.whiteColor)
                      //     :
                      centerWidgetInButton: Text('${AppLocalizations.of(context)!.translate('update')}:', style: DStyles.bodyLargeBold.copyWith(color: DColors.whiteColor)),
                      // onTap: state is UpdateProfileDataLoadingState ? null : () {
                      //   profileCubit.updateProfileDataFunc(
                      //     firstName: nameController.text.isEmpty ? profileCubit.getProfileDataModel.result!.firstName! : nameController.text,
                      //     lastName: lastNameController.text.isEmpty ? profileCubit.getProfileDataModel.result!.lastName! : lastNameController.text,
                      //     email: emailController.text.isEmpty ? profileCubit.getProfileDataModel.result!.email : emailController.text,
                      //     countryId: idSelectedForCountry.toString().isEmpty || idSelectedForCountry == null ? profileCubit.getProfileDataModel.result!.country!.id.toString() : idSelectedForCountry.toString(),
                      //     cityId: idSelectedForCity.toString().isEmpty || idSelectedForCity == null ? profileCubit.getProfileDataModel.result!.country!.id.toString() : idSelectedForCity.toString(),
                      //     phone: phoneController.text.isEmpty ? profileCubit.getProfileDataModel.result!.phone! : phoneController.text,
                      //     gender: selectedGender == 'Male' || selectedGender == 'male' ? 'male' : selectedGender == 'Female' || selectedGender == 'female' ? 'female' : 'other',
                      //     servicesId: AuthCubit.get(context).getAllServicesModel.result?.where((element) => element.isSelected ?? false).map((e) => e.id!).toList() ?? [],
                      //     // servicesId: AuthCubit.get(context).getAllServicesModel.result?.where((element) => element.isSelected ?? false).map((e) => e.id!).toList() ?? [],
                      //     // AuthCubit.get(context).getAllServicesModel.result?.where((element) => element.isSelected ?? false).map((e) => e.id!).toList() ?? []
                      //     frontId: _selectedImage1 == null || _selectedImage1!.path.isEmpty ? null : File(_selectedImage1!.path),
                      //     backId: _selectedImage2 == null || _selectedImage2!.path.isEmpty ? null : File(_selectedImage2!.path),
                      //     certificate: _selectedImage3 == null || _selectedImage3!.path.isEmpty ? null : File(_selectedImage3!.path),
                      //   );
                      // },
                      onTap: () {

                      },
                      margin: EdgeInsets.zero,
                      buttonColor: nameController.text.isEmpty || emailController.text.isEmpty ? DColors.disabledButton : DColors.primaryColor500,
                      boxShadow: nameController.text.isEmpty || emailController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
                      // height: 58.h,
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
