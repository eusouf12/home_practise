import 'package:get/get.dart';
class DmSocialController extends GetxController {
  RxInt currentIndex = 0.obs;
  ///============= tab bar ==========
  RxList<String> tabNamelist =
      <String>['Social Feed', 'Group', 'Chatroom'].obs;


}