import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];



const apiKey= "6B3EB4AB-8173-4899-8A6A-E7170DF026B5";

class CoinData {

  Future<dynamic> getData( {String cryptoCoinCurrency, String selectedOption}) async{
    String url = "https://rest.coinapi.io/v1/exchangerate/$cryptoCoinCurrency/$selectedOption?apikey=$apiKey";
    var x = await http.get(url);
    if(x.statusCode == 200){
      var data = jsonDecode(x.body);
      return data['rate'].toInt();
    }
  }
}
