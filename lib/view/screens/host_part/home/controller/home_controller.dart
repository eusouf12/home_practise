import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {


  final catagoryName = ["All, Others, Personal"].obs;
  // Date
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Start & End Time
  final Rx<TimeOfDay?> startTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);

  // Format Date
  String get formattedDate {
    if (selectedDate.value != null) {
      return DateFormat('dd-MM-yyyy').format(selectedDate.value!);
    }
    return '';
  }

  // Format Start Time
  String get formattedStartTime {
    if (startTime.value != null) {
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day,
          startTime.value!.hour, startTime.value!.minute);
      return DateFormat('hh:mm a').format(dt);
    }
    return '';
  }

  // Format End Time
  String get formattedEndTime {
    if (endTime.value != null) {
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day,
          endTime.value!.hour, endTime.value!.minute);
      return DateFormat('hh:mm a').format(dt);
    }
    return '';
  }

  // Pick Date
  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  // Pick Start Time
  Future<void> pickStartTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: startTime.value ?? TimeOfDay.now(),
    );
    if (picked != null) {
      startTime.value = picked;
    }
  }

  // Pick End Time
  Future<void> pickEndTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: endTime.value ?? TimeOfDay.now(),
    );
    if (picked != null) {
      endTime.value = picked;
    }
  }
}