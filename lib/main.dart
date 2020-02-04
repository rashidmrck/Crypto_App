import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cryptoapp/cryptohome.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: defaultTargetPlatform == TargetPlatform.iOS ? Colors.amber : null
      ),
      home: CryptoHome(),
    );
  }
}