
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({
    required this.message,
    required this.success,
  });
}

class StripeServices {
  static http.Client client = http.Client();
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeServices.apiBase}/payment_intents';
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);
  static String secret = dotenv.env['STRIPE_SECRET']!;

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeServices.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    Stripe.publishableKey = dotenv.env['STRIPE_SECRET']!;
    
  }
  static Future<Map<String, dynamic>> createCustomer() async {
    const String url = 'https://api.stripe.com/v1/customers';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'description': 'new customer'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to register as a customer.';
    }
  }
  static Future<Map<String, dynamic>> createPaymentIntents() async {
    const String url = 'https://api.stripe.com/v1/payment_intents';

    Map<String, dynamic> body = {
      'amount': '2000',
      'currency': 'usd',
      'payment_method_types[]': 'card'
    };

    var response =
    await client.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to create PaymentIntents.';
    }
  }

  static Future<void> createCreditCard(String customerId, String paymentIntentClientSecret) async {

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Flutter Stripe Store Demo',
          customerId: customerId,
          paymentIntentClientSecret: paymentIntentClientSecret,
        ));

    await Stripe.instance.presentPaymentSheet();

  }

  static Future<void> payment() async {
    init();
    final _customer = await createCustomer();
    final _paymentIntent = await createPaymentIntents();
    await createCreditCard(_customer['id'], _paymentIntent['client_secret']);
  }

  
}