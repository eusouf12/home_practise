import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../../core/app_routes/app_routes.dart';

class PaypalPaymentPage extends StatefulWidget {
  final String approvalUrl;

  const PaypalPaymentPage({super.key, required this.approvalUrl});

  @override
  State<PaypalPaymentPage> createState() => _PaypalPaymentPageState();
}

class _PaypalPaymentPageState extends State<PaypalPaymentPage> {
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

            if (url.contains("success")) {
              debugPrint(" Payment Success Redirect Detected");
              Get.offAllNamed(AppRoutes.confarmation);
            }

            if (url.contains("cancel")) {
              debugPrint(" Payment Cancelled by user");
              Get.back();
              Get.snackbar("Payment", "Payment cancelled by user");
            }
          },
          onPageFinished: (_) {
            isLoading.value = false;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.approvalUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay with PayPal")),
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
