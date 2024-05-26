import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:sky_coin/clientPages/home_client.dart';
import 'package:sky_coin/clientPages/client_arrow.dart';
import 'package:sky_coin/clientPages/client_cards.dart.';
import 'package:sky_coin/clientPages/client_hangsman.dart';

class ClientGames extends StatefulWidget {


  @override
  State<ClientGames> createState() => _ClientGamesState();
}

class _ClientGamesState extends State<ClientGames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OYUNLAR',
              style: TextStyle(
            fontFamily: 'Rowdies'
        ),
        ),
      ),

        body: Column(

          children:<Widget> [
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientArrow()),
                );
              },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.centerLeft,
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink[600], // Buton arka plan rengi
                minimumSize: Size(432, 100), // Buton boyutları
                padding: EdgeInsets.symmetric(horizontal: 16), // Buton iç boşlukları
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Buton köşe yuvarlaklığı
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/images/tam12den.gif', // Eklemek istediğiniz fotoğrafın yolu
                    width: 60, // Fotoğraf genişliği
                    height: 60, // Fotoğraf yüksekliği
                  ),
                  SizedBox(width: 16), // Fotoğraf ile metin arasındaki boşluk
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tam 12 den', // Butonun adı
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Rowdies',
                        ),
                      ),
                      SizedBox(height: 4), // Metinler arasındaki boşluk
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientCards()),
                );
              },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.centerLeft,
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink[600], // Buton arka plan rengi
                minimumSize: Size(432, 100), // Buton boyutları
                padding: EdgeInsets.symmetric(horizontal: 16), // Buton iç boşlukları
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Buton köşe yuvarlaklığı
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/images/cards.gif', // Eklemek istediğiniz fotoğrafın yolu
                    width: 60, // Fotoğraf genişliği
                    height: 60, // Fotoğraf yüksekliği
                  ),
                  SizedBox(width: 16), // Fotoğraf ile metin arasındaki boşluk
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hafıza Kartı', // Butonun adı
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Rowdies',
                        ),
                      ),
                      SizedBox(height: 4), // Metinler arasındaki boşluk
                    ],
                  ),
                ],
              ),

            ),
            SizedBox(height: 30),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClientHangsman()),
          );
        },
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          foregroundColor: Colors.white,
          backgroundColor: Colors.pink[600], // Buton arka plan rengi
          minimumSize: Size(432, 100), // Buton boyutları
          padding: EdgeInsets.symmetric(horizontal: 16), // Buton iç boşlukları
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Buton köşe yuvarlaklığı
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/images/hangsman.gif', // Eklemek istediğiniz fotoğrafın yolu
              width: 60, // Fotoğraf genişliği
              height: 60, // Fotoğraf yüksekliği
            ),
            SizedBox(width: 16), // Fotoğraf ile metin arasındaki boşluk
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adam Asmaca', // Butonun adı
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Rowdies',
                  ),
                ),
                SizedBox(height: 4), // Metinler arasındaki boşluk
              ],
            ),

          ],
        ),


      ),
            SizedBox(height: 60,),
            Container(
              padding: EdgeInsets.fromLTRB(10, 90, 10, 5),
              child: Column(

                children: [
                  Text(
                      'Önemli Bilgi:Kazandığınız her oyun hesabınıza 10 Türk lirası olarak yansıtılacaktır. ',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Rowdies'

                    ),
                  ),
                ],
              ),
            )
          ],

        ),
        bottomNavigationBar: PersistentBottomNavigationBar()
    );
  }
}
