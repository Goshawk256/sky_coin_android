import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sky_coin/main.dart';
String adres='192.168.25.201';
class InformationClient extends StatefulWidget {
  @override
  _InformationClientState createState() => _InformationClientState();
}

class _InformationClientState extends State<InformationClient> {
  String appBarTitle = '';
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }


  Future<void> fetchUserInfo() async {
    final response = await http.get(Uri.parse('http://$adres:3000/userinfo'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      setState(() {
        appBarTitle = '${body['uye_adi']} ${body['uye_soyadi']}';
        userInfo = body;
      });
    } else {
      throw Exception('Failed to load user info');
    }
  }

  Future<void> fetchAllInfo() async {
    final response = await http.get(Uri.parse('http://$adres:3000/allinfo'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      _showInfoDialog(body);
    } else {
      throw Exception('Failed to load all user info');
    }
  }

  Future<void> _updatePassword(String newPassword) async {
    final response = await http.post(
      Uri.parse('http://$adres:3000/updatepassword'),
      body: json.encode({'newPassword': newPassword}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Şifre güncellendi'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Şifre güncelleme başarısız oldu'),
        ),
      );
    }
  }
  Future<void> _logout() async {
    final response = await http.post(
      Uri.parse('http://$adres:3000/logout'),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Oturum kapatıldı'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Oturum kapatma başarısız oldu'),
        ),
      );
    }
  }


  void _showInfoDialog(Map<String, dynamic> info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hesap Bilgileri'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Adı: ${info['uye_adi']}'),
                Text('Soyadı: ${info['uye_soyadi']}'),
                Text('Telefon Numarası: ${info['uye_telno']}'),
                Text('E-Posta: ${info['uye_eposta']}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  void _showPasswordUpdateDialog() {
    String newPassword = '';
    String confirmPassword = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Şifre Güncelleme'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    newPassword = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Yeni Şifre',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Yeni Şifre Tekrar',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                if (newPassword == confirmPassword) {
                  _updatePassword(newPassword);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Şifreler eşleşmiyor'),
                    ),
                  );
                }
              },
              child: Text('Güncelle'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[600],
        appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
            appBarTitle,
          style: TextStyle(
            color: Colors.white,
                fontFamily: 'Rowdies'
          ),
        ),
    ),
    body: SingleChildScrollView(
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    ElevatedButton.icon(
    onPressed: () {
    fetchAllInfo();
    },
    icon: Icon(
    Icons.info,
    size: 30,
    ),
    style: ElevatedButton.styleFrom(
    alignment: Alignment.centerLeft,
    foregroundColor: Colors.white,
    backgroundColor: Colors.pink[600],
    minimumSize: Size(432, 100),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0),
    ),
    ),
    label: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Hesap Bilgileri',
    style: TextStyle(
    fontSize: 20,
    fontFamily: 'Rowdies',
    ),
    ),
    ],
    ),
    ),
    ElevatedButton.icon(
    onPressed: () {
    _showPasswordUpdateDialog();
    },
    icon: Icon(
    Icons.update,
    size: 30,
    ),
    style: ElevatedButton.styleFrom(
    alignment: Alignment.centerLeft,
    foregroundColor: Colors.white,
    backgroundColor: Colors.pink[600],
    minimumSize: Size(432, 100),
    padding: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
      label: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Şifre Güncelleme',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: 'Rowdies',
            ),
          ),
        ],
      ),
    ),
      ElevatedButton.icon(
        onPressed: () {
          _logout();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()), // Navigating to SignUp page
          );
        },
        icon: Icon(
          Icons.logout,
          size: 30,
        ),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          foregroundColor: Colors.white,
          backgroundColor: Colors.pink[600],
          minimumSize: Size(432, 100),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        label: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Çıkış',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'Rowdies',
              ),
            ),
          ],
        ),
      ),

      SizedBox(height: 200),
      Column(
        children: [
          Text(
            'SKYCOIN',
            style: TextStyle(
              fontSize: 50,
              color: Colors.white,
              fontFamily: 'Rowdies',
            ),
          ),
        ],
      ),
    ],
    ),
    ),
    ),
    );
  }
}

