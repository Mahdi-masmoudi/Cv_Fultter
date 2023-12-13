import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MeteoDetailPage extends StatefulWidget {
  final String ville;

  MeteoDetailPage(this.ville);

  @override
  _MeteoDetailPageState createState() => _MeteoDetailPageState(ville);
}

class _MeteoDetailPageState extends State<MeteoDetailPage> {
  var meteoData;
  final String ville;

  _MeteoDetailPageState(this.ville);

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  void getMeteoData(String ville) {
    print("Méteo de la ville de "+ville);
    String url = "https://api.openweathermap.org/data/2.5/forecast?q=${ville}&appid=6450d2dd5a6c611dbd7833031b984d48";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.meteoData = json.decode(resp.body);
        print(this.meteoData);
      });
    }).catchError((err){
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Page Meteo Details ${widget.ville}'),
        ),
        body: meteoData == null?
        Center(
          child: CircularProgressIndicator(),
        ):
        ListView.builder(
          itemCount: (meteoData == null ? 0 : meteoData['list'].length),
          itemBuilder: (context,index){
            return Card(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            "assets/images/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("${new DateFormat('E-dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt']*1000000))}",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt'] * 1000000))} - ${meteoData['list'][index]['weather'][0]['description']}",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${(meteoData['list'][index]['main']['temp'] - 273.15).toStringAsFixed(1)}°C",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }
}