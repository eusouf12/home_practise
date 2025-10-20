import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../utils/app_colors/app_colors.dart';

class StripeWebViewScreen2 extends StatefulWidget {
  final String onboardingUrl;

  const StripeWebViewScreen2({super.key, required this.onboardingUrl});

  @override
  State<StripeWebViewScreen2> createState() => _StripeWebViewScreenState();
}

class _StripeWebViewScreenState extends State<StripeWebViewScreen2> {
  final RxBool isLoading = true.obs;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("Started URL: $url");

            // Optional: detect success/cancel URLs if Stripe provides redirect URLs
            if (url.contains("success")) {
              debugPrint("Stripe Setup Completed");
              Get.back(); // Go back after successful setup
              Get.snackbar("Stripe", "Setup completed successfully!");
            }

            if (url.contains("cancel")) {
              debugPrint("Stripe Setup Cancelled");
              Get.back();
              Get.snackbar("Stripe", "Setup cancelled by user");
            }
          },
          onPageFinished: (_) {
            isLoading.value = false;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.onboardingUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // leading: BackButton(onPressed: () {
        //   Get.back();
        // },
        //     color: AppColors.black
        // ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          Obx(() => isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
