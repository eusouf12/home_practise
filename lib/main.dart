import 'package:event_management/core/app_routes/app_routes.dart';
import 'package:event_management/core/dependency/dependency_injection.dart';
import 'package:event_management/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_preview/device_preview.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.white, 
    statusBarIconBrightness: Brightness.dark, 
    statusBarBrightness: Brightness.light, 
  ));
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  runApp(
     DevicePreview(
      enabled: !const bool.fromEnvironment(
        'dart.vm.product',
      ), 
      builder: (context) => const MyApp(), 
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(393, 842),
      child: GetMaterialApp(
        title: 'Event Management',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          appBarTheme: const AppBarTheme(
            toolbarHeight: 65,
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.white,
            iconTheme: IconThemeData(color: AppColors.black),
          ),
          textTheme: GoogleFonts.interTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoutes.profileRoleScreen,
        navigatorKey: Get.key,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
