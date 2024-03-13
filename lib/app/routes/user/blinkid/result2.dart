
// ignore_for_file: prefer_is_empty

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:newhonekapp/app/repository/user.dart';

class BlinkResult extends StatefulWidget {
  final Object objectapi;
  const BlinkResult({super.key, required this.objectapi});

  @override
  createState() => _BlinkResult();
}

class _BlinkResult extends State<BlinkResult> {
  @override
  initState() {
          

    super.initState();
    Timer(Duration(seconds: 3), () async {
      print('1');
        //await scanToDataBase(widget.objectapi);

    });
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: const <
              Widget>[
                
          ])),
    );
  }
}