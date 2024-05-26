import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
String adres='192.168.25.201';
class ClientArrow extends StatefulWidget {
  @override
  State<ClientArrow> createState() => _ClientArrowState();
}

class _ClientArrowState extends State<ClientArrow> {
  int score = 0;
  int target = 0;
  final List<int> primeNumbers = [2, 3, 5, 7, 11];

  @override
  void initState() {
    super.initState();
    generateTarget();
  }

  void generateTarget() {
    int newTarget = 0;
    Random random = Random();
    for (int i = 0; i < primeNumbers.length; i++) {
      newTarget += primeNumbers[i] * random.nextInt(3);
    }
    setState(() {
      target = newTarget;
    });
  }

  void resetGame() {
    setState(() {
      score = 0;
      generateTarget();
    });
  }

  void updateScore(int points) {
    setState(() {
      score += points;
      if (score == target) {
        updateTryValue();
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Kazandınız!'),
            actions: [
              TextButton(
                child: Text('Tekrar Oyna'),
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else if (score > target) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Kaybettiniz!'),
            actions: [
              TextButton(
                child: Text('Tekrar Oyna'),
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
            'Tam 12 den',
          style: TextStyle(
            fontFamily: 'Rowdies',
            color: Colors.white
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Skor: $score',
                style: TextStyle(
                    fontSize: 24,
                  fontFamily: 'Rowdies',
                  color: Colors.red

                )
            ),
            Text(
                'Hedef: $target',
                style: TextStyle(
                    fontSize: 24,
                  fontFamily: 'Rowdies',
                    color: Colors.red
                )
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTapUp: (details) {
                final double x = details.localPosition.dx;
                final double y = details.localPosition.dy;
                final double centerX = MediaQuery.of(context).size.width / 2;
                final double centerY = MediaQuery.of(context).size.width / 2;
                final double dx = x - centerX;
                final double dy = y - centerY;
                final double distance = sqrt(dx * dx + dy * dy);
                for (int i = 0; i < primeNumbers.length; i++) {
                  if (distance <= (i + 1) * 45 && distance > i * 45) { // Changed radius step here
                    updateScore(primeNumbers[primeNumbers.length - 1 - i]);
                    break;
                  }
                }
              },
              child: CustomPaint(
                size: Size(375, 375), // Changed size here
                painter: DartboardPainter(),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: resetGame,
              child: Text('Tahtayı Sıfırla'),
            ),
          ],
        ),
      ),
    );
  }
}

class DartboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final List<int> primeNumbers = [2, 3, 5, 7, 11];
    final List<Color> colors = [Colors.pink, Colors.white];
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radiusStep = size.width / (primeNumbers.length * 1.75); // Changed step factor here

    for (int i = 0; i < primeNumbers.length; i++) {
      final paint = Paint()
        ..color = colors[i % 2]
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
          Offset(centerX, centerY), (primeNumbers.length - i) * radiusStep, paint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '${primeNumbers[i]}',
          style: TextStyle(
            color: colors[(i + 1) % 2],
            fontSize: 20,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(centerX - textPainter.width / 2,
              centerY - (primeNumbers.length - i) * radiusStep + 10));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
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

