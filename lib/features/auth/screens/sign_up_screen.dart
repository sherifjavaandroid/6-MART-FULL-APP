import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/auth/domain/models/signup_body_model.dart';
import 'package:sixam_mart/features/auth/screens/sign_in_screen.dart';
import 'package:sixam_mart/features/auth/widgets/condition_check_box_widget.dart';
import 'package:sixam_mart/helper/custom_validator.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/helper/validate_check.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/custom_text_field.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  final bool exitFromApp;
  const SignUpScreen({super.key, this.exitFromApp = false});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _referCodeFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _referCodeController = TextEditingController();
  String? _countryDialCode;
  GlobalKey<FormState>? _formKeySignUp;

  @override
  void initState() {
    super.initState();

    _formKeySignUp = GlobalKey<FormState>();
    _countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel!.country!).dialCode;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: (ResponsiveHelper.isDesktop(context) ? null : !widget.exitFromApp ? AppBar(leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_rounded, color: Theme.of(context).textTheme.bodyLarge!.color),
        ), elevation: 0, backgroundColor: Colors.transparent,
          actions: const [SizedBox()],
        ) : null),
        backgroundColor: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Theme.of(context).cardColor,
        endDrawer: const MenuDrawer(), endDrawerEnableOpenDragGesture: false,
        body: Center(
          child: Container(
            width: context.width > 700 ? 700 : context.width,
            padding: context.width > 700 ? const EdgeInsets.all(0) : const EdgeInsets.all(Dimensions.paddingSizeLarge),
            margin: context.width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
            decoration: context.width > 700 ? BoxDecoration(
              color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ) : null,
            child: GetBuilder<AuthController>(builder: (authController) {

              return SingleChildScrollView(
                child: Stack(
                  children: [

                    ResponsiveHelper.isDesktop(context) ? Positioned(
                      top: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ) : const SizedBox(),


                    Form(
                      key: _formKeySignUp,
                      child: Padding(
                        padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.all(40) : EdgeInsets.zero,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

                          Image.asset(Images.logo, width: 125),
                          const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('sign_up'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeDefault),

                          Row(children: [
                            Expanded(
                              child: CustomTextField(
                                labelText: 'first_name'.tr,
                                titleText: 'ex_jhon'.tr,
                                controller: _firstNameController,
                                focusNode: _firstNameFocus,
                                nextFocus: _lastNameFocus,
                                inputType: TextInputType.name,
                                capitalization: TextCapitalization.words,
                                prefixIcon: Icons.person,
                                required: true,
                                labelTextSize: Dimensions.fontSizeDefault,
                                validator: (value) => ValidateCheck.validateEmptyText(value, null),
                              ),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeSmall),

                            Expanded(
                              child: CustomTextField(
                                labelText: 'last_name'.tr,
                                titleText: 'ex_doe'.tr,
                                controller: _lastNameController,
                                focusNode: _lastNameFocus,
                                nextFocus: ResponsiveHelper.isDesktop(context) ? _emailFocus : _phoneFocus,
                                inputType: TextInputType.name,
                                capitalization: TextCapitalization.words,
                                prefixIcon: Icons.person,
                                required: true,
                                labelTextSize: Dimensions.fontSizeDefault,
                                validator: (value) => ValidateCheck.validateEmptyText(value, null),
                              ),
                            )
                          ]),
                          const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                          Row(children: [
                            ResponsiveHelper.isDesktop(context) ? Expanded(
                              child: CustomTextField(
                                labelText: 'email'.tr,
                                titleText: 'enter_email'.tr,
                                controller: _emailController,
                                focusNode: _emailFocus,
                                nextFocus: ResponsiveHelper.isDesktop(context) ? _phoneFocus : _passwordFocus,
                                inputType: TextInputType.emailAddress,
                                prefixImage: Images.mail,
                                required: true,
                                validator: (value) => ValidateCheck.validateEmail(value),
                              ),
                            ) : const SizedBox(),
                            SizedBox(width: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeSmall : 0),

                            Expanded(
                              child: CustomTextField(
                                labelText: 'phone'.tr,
                                titleText: 'enter_phone_number'.tr,
                                controller: _phoneController,
                                focusNode: _phoneFocus,
                                nextFocus: ResponsiveHelper.isDesktop(context) ? _passwordFocus : _emailFocus,
                                inputType: TextInputType.phone,
                                isPhone: true,
                                onCountryChanged: (CountryCode countryCode) {
                                  _countryDialCode = countryCode.dialCode;
                                },
                                countryDialCode: _countryDialCode != null ? CountryCode.fromCountryCode(Get.find<SplashController>().configModel!.country!).code
                                    : Get.find<LocalizationController>().locale.countryCode,
                                required: true,
                                validator: (value) => ValidateCheck.validatePhone(value, null),
                              ),
                            ),

                          ]),
                          const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                          !ResponsiveHelper.isDesktop(context) ? CustomTextField(
                            labelText: 'email'.tr,
                            titleText: 'enter_email'.tr,
                            controller: _emailController,
                            focusNode: _emailFocus,
                            nextFocus: _passwordFocus,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: Icons.mail,
                            required: true,
                            validator: (value) => ValidateCheck.validateEmptyText(value, null),
                          ) : const SizedBox(),
                          SizedBox(height: !ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : 0),

                          Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Expanded(
                              child: Column(children: [
                                CustomTextField(
                                  labelText: 'password'.tr,
                                  titleText: '8_character'.tr,
                                  controller: _passwordController,
                                  focusNode: _passwordFocus,
                                  nextFocus: _confirmPasswordFocus,
                                  inputType: TextInputType.visiblePassword,
                                  prefixIcon: Icons.lock,
                                  isPassword: true,
                                  required: true,
                                  validator: (value) => ValidateCheck.validateEmptyText(value, null),
                                ),

                              ]),
                            ),
                            SizedBox(width: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeSmall : 0),

                            ResponsiveHelper.isDesktop(context) ? Expanded(child: CustomTextField(
                              labelText: 'confirm_password'.tr,
                              titleText: '8_character'.tr,
                              controller: _confirmPasswordController,
                              focusNode: _confirmPasswordFocus,
                              nextFocus: Get.find<SplashController>().configModel!.refEarningStatus == 1 ? _referCodeFocus : null,
                              inputAction: Get.find<SplashController>().configModel!.refEarningStatus == 1 ? TextInputAction.next : TextInputAction.done,
                              inputType: TextInputType.visiblePassword,
                              prefixIcon: Icons.lock,
                              isPassword: true,
                              onSubmit: (text) => (GetPlatform.isWeb) ? _register(authController, _countryDialCode!) : null,
                              required: true,
                              validator: (value) => ValidateCheck.validateEmptyText(value, null),
                            )) : const SizedBox()

                          ]),
                          const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                          !ResponsiveHelper.isDesktop(context) ? CustomTextField(
                            labelText: 'confirm_password'.tr,
                            titleText: '8_character'.tr,
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocus,
                            nextFocus: Get.find<SplashController>().configModel!.refEarningStatus == 1 ? _referCodeFocus : null,
                            inputAction: Get.find<SplashController>().configModel!.refEarningStatus == 1 ? TextInputAction.next : TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock,
                            isPassword: true,
                            onSubmit: (text) => (GetPlatform.isWeb) ? _register(authController, _countryDialCode!) : null,
                            required: true,
                            validator: (value) => ValidateCheck.validateEmptyText(value, null),
                          ) : const SizedBox(),
                          SizedBox(height: !ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : 0),

                          (Get.find<SplashController>().configModel!.refEarningStatus == 1 ) ? CustomTextField(
                            labelText: 'refer_code'.tr,
                            titleText: 'enter_refer_code'.tr,
                            controller: _referCodeController,
                            focusNode: _referCodeFocus,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.text,
                            capitalization: TextCapitalization.words,
                            prefixImage: Images.referCode,
                            prefixSize: 14,
                          ) : const SizedBox(),
                          const SizedBox(height: Dimensions.paddingSizeLarge),

                          const ConditionCheckBoxWidget(forDeliveryMan: true),
                          const SizedBox(height: Dimensions.paddingSizeLarge),

                          CustomButton(
                            height: ResponsiveHelper.isDesktop(context) ? 45 : null,
                            width:  ResponsiveHelper.isDesktop(context) ? 180 : null,
                            radius: ResponsiveHelper.isDesktop(context) ? Dimensions.radiusSmall : Dimensions.radiusDefault,
                            isBold: !ResponsiveHelper.isDesktop(context),
                            fontSize: ResponsiveHelper.isDesktop(context) ? Dimensions.fontSizeExtraSmall : null,
                            buttonText: 'sign_up'.tr,
                            isLoading: authController.isLoading,
                            onPressed: authController.acceptTerms ? () => _register(authController, _countryDialCode!) : null,
                          ),

                          const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('already_have_account'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

                            InkWell(
                              onTap: () {
                                if(ResponsiveHelper.isDesktop(context)){
                                  Get.back();
                                  Get.dialog(const SignInScreen(exitFromApp: false, backFromThis: false));
                                }else{
                                  if(Get.currentRoute == RouteHelper.signUp) {
                                    Get.back();
                                  } else {
                                    Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.signUp));
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                child: Text('sign_in'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
                              ),
                            ),
                          ]),

                        ]),
                      ),
                    ),

                  ],
                ),
              );

            }),
          ),
        ),
      ),
    );
  }

  void _register(AuthController authController, String countryCode) async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String number = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String referCode = _referCodeController.text.trim();

    String numberWithCountryCode = countryCode+number;
    PhoneValid phoneValid = await CustomValidator.isPhoneValid(numberWithCountryCode);
    numberWithCountryCode = phoneValid.phone;

    if(_formKeySignUp!.currentState!.validate()) {
      if (firstName.isEmpty) {
        showCustomSnackBar('enter_your_first_name'.tr);
      }else if (lastName.isEmpty) {
        showCustomSnackBar('enter_your_last_name'.tr);
      }else if (email.isEmpty) {
        showCustomSnackBar('enter_email_address'.tr);
      }else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('enter_a_valid_email_address'.tr);
      }else if (number.isEmpty) {
        showCustomSnackBar('enter_phone_number'.tr);
      }else if (!phoneValid.isValid) {
        showCustomSnackBar('invalid_phone_number'.tr);
      }else if (password.isEmpty) {
        showCustomSnackBar('enter_password'.tr);
      }else if (password.length < 6) {
        showCustomSnackBar('password_should_be'.tr);
      }else if (password != confirmPassword) {
        showCustomSnackBar('confirm_password_does_not_matched'.tr);
      }else {

        String? deviceToken = await authController.saveDeviceToken();

        SignUpBodyModel signUpBody = SignUpBodyModel(
          fName: firstName, lName: lastName, email: email, phone: numberWithCountryCode,
          password: password, refCode: referCode, deviceToken: deviceToken,
        );
        authController.registration(signUpBody).then((status) async {
          if (status.isSuccess) {
            if(Get.find<SplashController>().configModel!.customerVerification!) {
              if(Get.find<SplashController>().configModel!.firebaseOtpVerification!) {
                Get.find<AuthController>().firebaseVerifyPhoneNumber(numberWithCountryCode, status.message, fromSignUp: true);
              } else {
                List<int> encoded = utf8.encode(password);
                String data = base64Encode(encoded);
                Get.toNamed(RouteHelper.getVerificationRoute(numberWithCountryCode, status.message, RouteHelper.signUp, data));
              }
            }else {
              Get.find<LocationController>().navigateToLocationScreen(RouteHelper.signUp);
              if(ResponsiveHelper.isDesktop(Get.context)){
                Get.back();
              }
            }
          }else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

  }
}
