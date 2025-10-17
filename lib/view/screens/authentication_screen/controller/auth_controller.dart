import 'dart:convert';
import 'package:event_platform/service/api_client.dart';
import 'package:event_platform/service/api_url.dart';
import 'package:event_platform/utils/ToastMsg/toast_message.dart';
import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../service/api_check.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../../utils/local_storage/local_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthController extends GetxController {
  ///========== SignUp Api Controller ==========
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> dateOfBirthController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;

  ///========== SignUp Api Loading ==========
  RxBool signUpLoading = false.obs;

  Future<void> signUp() async {
    signUpLoading.value = true;

    final role = StorageService().read<String>("role");

    Map<String, dynamic> body = {
      "name": nameController.value.text.trim(),
      "password": passwordController.value.text,
      "email": emailController.value.text.trim().toLowerCase(),
      "phoneNumber": phoneNumberController.value.text.trim(),
      "dateOfBirth": dateOfBirthController.value.text,
      "role": role,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.signUp, jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        signUpLoading.value = false;
        refresh();

        Map<String, dynamic> jsonResponse;

        if (response.body is String) {
          // If it's a string, decode it
          jsonResponse = jsonDecode(response.body);
        } else {
          // If it's already a Map (which it is from your ApiClient), use it directly
          jsonResponse = response.body as Map<String, dynamic>;
        }

        // Show success message
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Registration successful! Please verify your email.", isError: false);
        // Navigate to OTP screen
        Get.toNamed(
          AppRoutes.otpScreen,
          arguments: SignUpAuthModel(
            emailController.value.text,
            AppStrings.signUp,
          ),
        );

        // Clear signup data
        clearSignUpData();
      } else {
        signUpLoading.value = false;
        refresh();

        if (response.statusText == ApiClient.somethingWentWrong) {
          showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        } else {
          ApiChecker.checkApi(response);
        }
      }
    } catch (e) {
      signUpLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("SignUp Error: $e");
    }
  }

  ///=============== Date Formate Function ================
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirthController.value.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  ///========== Clear SignUp Data ==========
  void clearSignUpData() {
    nameController.value.clear();
    emailController.value.clear();
    phoneNumberController.value.clear();
    dateOfBirthController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();
  }

  ///======================LOGIN CONTROLLER=====================

  Rx<TextEditingController> loginEmailController = TextEditingController().obs;
  Rx<TextEditingController> loginPasswordController = TextEditingController().obs;

  ///=====================LOGIN METHOD=====================
  RxBool loginLoading = false.obs;

  Future<void> loginUser() async {
    loginLoading.value = true;

    Map<String, String> body = {
      "email": loginEmailController.value.text.trim(),
      "password": loginPasswordController.value.text.trim(),
    };

    try {
      var response = await ApiClient.postData(ApiUrl.signIn, jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        loginLoading.value = false;
        refresh();

        Map<String, dynamic> jsonResponse;

        if (response.body is String) {
          jsonResponse = jsonDecode(response.body);
        } else {
          jsonResponse = response.body as Map<String, dynamic>;
        }

        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Login successful",
          isError: false,
        );

        // Access Token
        var dataMap = jsonResponse['data'] as Map<String, dynamic>;
        String accessToken = dataMap['accessToken'].toString();

        await SharePrefsHelper.setString(AppConstants.bearerToken, accessToken);

        // Decode token
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        String userId = decodedToken['id'].toString();
        String userRole = decodedToken['role'].toString();

        await SharePrefsHelper.setString(AppConstants.userId, userId);
        await SharePrefsHelper.setString(AppConstants.role, userRole);

        // Navigate based on role
        if (userRole.toLowerCase() == "host") {
          Get.offAllNamed(AppRoutes.homeScreen);
        } else {
          Get.offAllNamed(AppRoutes.dmHomeScreen);
        }
      }
      else {
        loginLoading.value = false;
        refresh();

        Map<String, dynamic> errorResponse;

        if (response.body is String) {
          errorResponse = jsonDecode(response.body);
        } else {
          errorResponse = response.body as Map<String, dynamic>;
        }
        if (response.statusCode == 400 || response.statusCode == 401) {
          showCustomSnackBar(
            errorResponse['message']?.toString() ?? "Invalid email or password",
            isError: true,
          );
        } else {
          showCustomSnackBar(
            errorResponse['message']?.toString() ?? "Login failed",
            isError: true,
          );
        }
      }
    } catch (e) {
      loginLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("Login Error: $e");
    }
  }


  ///======================Forget password CONTROLLER=====================

  Rx<TextEditingController> forgetPasswordController = TextEditingController().obs;
  RxBool forgetPasswordLoading = false.obs;

  Future<void> forgetPassword({required String screenName}) async {
    forgetPasswordLoading.value = true;
    refresh();

    Map<String, String> body = {
      "email": forgetPasswordController.value.text,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.forgotPassword, jsonEncode(body));

      forgetPasswordLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonResponse;

        if (response.body is String) {jsonResponse = jsonDecode(response.body);
        }
        else { jsonResponse = response.body as Map<String, dynamic>;}

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Check your email for OTP", isError: false,);

        Get.toNamed(
          AppRoutes.otpScreen,
          arguments: SignUpAuthModel(
            emailController.value.text,
            AppStrings.forgetPassword,
          ),
        );

      } else {
        if (response.statusText == ApiClient.somethingWentWrong) {
          showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        } else {
          ApiChecker.checkApi(response);
        }
      }
    } catch (e) {
      forgetPasswordLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("ForgotPassword Error: $e");
    }
  }

  ///======================update password CONTROLLER=====================

  Rx<TextEditingController> updatePasswordController = TextEditingController().obs;
  RxBool updatePasswordLoading = false.obs;

  Future<void> updatePassword() async {
    updatePasswordLoading.value = true;
    refresh();

    String? userId = await SharePrefsHelper.getString(AppConstants.userId);

    // Prepare request body
    Map<String, dynamic> body = {
      "userId": userId,
      "password": updatePasswordController.value.text,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.newPassword, jsonEncode(body));

      updatePasswordLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {

        Map<String, dynamic> jsonResponse;

        if (response.body is String) {
          // If it's a string, decode it
          jsonResponse = jsonDecode(response.body);
        } else {
          // If it's already a Map (which it is from your ApiClient), use it directly
          jsonResponse = response.body as Map<String, dynamic>;
        }

        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Password updated successfully!",
          isError: false,
        );

        if (jsonResponse['data'] != null &&
            jsonResponse['data']['accessToken'] != null) {
          String accessToken = jsonResponse['data']['accessToken'].toString();

          // Save access token
          await SharePrefsHelper.setString(AppConstants.bearerToken, accessToken);

          // Decode JWT to get id & role
          Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
          String userId = decodedToken['id']?.toString() ?? "";
          String userRole = decodedToken['role']?.toString() ?? "";

          await SharePrefsHelper.setString(AppConstants.userId, userId);
          await SharePrefsHelper.setString(AppConstants.role, userRole);
        }
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        if (response.statusText == ApiClient.somethingWentWrong) {
          showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        } else {
          ApiChecker.checkApi(response);
        }
      }
    } catch (e) {
      updatePasswordLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("UpdatePassword Error: $e");
    }
  }

  ///========== OTP Controller==========
  Rx<TextEditingController> otpController = TextEditingController().obs;
  RxBool otpLoading = false.obs;

  Future<void> verifyOtp({required String screenName,}) async {
    otpLoading.value = true;
    refresh();

    // Prepare API body (verification code is always required)
    if (otpController.value.text.isEmpty) {
      otpLoading.value = false;
      showCustomSnackBar("OTP cannot be empty.", isError: true);
      return;
    }

    Map<String, dynamic> body = {
      "verificationCode": int.parse(otpController.value.text),
    };

    try {
      // PATCH request to verify OTP
      var response = await ApiClient.patchData(ApiUrl.verificationOtp, jsonEncode(body));

      otpLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse;
      if (response.body is String) {
        jsonResponse = jsonDecode(response.body);
      }
      else {
        jsonResponse = response.body as Map<String, dynamic>;
      }

      // Show success message
      showCustomSnackBar(
        jsonResponse['message']?.toString() ?? "Account verified successfully!",
        isError: false,
      );

      // Clear OTP field
      otpController.value.clear();

      // Handle accessToken if verification is successful (signup flow)
      if (screenName == AppStrings.signUp && jsonResponse['data'] != null) {
        var dataMap = jsonResponse['data'] as Map<String, dynamic>;
        String accessToken = dataMap['accessToken'].toString();

        // Save access token
        await SharePrefsHelper.setString(AppConstants.bearerToken, accessToken);

        // Decode JWT to get id & role
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        String userId = decodedToken['id'].toString();
        String userRole = decodedToken['role'].toString();

        // Save user id & role
        await SharePrefsHelper.setString(AppConstants.userId, userId);
        await SharePrefsHelper.setString(AppConstants.role, userRole);

        // Navigate to login/home
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        // For forgot password flow
        Get.offAllNamed(AppRoutes.setNewPassword);
      }
    }
    catch (e) {
      otpLoading.value = false;
      refresh();
      showCustomSnackBar(
        "An error occurred. Please try again.",
        isError: true,
      );
      debugPrint("OTP Verification Error: $e");
    }
  }

}

///========== Models ==========
class SignUpAuthModel {
  final String email;
  final String screenName;

  SignUpAuthModel(
    this.email,
    this.screenName,
  );
}
