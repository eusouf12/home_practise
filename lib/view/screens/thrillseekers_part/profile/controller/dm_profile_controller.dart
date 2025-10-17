import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_const/app_const.dart';


class DmProfileController extends GetxController {
  // Text controllers
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> dateOfBirthController = TextEditingController().obs;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;

//========== getUserProfile controller ==========
  final rxRequestStatus = Status.loading.obs;
  void setRequestStatus(Status status) => rxRequestStatus.value = status;

  Rx<UserProfileModel2> userProfileModel = UserProfileModel2(
      id: '', name: '', email: '', phoneNumber: '', dateOfBirth: '', photo: ''
  ).obs;

  Future<void> getUserProfile() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.myProfile);

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = response.body['data'];
        userProfileModel.value = UserProfileModel2.fromJson(data);

        if (nameController.value.text.isEmpty) {
          nameController.value.text = userProfileModel.value.name??"";
        }
        emailController.value.text = userProfileModel.value.email??"";
        if (phoneNumberController.value.text.isEmpty) {
          phoneNumberController.value.text = userProfileModel.value.phoneNumber??"";
        }
        if (dateOfBirthController.value.text.isEmpty) {
          dateOfBirthController.value.text = userProfileModel.value.dateOfBirth??"";
        }

        setRequestStatus(Status.completed);
        update();
      } catch (e) {
        setRequestStatus(Status.error);
        debugPrint("Parsing error: $e");
      }
    } else {
      setRequestStatus(Status.error);
      Get.snackbar("Error", "Failed to load user profile.");
    }
  }


  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }
}

class UserProfileModel2 {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? photo;

  UserProfileModel2({
     this.id,
     this.name,
     this.email,
     this.phoneNumber,
     this.dateOfBirth,
     this.photo,
  });

  factory UserProfileModel2.fromJson(Map<String, dynamic> json) {
    return UserProfileModel2(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      photo: json['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'photo': photo,
    };
  }
}

class Verification {
  final dynamic code;
  final dynamic expireDate;

  Verification({
    this.code,
    this.expireDate,
  });

  factory Verification.fromRawJson(String str) =>
      Verification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    code: json["code"],
    expireDate: json["expireDate"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "expireDate": expireDate,
  };
}