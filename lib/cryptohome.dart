import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoHome extends StatefulWidget {
  @override
  _CryptoHomeState createState() => _CryptoHomeState();
}

class _CryptoHomeState extends State<CryptoHome> {
  List currencies;

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
            child: currencies == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: currencies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(currencies[index]['name']),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  Future<Null> _getCurrencies() async {
    String url = 'https://api.coinmarketcap.com/v1/ticker/?limit=50';
    var response = await http.post(url,headers: {'Accept': 'application/json'});
    print(response.body);
    setState(() {
      currencies = jsonDecode(response.body);
    });
  }
}
