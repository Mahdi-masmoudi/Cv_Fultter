import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../menu/drawer.widget.dart';
import 'meteo-details.page.dart';

class MeteoPage  extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_ville = new TextEditingController();

  void _onGetMeteoDetails(BuildContext context){
    String v=txt_ville.text;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=>MeteoDetailPage(v)
        )
    );
    txt_ville.text="";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),

      appBar: AppBar(title: Text("Page Meteo")),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_ville,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  hintText: "Ville",
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
