import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../dm_home_screen/dm_home_screen.dart';

class DmFilter extends StatefulWidget {
  const DmFilter({super.key});

  @override
  State<DmFilter> createState() => _DmFilterState();
}

class _DmFilterState extends State<DmFilter> {
  // Store selected filters for each category
  Map<String, Set<String>> selectedFilters = {
    'Event Type': {},
    'Price Range': {},
    'Date Line': {},
    'Audience': {},
    'Access Type': {},
    'Event Features': {},
  };

  // Timeline TextField controller
  final TextEditingController timelineController = TextEditingController();

  // All filter options for each category
  final Map<String, List<String>> filterOptions = {
    'Event Type': [
      'Concerts',
      'Sports',
      'Family-Friendly',
      'Neighborhood Events',
      'Most Popular',
      'Food Festivals',
      'Parties',
      'Others'
    ],
    'Price Range': ['Free', 'Paid'],
    'Date Line': [],
    'Audience': ['No Age Restriction', '18+', '21+'],
    'Access Type': ['Public', 'Private'],
    'Event Features': [
      'Outdoor',
      'Indoor',
      'wheelchair accessible',
      'Pet Friendly',
      'ASL Interpreter'
    ],
  };

  Widget buildFilterChip(String category, String label) {
    bool isSelected = selectedFilters[category]!.contains(label);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedFilters[category]!.remove(label);
          } else {
            selectedFilters[category]!.add(label);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? AppColors.primary : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.white,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.0),
          child: CustomText(
            text: label,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildCategory(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 34),
          CustomText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 15),
          title == "Date Line"
              ? CustomTextField(
                  fillColor: AppColors.white,
            hintText: 'mm-dd-yyyy',
            readOnly: true,
            hintStyle: TextStyle(
              color: AppColors.black_02,
            ), suffixIcon: Icon(Icons.calendar_month_outlined),
                )
              : Wrap(
                  spacing: 11,
                  runSpacing: 11,
                  children: filterOptions[title]!
                      .map((label) => buildFilterChip(title, label))
                      .toList(),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void applyFilters() {
    if (timelineController.text.isNotEmpty) {
      selectedFilters['Date Line'] = {timelineController.text};
    }

    //  send selectedFilters to your database
    // print("Selected Filters: $selectedFilters");

    Get.to(() => const DmHomeScreen());
  }

  void resetFilters() {
    setState(() {
      selectedFilters.forEach((key, value) => value.clear());
      timelineController.clear();
    });
  }

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomRoyelAppbar(
        titleName: "Filter Events",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCategory('Event Type'),
            Divider(thickness: 1, color: AppColors.primary),
            buildCategory('Price Range'),
            Divider(thickness: 1, color: AppColors.primary),
            buildCategory('Date Line'),
            Divider(thickness: 1, color: AppColors.primary),
            buildCategory('Audience'),
            Divider(thickness: 1, color: AppColors.primary),
            buildCategory('Access Type'),
            Divider(thickness: 1, color: AppColors.primary),
            buildCategory('Event Features'),
            Divider(thickness: 1, color: AppColors.primary),
            const SizedBox(height: 40),

            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () => applyFilters(),
                      title: 'Apply Filters',
                      height: 56,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      fillColor: AppColors.primary,
                      textColor: Colors.white,
                      isBorder: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      onTap: () => resetFilters(),
                      title: 'Reset All',
                      height: 56,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      fillColor: Colors.transparent,
                      textColor: Colors.black,
                      isBorder: true,
                      borderWidth: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    ));
  }
}
