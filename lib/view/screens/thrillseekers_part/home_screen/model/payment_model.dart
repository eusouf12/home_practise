class StripeResponse {
  final bool success;
  final String message;
  final StripeData data;

  StripeResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StripeResponse.fromJson(Map<String, dynamic> json) {
    return StripeResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: StripeData.fromJson(json['data'] ?? {}),
    );
  }
}

class StripeData {
  final OnboardingUrl onboardingUrl;

  StripeData({required this.onboardingUrl});

  factory StripeData.fromJson(Map<String, dynamic> json) {
    return StripeData(
      onboardingUrl: OnboardingUrl.fromJson(json['onboardingUrl'] ?? {}),
    );
  }
}

class OnboardingUrl {
  final String? url;
  final String? cardPayments;
  final String? transfers;

  OnboardingUrl({this.url, this.cardPayments, this.transfers});

  factory OnboardingUrl.fromJson(Map<String, dynamic> json) {
    return OnboardingUrl(
      url: json['onboardingUrl'], // new user
      cardPayments: json['card_payments'], // registered user
      transfers: json['transfers'],       // registered user
    );
  }
}
