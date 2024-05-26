import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
String adres='192.168.25.201';
class ClientCards extends StatefulWidget {
  @override
  _ClientCardsState createState() => _ClientCardsState();
}

class _ClientCardsState extends State<ClientCards> {
  List<String> emojis = [
    "😂", "😂", "❤️", "❤️", "😍", "😍", "👌", "👌", "💕", "💕", "😁", "😁", "🎶", "🎶", "😜", "😜", "😎", "😎", "✨", "✨"
  ];
  List<String> shuffledEmojis = [];
  List<int> visibleIndexes = [];
  List<String> matchedEmojis = [];

  @override
  void initState() {
    super.initState();
    // Shuffle the emojis list
    shuffledEmojis = List.from(emojis)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          'Hafıza Kartı',
          style: TextStyle(
            fontFamily: 'Rowdies',
            color: Colors.white
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsetsDirectional.only(top: 50),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 4,
        ),
        itemCount: emojis.length,
        itemBuilder: (context, index) {
          return MemoryCard(
            emoji: shuffledEmojis[index],
            onTap: () {
              if (!visibleIndexes.contains(index) && matchedEmojis.length < emojis.length ~/ 2) {
                setState(() {
                  visibleIndexes.add(index);
                });
                if (visibleIndexes.length == 2) {
                  Future.delayed(Duration(milliseconds: 500), () {
                    checkMatch();
                  });
                }
              }
            },
            isVisible: visibleIndexes.contains(index) || matchedEmojis.contains(shuffledEmojis[index]),
          );
        },
      ),
    );
  }

  void checkMatch() {
    if (shuffledEmojis[visibleIndexes[0]] == shuffledEmojis[visibleIndexes[1]]) {
      setState(() {
        matchedEmojis.add(shuffledEmojis[visibleIndexes[0]]);
        visibleIndexes.clear();
      });
      if (matchedEmojis.length == emojis.length ~/ 2) {
        updateTryValue();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                  'Tebrikler!',
                      style: TextStyle(
                  fontFamily: 'Rowdies',
                          color: Colors.red
              ),
              ),
              content: Text(
                  'Kazandınız!',
                style: TextStyle(
                  fontFamily: 'Rowdies',
                      color: Colors.red
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    restartGame();
                  },
                  child: Text('Restart'),
                ),
              ],
            );
          },
        );
      }
    } else {
      setState(() {
        visibleIndexes.removeRange(0, 2);
      });
    }
  }

  void restartGame() {
    setState(() {
      shuffledEmojis = List.from(emojis)..shuffle();
      visibleIndexes.clear();
      matchedEmojis.clear();
    });
  }
}

class MemoryCard extends StatelessWidget {
  final String emoji;
  final VoidCallback onTap;
  final bool isVisible;

  MemoryCard({required this.emoji, required this.onTap, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Visibility(
            visible: isVisible,
            child: Text(
              emoji,
              style: TextStyle(fontSize: 24),
            ),
            replacement: Container(
              color: Colors.pink, // Change this color to match your card back design
              height: 40,
              width: 40,
            ),
          ),
        ),
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