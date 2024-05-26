import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sky_coin/clientPages/home_client.dart';
String adres='192.168.25.201';
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://$adres:3000/login'), // Android Emulator için
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      _showSuccessSnackBar(responseBody['message']); // Başarılı giriş mesajı göster
      // Başarılı girişten sonra belirli bir süre sonra başka bir sayfaya yönlendir
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ClientPage()), // Navigating to SignUp page
        );
      });
    } else {
      final responseBody = json.decode(response.body);
      _showErrorDialog(responseBody['message']); // Hata mesajını göster
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Snackbar'ın gösterilme süresi
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hata"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[400],
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text(
            'Giriş Yap',
                style: TextStyle(
            color: Colors.white,
                  fontFamily: 'Rowdies'
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
        
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 40,),
              Text(
                'Skycoin, yarının dünyası...',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Rowdies',
                  color: Colors.white
                ),
        
        
              ),
              SizedBox(height: 40,),
              Text(
                  'Skycoin de işlem yapabilmek için lütfen giriş yapın.',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Rowdies',
        
                ),
        
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-posta',
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _signIn,
                child: Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


