// ignore_for_file: file_names

import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/app/hooks/user.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    verifySession(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(child: SizedBox()),
            SizedBox(
              height: 95.0,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: const [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Image(
                      semanticLabel: "assets/icon/icon.png",
                      image: AssetImage("assets/icon/icon.png"),
                      width: 80,
                      height: 88,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
