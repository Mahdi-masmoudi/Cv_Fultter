import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:voyage/menu/drawer.widget.dart';
String mode="Jour";
FirebaseDatabase fire=FirebaseDatabase.instance;
DatabaseReference ref=fire.ref();
class ParametresPage extends StatefulWidget {
  @override
  State<ParametresPage> createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Page Paramètres'),
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('mode',style: Theme.of(context).textTheme.headline3,),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Jour'),
                  leading: Radio<String>(
                    value: "Jour",
                    groupValue: mode,
                    onChanged: (value){
                      setState(() {
                        mode=value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Nuit'),
                  leading: Radio<String>(
                    value: "Nuit",
                    groupValue: mode,
                    onChanged: (value){
                      setState(() {
                        mode=value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: (){
                    _onSavedMode();
                  },
                  child: Text('Enregistrer',style: TextStyle(fontSize: 22))),
            ),
          ],
        )
    );
  }
  _onSavedMode() async{
    await ref.set({"mode":mode});
    print("mode change");
    Navigator.pop(context);
  }
}