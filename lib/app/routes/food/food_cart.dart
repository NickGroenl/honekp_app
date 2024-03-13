// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/config.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/foodandbeverage.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/shop.dart';
import 'package:newhonekapp/app/routes/food/food.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/shop_card.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:translator/translator.dart';

class ShopCart extends StatefulWidget {
  final List<FoodAndBeverageModel> yourCart;
  const ShopCart({super.key, required this.yourCart});

  @override
  createState() => _ShopCart();
}

class _ShopCart extends State<ShopCart> {
  late double price = 0;
  bool isLoading = false;
  bool visible = false;
  String clientSecret = '';

  final translator = GoogleTranslator();
  String cart = 'Carello';
  String pay = 'Pagamento';

  getTransalations(String lang) async {
    var cartCast = await translator.translate(cart, from: 'it', to: lang);
    var payCast = await translator.translate(pay, from: 'it', to: lang);
    setState(() {
      cart = cartCast.text;
      pay = payCast.text;
    });

    return false;
  }

  @override
  void initState() {
    super.initState();
    getTransalations(currentUser.value.default_language);
    if (currentBooking.value.isNotEmpty) {
      Stripe.publishableKey = currentBooking.value[0].key_public;
    }
    double summatory = 0;
    for (var i = 0; i < widget.yourCart.length; i++) {
      summatory = summatory + double.parse(widget.yourCart[i].price);
    }
    setState(() {
      price = summatory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
                text: "${"$pay (€$price"}0)",
                onPressed: () async => {
                  if(price > 0){
                        await payment_intents(
                            price, "eur", "card")
                  }})
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SafeArea(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          onPressed: (() {
                            Helper.nextScreen(context, Food());
                          }),
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              cart,
                              style: GoogleFonts.roboto(
                                fontSize: 20.0,
                                height: 1.5,
                                color: Color.fromARGB(255, 71, 80, 106),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Room Service",
                              style: GoogleFonts.roboto(
                                fontSize: 15.0,
                                height: 1.2,
                                color: Color.fromARGB(255, 89, 90, 93),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Spacer()
                      ],
                    ),
                    SizedBox(height: 32),
                    for (var item in widget.yourCart)
                      ShopCard(
                        card: item,
                      ),
                  ]));
        }),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<String> payment_intents(
      double? amount, String? currency, String? paymentMethodTypes) async {
    setState(() {
      isLoading = true;
    });
    print((amount! * 100).toString());
    Map data = {
      'amount':  (amount! * 100).toInt().toString(),
      
      'currency': currency,
      'payment_method_types[]': paymentMethodTypes
    };

    var url = 'https://api.stripe.com/v1/payment_intents';

    var body = data;
    String token = currentBooking.value[0].key_secret != ''
        ? currentBooking.value[0].key_secret
        : '';
    print(currentBooking.value[0].key_public);
    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body);
    String str = response.body.toString();
    Map<String, dynamic> user = jsonDecode(str);
    print(user);
    print(response.body);
    clientSecret = user['client_secret'] ?? '';
    initPaymentSheet();
    setState(() {
      isLoading = false;
    });
    return response.body.toString();
  }

  Future<void> initPaymentSheet() async {
    visible = false;

    try {
      // create some billingdetails
      final billingDetails = BillingDetails(
        name: 'Honek',
        email: 'honek@labict.it',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mocked data for tests

      // initialize the payment sheet

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: PaymentSheetApplePay(
            merchantCountryCode: 'US',
          ),
          googlePay: PaymentSheetGooglePay(
            testEnv: false,
            merchantCountryCode: 'US',
          ),

          // Main params
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Honek',

          style: ThemeMode.dark,
          billingDetails: billingDetails,
        ),
      );
      confirmPayment();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<void> confirmPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment succesfully completed'),
        ),
      );

      for (var item in currentCart.value) {
        await addShop({
          "title": item.name,
          "price": item.price,
          "image": item.image,
          "product_id": item.id
        });
      }
      currentCart.value = [];
      Helper.nextScreen(context, Food());
      await getShops();
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: $e'),
          ),
        );
      }
    }
  }

  Future<Map<String, dynamic>> fetchPaymentIntentClientSecret() async {
    final url = Uri.parse('$kApiUrl/create-payment-intent');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': currentUser.value.email,
        'currency': 'eur',
        'items': ['id-1'],
        'request_three_d_secure': 'any',
      }),
    );
    return json.decode(response.body);
  }
}
