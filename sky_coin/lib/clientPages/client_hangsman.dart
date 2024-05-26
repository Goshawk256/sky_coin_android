import 'dart:async';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
String adres='192.168.25.201';
class ClientHangsman extends StatefulWidget {
  @override
  State<ClientHangsman> createState() => _ClientHangsmanState();
}

class _ClientHangsmanState extends State<ClientHangsman> {
  List<Map<String, String>> kelimeler = [
    {"word": "GITAR", "hint": "Telli bir müzik aleti"},
    {"word": "OKSIJEN", "hint": "Yaşam için gerekli renksiz, kokusuz bir gaz"},
    {"word": "DAG", "hint": "Dik yamaçlı tepesi yuvarlak veya sivri olan kaya kütlesi"},
    {"word": "ASTRONOMI", "hint": "Gök cisimlerinin uzaydaki durumlarını, hareketlerini, fiziksel ve kimyasal yapılarını inceleyen bilim dalı"},
    {"word": "FUTBOL", "hint": "Popüler bir spor"},
    {"word": "CIKOLATA", "hint": "Kakao çekirdeklerinden yapılan tatlı bir ziyafet"},
    {"word": "KELEBEK", "hint": "Renkli kanatlı ve ince gövdeli bir böcek"},
    {"word": "KAMERA", "hint": "Görüntüleri veya videoları çekmek ve kaydetmek için kullanılan bir cihaz"},
    {"word": "ELMAS", "hint": "Parlaklığı ve sertliği ile bilinen değerli bir taş"},
    {"word": "MACERA", "hint": "Heyecan verici veya cüretkar bir deneyim"},
    {"word": "BISIKLET", "hint": "İki tekerlekli, insan gücüyle çalışan bir araç."},
    {"word": "GALAKSI", "hint": "A vast system of stars, gas, and dust held together by gravity"},
    {"word": "ORKESTRA", "hint": "Çeşitli enstrümanlar çalan büyük bir müzisyen topluluğu"},
    {"word": "YANARDAG", "hint": "Lav, kaya parçaları, sıcak buhar ve gazın dışarı atıldığı bir hava deliği olan bir dağ veya tepe"},
    {"word": "ROMAN", "hint": "Tipik olarak karmaşık bir olay örgüsü ve karakterler içeren uzun bir kurgu eseri"},
    {"word": "HEYKEL", "hint": "Malzemelerin şekillendirilmesi veya birleştirilmesiyle oluşturulan üç boyutlu bir sanat formu"},
    {"word": "SELALE", "hint": "Büyük çağlayan"},
    {"word": "TEKNOLOJI", "hint": "Bilimsel bilginin pratik amaçlar için uygulanması"},
  ];
  late String selectedWord;
  late List<String> letters;
  late String hint;
  late List<String> keyboard;
  late List<bool> letterFound;
  int wrongAttempts = 0; // Yanlış denemeler sayısı

  @override
  void initState() {
    super.initState();
    startNewGame(); // Yeni oyunu başlat
  }

  void startNewGame() {
    selectRandomWord();
    generateKeyboard();
    initializeLetterFoundList();
    resetHangsmanImage();
    wrongAttempts = 0;
  }

  void selectRandomWord() {
    final random = Random();
    final randomIndex = random.nextInt(kelimeler.length);
    final selectedWordMap = kelimeler[randomIndex];
    selectedWord = selectedWordMap['word']!;
    hint = selectedWordMap['hint']!;
    letters = selectedWord.split('');
  }

  void generateKeyboard() {
    keyboard = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  }

  void initializeLetterFoundList() {
    letterFound = List.generate(letters.length, (index) => false);
  }

  void resetHangsmanImage() {
    setState(() {
      SvgPicture.asset(
        'assets/images/hangsman-0.svg',
        width: 150,
        height: 150,
      );
    });
  }

  void checkLetter(String letter) {
    setState(() {
      bool letterFoundInWord = false;
      for (int i = 0; i < letters.length; i++) {
        if (letters[i] == letter) {
          letterFoundInWord = true;
          letterFound[i] = true;
        }
      }
      if (!letterFoundInWord) {
        wrongAttempts++;
        if (wrongAttempts >= 6) {
          endGame();
        }
      }
      if (letterFound.every((element) => element)) {
        // Tüm harfler doğru bilindiğinde oyunu kazandık
        showWinMessage();
        updateTryValue();
      }
    });
  }

  void endGame() {
    // Oyunu sıfırla
    startNewGame();
  }

  void showWinMessage() {
    // Kazanma mesajı göster
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tebrikler!"),
          content: Text("Tebrikler, oyunu kazandınız! Yeni bir oyun başlatmak ister misiniz?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startNewGame();
              },
              child: Text("Evet"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Hayır"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
            'Adam Asmaca',
                style: TextStyle(
            fontFamily: 'Rowdies',
            color: Colors.white,
        ),
        ),

      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          SvgPicture.asset(
            'assets/images/hangsman-$wrongAttempts.svg',
            width: 150,
            height: 150,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              hint,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                fontFamily: 'Rowdies'

              ),
            ),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: letters.length,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: letters.length,
            itemBuilder: (context, index) => Container(
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: Text(
                letterFound[index] ? letters[index] : '_',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: keyboard.length,
            itemBuilder: (context, index) => ElevatedButton(

              onPressed: () {
                checkLetter(keyboard[index]);
              },
              child: Text(
                keyboard[index],
                textAlign: TextAlign.start, // Metni ortalamak için
                style: TextStyle(color: Colors.white), // Metnin rengini beyaz yapmak için
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink, // Butonun arka plan rengini değiştirmek için (isteğe bağlı)
                textStyle: TextStyle(fontSize: 10), // Metnin boyutunu değiştirmek için (isteğe bağlı)

              ),
            ),
          ),
        ],
      ),
    );
  }
}

void updateTryValue() {
  http.post(Uri.parse('http://$adres:3000/updateTryValue'))
      .then((response) {
    if (response.statusCode == 200) {
      print('TRY değeri başarıyla güncellendi');
    } else {
      print('TRY değeri güncellenirken bir hata oluştu');
    }
  })
      .catchError((error) {
    print('TRY değeri güncellenirken bir hata oluştu: $error');
  });
}
