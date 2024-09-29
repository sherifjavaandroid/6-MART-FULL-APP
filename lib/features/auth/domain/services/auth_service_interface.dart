import 'package:sixam_mart/common/models/response_model.dart';
import 'package:sixam_mart/features/auth/domain/models/signup_body_model.dart';
import 'package:sixam_mart/features/auth/domain/models/social_log_in_body.dart';

abstract class AuthServiceInterface{
  bool isSharedPrefNotificationActive();
  Future<ResponseModel> registration(SignUpBodyModel signUpBody, bool isCustomerVerificationOn);
  Future<ResponseModel> login({String? phone, String? password, required bool isCustomerVerificationOn});
  Future<ResponseModel> guestLogin();
  Future<bool> loginWithSocialMedia(SocialLogInBody socialLogInBody, int timeout, bool isCustomerVerificationOn);
  Future<bool> registerWithSocialMedia(SocialLogInBody socialLogInBody, bool isCustomerVerificationOn);
  Future<void> updateToken();
  bool isLoggedIn();
  bool isGuestLoggedIn();
  String getSharedPrefGuestId();
  Future<bool> clearSharedData({bool removeToken = true});
  Future<bool> clearSharedAddress();
  Future<void> saveUserNumberAndPassword(String number, String password, String countryCode);
  String getUserNumber();
  String getUserCountryCode();
  String getUserPassword();
  Future<bool> clearUserNumberAndPassword();
  String getUserToken();
  Future updateZone();
  Future<bool> saveGuestContactNumber(String number);
  String getGuestContactNumber();
  Future<bool> saveDmTipIndex(String index);
  String getDmTipIndex();
  Future<bool> saveEarningPoint(String point);
  String getEarningPint();
  Future<void> setNotificationActive(bool isActive);
  Future<String?> saveDeviceToken();
}