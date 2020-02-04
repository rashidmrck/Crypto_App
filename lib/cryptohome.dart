import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoHome extends StatefulWidget {
  @override
  _CryptoHomeState createState() => _CryptoHomeState();
}

class _CryptoHomeState extends State<CryptoHome> {
  List _currencies;
  final List<Color> _color = [Colors.black, Colors.indigo, Colors.red];
  @override
  void initState() {
    _getCurrencies();
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
            child: _currencies == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _currencies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map currency = _currencies[index];
                      final Color color = _color[index % _color.length];
                      // print(color);
                      return _getListitemUI(currency, color);
                    },
                  ),
          )
        ],
      ),
    );
  }

  Future<Null> _getCurrencies() async {
    String url = 'https://api.coinmarketcap.com/v1/ticker/?limit=50';
    var response = await http.get(url, headers: {'Accept': 'application/json'});
    // print(response.body);
    setState(() {
      _currencies = jsonDecode(response.body);
    });
  }

  ListTile _getListitemUI(Map currency, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name'][0]),
      ),
      title: Text(
        currency['name'],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubTitleText(
          currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Widget _getSubTitleText(String priceUSD, String change) {
    TextSpan priceTextWidget =
        TextSpan(text: '\$$priceUSD\n', style: TextStyle(color: Colors.black));
    TextSpan percentageChangeWidget;

    if (0 < double.parse(change)) {
      percentageChangeWidget =
          TextSpan(text: change, style: TextStyle(color: Colors.green));
    } else {
      percentageChangeWidget =
          TextSpan(text: change, style: TextStyle(color: Colors.red));
    }

    return RichText(
        text: TextSpan(children: [priceTextWidget, percentageChangeWidget]));
  }
}
