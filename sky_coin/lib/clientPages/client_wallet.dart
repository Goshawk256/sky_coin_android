import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String adres = '192.168.25.201';

class ClientWallet extends StatefulWidget {
  @override
  State<ClientWallet> createState() => _ClientWalletState();
}

class _ClientWalletState extends State<ClientWallet> {
  Map<String, dynamic>? userAssets;

  @override
  void initState() {
    super.initState();
    fetchUserAssets();
  }

  Future<void> fetchUserAssets() async {
    final response = await http.get(Uri.parse('http://$adres:3000/getActiveUserAssets'));

    if (response.statusCode == 200) {
      setState(() {
        userAssets = json.decode(response.body);
      });
    } else {
      // Hata durumunu ele alın
      print('Failed to load assets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'VARLIKLAR',
          style: TextStyle(
            fontFamily: 'Rowdies',
            color: Colors.white
          ),
        ),
      ),
      body: userAssets == null
          ? Center(child: CircularProgressIndicator()) // Veriler yüklenirken gösterilecek
          : Padding(
        padding: const EdgeInsets.fromLTRB(16,140,16,10),
        child: Center(
          child: Container(

            child: Column(


              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                _buildAssetContainer('TRY: ${userAssets!['try']}',Colors.pink),
                SizedBox(height: 15,width: 15),
                Row(



                  children: [

                    _buildAssetContainer('BNM: ${userAssets!['bnm']}',Colors.pink),
                    SizedBox(width: 10),
                    _buildAssetContainer('ANE: ${userAssets!['ane']}',Colors.pink),

                  ],
                ),

                SizedBox(height: 15),
                Row(
                  children: [
                    _buildAssetContainer('XNJ: ${userAssets!['xnj']}',Colors.pink),
                    SizedBox(width: 10),
                    _buildAssetContainer('CTE: ${userAssets!['cte']}',Colors.pink),

                  ],
                ),

                SizedBox(height: 15),
                Row(
                  children: [
                    _buildAssetContainer('FEX: ${userAssets!['fex']}',Colors.pink),
                    SizedBox(width: 10),
                    _buildAssetContainer('ATM: ${userAssets!['atm']}',Colors.pink),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    child: Text(
                      'SKYCOİN',
                      style: TextStyle(
                        fontFamily: 'Rowdies',
                        color: Colors.white,
                        fontSize: 40
                      ),

                    ),

                  )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


Widget _buildAssetContainer(String asset, Color color) {
  return Container(
    padding: EdgeInsets.fromLTRB(5,10,40,10),

    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: Colors.white60),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      asset,
      style: TextStyle(
          fontSize: 18,
          fontFamily: 'Rowdies',
          color: Colors.white60
      ),
    ),
  );
}
}