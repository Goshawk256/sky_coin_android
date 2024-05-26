import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
String adres='192.168.25.201';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {

    final String name = _nameController.text;
    final String surname = _surnameController.text;
    final String email = _emailController.text;
    final String phoneNumber = _phoneNumberController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://$adres:3000/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'surname': surname,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print(responseBody['message']); // Konsola kaydolma başarılı mesajını yazdır
      // Başarılı kaydolma işlemlerini burada gerçekleştirin
    } else {
      final responseBody = json.decode(response.body);
      print(responseBody['message']); // Konsola hata mesajını yazdır
      // Hata mesajını gösterin veya gerekli işlemleri yapın
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[400],
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text(
            'Kaydol',
                style: TextStyle(
                  fontFamily: 'Rowdies',
                  color: Colors.white

        ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 40,),
              Text(
                'Geleceğe açılan kapı...',
                style: TextStyle(
                  fontFamily: 'Rowdies',
                  fontSize: 30,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 60,),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Ad',
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _surnameController,
                decoration: InputDecoration(
                  labelText: 'Soyad',
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-posta',
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Telefon Numarası',
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
                onPressed: _signUp,
                child: Text('Kaydol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
