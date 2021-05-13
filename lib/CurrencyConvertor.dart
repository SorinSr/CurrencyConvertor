import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency_converter/Currency.dart';
import 'package:forex/forex.dart';

import 'package:flutter_currency_converter/flutter_currency_converter.dart';



void main() {
  runApp(MyApp());
  getAmounts();
}

int _counter = 2;

final TextEditingController _myController1 = new TextEditingController();
final TextEditingController _myController2 = new TextEditingController();

String _currency = " EUR ";

double _eurCurrencyValue = 4.8;
double _usdCurrencyValue = 4.09;
double _currencyValue =_eurCurrencyValue ; //default value

String _prettyText1 = "RON to EUR :   ";
String _prettyText2 = "EUR to RON :   ";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo First Homework',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        primaryColorDark: Colors.red,
      ),
      themeMode: ThemeMode.dark,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Flutter Demo First Homework",
              style: TextStyle(color: Colors.white))),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.network(
                  "https://i.pinimg.com/originals/de/2f/80/de2f80a06e0405757bc15360c0da52bf.jpg",
                  fit: BoxFit.cover),
              CustomForm()
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content: Text(processingConversion()));
              });
        },
        tooltip: "Convert the money",
        child: Icon(Icons.swap_calls_rounded),
        backgroundColor: Colors.amberAccent,
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({Key key}) : super(key: key);

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  void dispose() {
    _myController1.dispose();
    _myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text("Money convertor : " + _currency,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0))),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: TextField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.deepOrange),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,)
                  ),

                  labelText: "Amount of " + _prettyText1,
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? Colors.amber
                          : Colors.amberAccent)),
              controller: _myController1,
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.deepOrange),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent),
                  ),
                  labelText: "Amount of " + _prettyText2,
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? Colors.amber
                          : Colors.amberAccent)),
              controller: _myController2,
            )),
        ElevatedButton.icon(
            onPressed: currencySwitch,
            icon: Icon(Icons.swap_horizontal_circle),
            label: Text("Change currency"),
            style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                textStyle: TextStyle(fontSize: 16)))
      ],
    );
  }

  void currencySwitch() {
    setState(() {
      if (_counter >= 10) {
        _counter = 2;
      }
      if (_counter.isEven) {
        _currencyValue = _eurCurrencyValue;
        _currency = " EUR ";
        _prettyText1 = "RON to EUR :   ";
        _prettyText2 = "EUR to RON :   ";
      } else {
        _currencyValue = _usdCurrencyValue;
        _currency = " USD ";
        _prettyText1 = "RON to USD :   ";
        _prettyText2 = "USD to RON :   ";
      }
      _counter++;
      print(_counter);
      getAmounts();
    });
  }
}

void getAmounts() async {
  var usdCurrency = await FlutterCurrencyConverter.convert(
      Currency(Currency.USD, amount: 1), Currency(Currency.RON));

  var euroCurrency = await FlutterCurrencyConverter.convert(
      Currency(Currency.EUR, amount: 1), Currency(Currency.RON));

  _eurCurrencyValue=euroCurrency;
  _usdCurrencyValue=usdCurrency;
}


String processingConversion() {
  print(_myController1.text + " " + _myController2.text);
  double ronEur = double.parse(_myController1.text.toString()) / _currencyValue;
  double eurRon = double.parse(_myController2.text.toString()) * _currencyValue;
  String finalResult = _prettyText1 +
      ronEur.toStringAsFixed(3) +
      "\n" +
      _prettyText2 +
      eurRon.toStringAsFixed(3);
  return "Converted sum in " + _currency + ":  \n\n" + finalResult;
}
