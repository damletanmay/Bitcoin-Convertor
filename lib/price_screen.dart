import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int btc;
  int eth;
  int ltc;

  bool isWaiting = true;

  String selectedOption = 'INR';

  @override
  void initState() {
    // this function will be called before rendering the whole page.
    // so we can update ui to display things even before the app is opened.
    updateUI();
    super.initState();
  }
// this will update ui
  void updateUI() async {
    CoinData coinData = CoinData();
    isWaiting = true;
    var dataBtc = await coinData.getData(
        cryptoCoinCurrency: 'BTC', selectedOption: selectedOption);
    var dataEth = await coinData.getData(
        cryptoCoinCurrency: 'ETH', selectedOption: selectedOption);
    var dataLtc = await coinData.getData(
        cryptoCoinCurrency: 'LTC', selectedOption: selectedOption);
    isWaiting = false;
    setState(() {
      btc = dataBtc;
      eth = dataEth;
      ltc = dataLtc;
    });
    print("UI Updated");
  }

  // custom widget for android
  Widget androidDD() {
    List<DropdownMenuItem> myItems = [];
    for (String i in currenciesList) {
      var x = DropdownMenuItem(
        child: Text(i),
        value: i,
      );
      myItems.add(x);
    }
    return DropdownButton(
      value: selectedOption,
      items: myItems,
      onChanged: (value) {
        setState(() {
          selectedOption = value;
          updateUI();
        });
      },
    );
  }
// custom widget for ios
  Widget iosPicker() {
    List<Widget> myItems = [];
    for (String i in currenciesList) {
      var x = Text(i);
      myItems.add(x);
    }

    return CupertinoPicker(
      itemExtent: 40.0,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedOption = currenciesList[value];
          print(selectedOption);
          updateUI();
        });
      },
      children: myItems,
    );
  }

// custom widget which renders the screen where values are displayed.
  List<Widget> giveCrpyto() {
    List<Widget> my_crypto = [];
    for (int i = 0; i < cryptoList.length; i++) {
      var x = Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ${cryptoList[i]} = ${ (i == 0) ? isWaiting? '?' : btc  : (i == 1) ? isWaiting? '?' : eth  : (i == 2) ? isWaiting? '?' : ltc  : '?'} $selectedOption',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
      my_crypto.add(x);
    }
    return my_crypto;
  }

  // build method which combines all the widgets.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: giveCrpyto(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() :  androidDD() ,
          ),
        ],
      ),
    );
  }
}
