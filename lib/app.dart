import 'package:counterswipe/Presentation/pages/counter.dart';
import 'package:counterswipe/Presentation/pages/login.dart';
import 'package:counterswipe/Presentation/pages/register.dart';
import 'package:counterswipe/Presentation/pages/thankyou.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => Register(),
        '/login': (context) => Login(),
        '/counter': (context) => Counter(),
        '/thankyou': (context) => ThankYou(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
