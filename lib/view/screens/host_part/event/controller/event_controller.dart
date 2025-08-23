import 'package:get/get.dart';
class EventController extends GetxController {
  RxInt currentIndex = 0.obs;
  ///============= tab bar ==========
  RxList<String> tabNamelist =
      <String>['All', 'Live', 'Upcoming', 'Past'].obs;


}