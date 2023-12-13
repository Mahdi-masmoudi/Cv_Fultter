import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaysDetailPage extends StatefulWidget {
  final String pays;

  PaysDetailPage(this.pays);

  @override
  State<PaysDetailPage> createState() => _PaysDetailPageState();
}

class _PaysDetailPageState extends State<PaysDetailPage> {
  var paysData;

  @override
  void initState() {
    super.initState();
    getPaysData(widget.pays);
  }

  void getPaysData(String pays) {
    print("Méteo de la pays de " + pays);
    String url = "https://restcountries.com/v2/name/${pays}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.paysData = json.decode(utf8.decode(resp.bodyBytes))[0];
        print(this.paysData);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Pays Details ${widget.pays}'),
      ),
      body: paysData == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Image.network(
                paysData['flags']['png'],
                width: 250,
                height: 150,
              ),
              SizedBox(height: 10),
              Text("${paysData['name']}", style: TextStyle(fontSize: 25)),
              SizedBox(height: 10),

              Text("${paysData['nativeName']}", style: TextStyle(fontSize: 25)),
              SizedBox(height: 20),
              Text("Administration", style: TextStyle(fontSize: 35, color: Colors.blue)),
              Text("Capital: ${paysData['capital']}", style: TextStyle(fontSize: 25)),
              Text("Language: ${paysData['languages'][0]['name']}", style: TextStyle(fontSize: 25)),
              SizedBox(height: 20),
              Text("Gerographie", style: TextStyle(fontSize: 35, color: Colors.blue)),
              Text("Region: ${paysData['region']}", style: TextStyle(fontSize: 25)),
              Text("Superficie: ${paysData['area']}", style: TextStyle(fontSize: 25)),
              Text("Fuseau Horaire: ${paysData['timezones'][0]}", style: TextStyle(fontSize: 25)),
              SizedBox(height: 20),
              Text("Demographie", style: TextStyle(fontSize: 35, color: Colors.blue)),
              Text("Population: ${paysData['population']}", style: TextStyle(fontSize: 25)),
              // Add more information as needed
            ],
          ),
        ),
      ),
    );
  }
}
