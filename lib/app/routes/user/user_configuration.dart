import 'package:cache_manager/cache_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/routes/user/login.dart';
import 'package:newhonekapp/app/routes/user/configuration/billing.dart';
import 'package:newhonekapp/app/routes/user/configuration/direction.dart';
import 'package:newhonekapp/app/routes/user/configuration/documentation.dart';
import 'package:newhonekapp/app/routes/user/configuration/marketing.dart';
import 'package:newhonekapp/app/routes/user/configuration/password.dart';
import 'package:newhonekapp/app/routes/user/configuration/profile.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../../../ui-kit/utils/helper.dart';
import '../../../ui-kit/widgets/line_card.dart';
import '../../models/bookings/bookings.dart';
import '../../models/user.dart';


class UserConfiguration extends StatefulWidget {
  const UserConfiguration({super.key});

  @override
  createState() => _UserConfiguration();
}


class _UserConfiguration extends State<UserConfiguration> {
  String profile = 'Profilo';
  String direction = 'Indirizzo';
  String marketing = 'Comunicazioni marketing';
  String facturation = 'Fatturazione';
  String document = 'Documenti';
  String signout = 'Esci';

  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var profileCast =
        await translator.translate(profile, from: 'it', to: lang);
    var directionCast =
        await translator.translate(direction, from: 'it', to: lang);
    var marketingCast =
        await translator.translate(marketing, from: 'it', to: lang);
    var facturationCast =
        await translator.translate(facturation, from: 'it', to: lang);
    var documentCast =
        await translator.translate(document, from: 'it', to: lang);
    var signoutCast = await translator.translate(signout, from: 'it', to: lang);

    setState(() {
      profile = profileCast.text;
      direction = directionCast.text;
      marketing = marketingCast.text;
      facturation = facturationCast.text;
      document = documentCast.text;
      signout = signoutCast.text;
    });

    return false;
  }
  @override
  void initState() {
    super.initState();
    getTranslations(currentUser.value.default_language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(
        pageActually: "",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  BackButton(),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(children: [
              Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(currentUser.value.image != '' ? "$baseUrl/${currentUser.value.image}" : ''),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 10.0,
                              spreadRadius: 2.0)
                        ]),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${currentUser.value.name} ${currentUser.value.lastname}",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(33, 45, 82, 1)),
                  ),
                  Text(
                    currentUser.value.email,
                    style: TextStyle(
                        fontSize: 17, color: Color.fromARGB(255, 86, 87, 93)),
                  )
                ],
              ),
            ]),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color.fromARGB(0, 244, 245, 246),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InlineCard(
                                onPressed: () => Helper.nextScreen(
                                    context, ProfileConfiguration()),
                                iconFirst: Ionicons.person_outline,
                                text: profile,
                                iconFinal: Ionicons.chevron_forward_outline),
                            InlineCard(
                                onPressed: () => Helper.nextScreen(
                                    context, DirectionConfiguration()),
                                iconFirst: Ionicons.home_outline,
                                text: direction,
                                iconFinal: Ionicons.chevron_forward_outline),
                            InlineCard(
                                onPressed: () => Helper.nextScreen(
                                    context, PasswordConfiguration()),
                                iconFirst: Ionicons.lock_closed_outline,
                                text: 'Password',
                                iconFinal: Ionicons.chevron_forward_outline),
                            InlineCard(
                                onPressed: () => Helper.nextScreen(
                                    context, MarketingConfiguration()),
                                iconFirst: Ionicons.megaphone_outline,
                                text: marketing,
                                iconFinal: Ionicons.chevron_forward_outline),
                            InlineCard(
                                onPressed: () => Helper.nextScreen(
                                    context, BillingConfiguration(back: true, scanningManual: true, steps: false,)),
                                iconFirst: Ionicons.reader_outline,
                                text: facturation,
                                iconFinal: Ionicons.chevron_forward_outline),
                            
                            InlineCard(
                                onPressed: () => Helper.nextScreen(
                                    context, DocumentationView()),
                                iconFirst: Ionicons.document_outline,
                                text: document,
                                iconFinal: Ionicons.chevron_forward_outline),
                            InlineCard(
                                onPressed: () => {
                                      DeleteCache.deleteKey('session'),
                                      Helper.nextScreen(context, Login()),
                                      if(currentBooking.value.isNotEmpty){
                                        for (var i = 0;i < currentBooking.value.length;i++){
                                          currentBooking.value.removeAt(i)
                                        }
                                      },
                                      if(currentAllBookings.value.isNotEmpty){
                                        for (var i = 0;i < currentAllBookings.value.length;i++){
                                          currentAllBookings.value.removeAt(i)
                                        }
                                      }
                                    },
                                iconFirst: Ionicons.exit_outline,
                                text: signout,
                                iconFinal: Ionicons.chevron_forward_outline)
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
