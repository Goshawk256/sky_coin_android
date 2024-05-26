import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
String adres='192.168.25.201';
class ClientTrade extends StatefulWidget {


  @override
  State<ClientTrade> createState() => _ClientTradeState();
}
class _ClientTradeState extends State<ClientTrade> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedCurrency = 'BNM';
  double _convertedAmount = 0.0;

  double BNMValue = 22;
  double ANEValue = 19;
  double CTEValue = 0.264;
  double XNJValue = 6.987;
  double FEXValue = 2.333;
  double ATMValue = 11.465;

  @override
  void initState() {
    super.initState();
    startUpdatingValues();
  }

  void startUpdatingValues() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        BNMValue = updateValue(BNMValue);
        ANEValue = updateValue(ANEValue);
        CTEValue = updateValue(CTEValue);
        XNJValue = updateValue(XNJValue);
        FEXValue = updateValue(FEXValue);
        ATMValue = updateValue(ATMValue);
      });
    });
  }

  double updateValue(double value) {
    final randomChange = Random().nextDouble() * 2 - 1;
    return value + value * (randomChange / 100);
  }

  Future<void> convertCurrency() async {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      setState(() {
        _convertedAmount = 0.0;
      });
      return;
    }

    double exchangeRate;
    switch (_selectedCurrency) {
      case 'BNM':
        exchangeRate = BNMValue;
        break;
      case 'ANE':
        exchangeRate = ANEValue;
        break;
      case 'CTE':
        exchangeRate = CTEValue;
        break;
      case 'XNJ':
        exchangeRate = XNJValue;
        break;
      case 'FEX':
        exchangeRate = FEXValue;
        break;
      case 'ATM':
        exchangeRate = ATMValue;
        break;
      default:
        exchangeRate = 1;
    }

    final convertedAmount = double.parse((amount * exchangeRate).toStringAsFixed(2));



    final response = await http.post(
      Uri.parse('http://$adres:3000/convertCurrency'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'amount': amount,
        'convertedAmount': convertedAmount,
        'currency': _selectedCurrency,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _convertedAmount = convertedAmount;
      });
    } else {
      final responseBody = json.decode(response.body);
      final errorMessage = responseBody['message'] ?? 'Dönüştürme işlemi başarısız';
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          'SATIŞ İŞLEMLERİ',
          style: TextStyle(
            fontFamily: 'Rowdies',
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Miktar',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue!;
                });
              },
              items: <String>['BNM', 'ANE', 'CTE', 'XNJ', 'FEX', 'ATM']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(

              onPressed: convertCurrency,
              child: Text(
                  'Satın Al',
                style: TextStyle(
                  fontFamily: 'Rowdies',
                  fontSize: 20,
                  color: Colors.red,


                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              _convertedAmount > 0
                  ? 'Sonuç: ${_convertedAmount.toStringAsFixed(2)} $_selectedCurrency'
                  : 'Lütfen geçerli bir miktar girin.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(

                child: ListView(

                  children: [


                    Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(color: Colors.black, width: 2.0), // Kenarlık ayarı
                        borderRadius: BorderRadius.circular(8.0), // Kenarları yuvarlama

                      ),
                      child: Column(
                        children: [
                          buildExchangeRateTile('TRY - ANE', ANEValue),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(color: Colors.black, width: 2.0), // Kenarlık ayarı
                        borderRadius: BorderRadius.circular(8.0), // Kenarları yuvarlama
                      ),
                      child: Column(
                        children: [
                          buildExchangeRateTile('TRY - CTE', CTEValue),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(color: Colors.black, width: 2.0), // Kenarlık ayarı
                        borderRadius: BorderRadius.circular(8.0), // Kenarları yuvarlama
                      ),
                      child: Column(
                        children: [
                          buildExchangeRateTile('TRY - XNJ', XNJValue),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(color: Colors.black, width: 2.0), // Kenarlık ayarı
                        borderRadius: BorderRadius.circular(8.0), // Kenarları yuvarlama
                      ),
                      child: Column(
                        children: [
                          buildExchangeRateTile('TRY - FEX', FEXValue),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(color: Colors.black, width: 2.0), // Kenarlık ayarı
                        borderRadius: BorderRadius.circular(8.0), // Kenarları yuvarlama
                      ),
                      child: Column(
                        children: [
                          buildExchangeRateTile('TRY - ATM', ATMValue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildExchangeRateTile(String title, double value) {
    return ListTile(
      title: Text(title),
      subtitle: Text('1 Türk Lirası = ${value.toStringAsFixed(3)}'),
    );
  }
}