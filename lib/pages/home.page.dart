import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/config/global.params.dart';

import '../menu/drawer.widget.dart';

class HomePage extends StatelessWidget {
final user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),

      appBar: AppBar(title: Text("Page Home")),
      body: Column(
        children: [
          Container(
            padding:EdgeInsets.all(10),
            child: Text("Utlisateur:${user?.email}",style: TextStyle(fontSize: 22),),
          ),
          Center(
              child: Wrap(
                children: [
                  ...(GlobalParams.accueil as List).map((item){
                    return InkWell(
                      child: Ink.image(
                        height: 180,
                        width: 180,
                        image: item['image'], // Utilisez la clé 'image' de chaque élément de la liste accueil
                      ),
                      onTap: () async {
                        if (item['title'] != "Déconnexion") {
                          Navigator.pushNamed(context, item['route']);
                        } else {
                          _Deconnexion(context);
                        }
                      },
                    );
                  }).toList(),


                ],
              )

          ),
        ],
      ),
    );
  }

Future<void> _Deconnexion(context) async {
  FirebaseAuth.instance.signOut();
  Navigator.of(context).pushNamedAndRemoveUntil(
      '/authentification',(Route<dynamic> route)=> false);
}
}