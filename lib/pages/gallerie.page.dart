import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../menu/drawer.widget.dart';
import 'gallerie-details.page.dart';

class GalleriePage  extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_Gallerie = new TextEditingController();

  void _onGetGallerieDetails(BuildContext context){
    String v=txt_Gallerie.text;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=>GallerieDetailPage(v)
        )
    );
    txt_Gallerie.text="";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Page Gallerie'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_Gallerie,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  hintText: "",
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
                _onGetGallerieDetails(context);
              },
              child: Text('Chercher', style: TextStyle(fontSize: 22)),
            ),
          ),

        ],
      ),
    );}
}
