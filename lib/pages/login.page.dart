import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/pages/inscription.page.dart';

class LoginPage extends StatelessWidget {
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page Login")),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Identifiant",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1))),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_password,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.start),
                  hintText: "Mot de passe",
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
                _onAuthentifier(context);
              },
              child: Text('Conecxion', style: TextStyle(fontSize: 22)),
            ),
          ),
          TextButton(
            child: Text("Inscription", style: TextStyle(fontSize: 22)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/Inscription');
            },
          )
        ],
      ),
    );
  }

  Future<void> _onAuthentifier(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: txt_login.text.trim(),
          password: txt_password.text.trim()
      );
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      SnackBar snackBar = SnackBar(content: Text(""));
      if (e.code == 'user-not-found') {
        snackBar = SnackBar(
          content: Text('utilisateur inexistant'),
        );
      } else if (e.code == 'wrong-password') {
        snackBar = SnackBar(
          content: Text('Verifier votre mot de passe'),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
