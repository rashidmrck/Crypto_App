import 'package:flutter/material.dart';

class CryptoHome extends StatefulWidget {
  @override
  _CryptoHomeState createState() => _CryptoHomeState();
}

class _CryptoHomeState extends State<CryptoHome> {
  List currencies;

  @override
  void initState() async {
    currencies = await _getCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto App'),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (BuildContext context, int index) {},
            ),
          )
        ],
      ),
    );
  }

  Future<List> _getCurrencies() async {
    String url = 'https://api.coinmarketcap.com/v1/ticker/?limit=50';
    
  }
}
