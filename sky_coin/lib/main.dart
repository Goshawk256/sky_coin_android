import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sky_coin/mainPages/sign_up.dart';
import 'package:sky_coin/mainPages/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
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
        automaticallyImplyLeading: false,
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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16), // Butonlar arasında boşluk
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignInPage()), // Navigating to SignIn page
                    );
                  },
                  icon: Icon(
                    Icons.account_circle,
                    size: 60,
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
                        'Giriş Yap', // Butonun adı
                        style: TextStyle(
                          fontSize: 30,
                            fontFamily: 'Rowdies'
                        ),
                      ),
                      SizedBox(height: 4), // Aralarındaki boşluk
                      Text(
                        'Skycoin içerisinde işlem yapabilmek için', // Butonun altındaki açıklama
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                            fontFamily: 'Rowdies'
                        ),
                      ),
                      Text(
                        'giriş yapmalısınız.', // Butonun altındaki açıklama
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                            fontFamily: 'Rowdies'
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 16), // Butonlar arasında boşluk
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignUp()), // Navigating to SignUp page
                    );
                  },
                  icon: Icon(
                    Icons.account_circle_outlined,
                    size: 60,
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
                        'Skycoin içerisinde işlem yapmaya başlayın.', // Butonun altındaki açıklama
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                            fontFamily: 'Rowdies'
                        ),
                      ),
                      SizedBox(height: 24), // Aralarındaki boşluk
                      Text(
                        'Hesap oluştur >', // Butonun altındaki açıklama
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Rowdies'
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 30),
              Text(
                'Piyasa hareketleri',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Rowdies', fontSize: 20),
              ),
              Container(
                child: PhotoGrid(),
                padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(20.0), // Köşeleri oval yap
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 30), // Butonlar arasında boşluk
              Text(
                'Sıkça sorulan sorular',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Rowdies', fontSize: 20),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                child: DropdownButtonSection(),
              )
            ],
          ),
        ),
      ),
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
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignInPage()), // Navigating to SignUp page
    );
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
                        fontFamily: 'Rowdies',
                        fontSize: 9
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

class DropdownButtonSection extends StatefulWidget {
  @override
  _DropdownButtonSectionState createState() => _DropdownButtonSectionState();
}

class _DropdownButtonSectionState extends State<DropdownButtonSection> {
  // List of dropdown button items
  final List<String> _dropdownItems = [
    'Kripto Para Borsası Nedir?',
    'Nasıl Para Kazanabilirim?',
    'Coin İle Nasıl İşlem Yapılır?',
    'Kriptodan Nasıl Kar Edilir?'
  ];

  // List of descriptions for dropdown items
  final List<String> _descriptions = [
    'Yatırımcıların dijital para birimleri gibi varlıklar için kripto para birimleri ve dijital para birimleri ticareti yapmasına olanak tanıyan platformlardır.',
    'Uygulama içi oyunlar sayesinde eğlenerek para kazanabilirsiniz.',
    'Oyunlardan kazandığınız liralar ile coin alıp satabilirsiniz.',
    'Alım satım yaparak kar elde edebilirsiniz.',
  ];

  // This list will track which dropdown is expanded
  final List<bool> _isExpanded = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _dropdownItems.asMap().entries.map((entry) {
        int index = entry.key;
        String item = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded[index] = !_isExpanded[index];
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink),
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item),
                    Icon(
                      _isExpanded[index]
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    ),
                  ],
                ),
              ),
            ),
            if (_isExpanded[index])
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                child: Text(
                  _descriptions[index],
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Rowdies', fontSize: 10),
                ), // Açıklamalar burada görüntüleniyor
              ),
          ],
        );
      }).toList(),
    );
  }
}
