import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sky_coin/clientPages/information_client.dart';
import 'package:sky_coin/clientPages/client_wallet.dart';
import 'package:sky_coin/clientPages/client_games.dart';
import 'package:sky_coin/clientPages/client_trade.dart';

class ClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Geri tuşuna basıldığında uygulamanın kapatılmasını sağlar
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.pink[800],
          appBar: AppBar(
            automaticallyImplyLeading: false, // Geri butonunu kaldır
            toolbarHeight: 100,
            title: Text(
              'SKYCOIN',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: 'Rowdies',
              ),
            ),
            backgroundColor: Colors.pink[600],
            actions: [
              IconButton(
                icon: Icon(Icons.account_circle_outlined), // Kullanmak istediğiniz icon
                color: Colors.white,
                iconSize: 40,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            InformationClient()), // Navigating to SignIn page
                  );
                },
              ),
            ],
          ),

          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ClientWallet()), // Navigating to SignUp page
                        );
                      },
                      icon: Icon(
                        Icons.currency_lira_outlined,
                        size: 40,
                      ), // Butona ikon ekleme
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.pink[600], // Buton metin rengi
                        minimumSize: Size(432, 100), // Buton boyutları

                        padding: EdgeInsets.symmetric(
                            horizontal: 16), // Buton iç boşlukları
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(0), // Buton köşe yuvarlaklığı
                        ),
                      ),
                      label: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Varlıklarınız için Tıklayın', // Butonun adı
                            style: TextStyle(fontSize: 15, fontFamily: 'Rowdies'),
                          ),
                        ],
                      )),
                  SizedBox(height: 16), // Butonlar arasında boşluk
                  ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.pink[600], // Buton metin rengi
                        minimumSize: Size(432, 100), // Buton boyutları

                        padding: EdgeInsets.symmetric(
                            horizontal: 16), // Buton iç boşlukları
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(0), // Buton köşe yuvarlaklığı
                        ),
                      ),
                      label: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '        Anında alın ve satın', // Butonun altındaki açıklama
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'Rowdies'
                            ),
                          ),
                          SizedBox(height: 24), // Aralarındaki boşluk
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end, // Icon'u sağa hizala
                            children: [
                              Expanded(
                                child: Text(
                                  'Tek tıkla kripto varlığı kolayca dönüştürebilirsiniz.', // Butonun altındaki açıklama
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'Rowdies'
                                  ),
                                ),
                              ),
                              SizedBox(width: 8), // Metin ile icon arasındaki boşluk
                              Icon(
                                Icons.arrow_right_sharp, // Kullanmak istediğiniz icon
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Piyasa hareketleri',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Rowdies', fontSize: 20),
                  ),
                  Container(
                    child: PhotoGrid(),
                    padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0,right:8),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(20.0), // Köşeleri oval yap
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: PersistentBottomNavigationBar(),
        )
    );
  }
}

class PhotoGrid extends StatefulWidget {
  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  final List<String> photoUrls = [
    'https://i.ibb.co/hB1LyQG/TRY-BNM.png',
    'https://i.ibb.co/XCdXqHP/TRY-ANE.png',
    'https://i.ibb.co/qBW9qh7/TRY-CTE.png',
    'https://i.ibb.co/9VZVtXc/TRY-XNJ.png',
    'https://i.ibb.co/QpmdLLF/TRY-FEX.png',
    'https://i.ibb.co/WgdXV8D/TRY-ATM.png',
  ];

  final List<List<double>> ranges = [
    [21.60, 22.60],
    [18.60, 19.60],
    [0.23, 0.28],
    [6.30, 7.10],
    [2.10, 2.50],
    [11.20, 11.60],
  ];

  List<double> randomNumbers = List<double>.filled(6, 0.0);

  @override
  void initState() {
    super.initState();
    _generateRandomNumbers();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _generateRandomNumbers();
      });
    });
  }

  void _generateRandomNumbers() {
    final random = Random();
    for (int i = 0; i < ranges.length; i++) {
      double min = ranges[i][0];
      double max = ranges[i][1];
      randomNumbers[i] = min + random.nextDouble() * (max - min);
    }
  }

  void _onPhotoTap(int index) {

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230, // GridView'in yüksekliği
      width: 300,
      child: GridView.builder(
        itemCount: photoUrls.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          // Metinleri oluştur
          String text =
              'TRY - ${photoUrls[index].split('/').last.split('-').last.split('.')[0]}';

          return GestureDetector(
            onTap: () => _onPhotoTap(index),
            child: GridTile(
              child: Column(
                children: [
                  Expanded(
                    child: Transform.scale(
                      scale: 0.70, // %25 küçültme
                      child: Image.network(
                        photoUrls[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(text,
                          style:TextStyle(
                              color: Colors.blueGrey,
                            fontSize: 8,
                            fontFamily: 'Rowdies'
                          )
                      ),
                      SizedBox(width: 8), // Küçük bir boşluk ekledik
                      Text(
                        '${randomNumbers[index].toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Colors.deepOrange
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PersistentBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(

      color: Colors.pink,
      child: Container(

        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Container'ın köşelerini oval yapar
          color: Colors.pink[800],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ClientPage()), // Navigating to SignIn page
      );
    }
            ),
            IconButton(
              icon: Icon(Icons.gamepad_outlined, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ClientGames()), // Navigating to SignIn page
                );
              },
            ),
            IconButton(

              icon: Icon(Icons.autorenew_rounded, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ClientTrade()), // Navigating to SignIn page
                );
              },

            ),

            IconButton(

              icon: Icon(Icons.wallet, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ClientWallet()), // Navigating to SignUp page
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}