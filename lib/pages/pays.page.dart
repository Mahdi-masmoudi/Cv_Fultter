import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/pages/pays-details.page.dart';

import '../menu/drawer.widget.dart';

class PaysPage  extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_pays = new TextEditingController();

  void _onGetMeteoDetails(BuildContext context){
    String v=txt_pays.text;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=>PaysDetailPage(v)
        )
    );
    txt_pays.text="";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),

      appBar: AppBar(title: Text("Page Pays")),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_pays,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on_sharp),
                  hintText: "Pays",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1))),
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                _onGetMeteoDetails(context);
              },
              child: Text('Chercher', style: TextStyle(fontSize: 22)),
            ),
          ),

        ],
      ),
    );}


}