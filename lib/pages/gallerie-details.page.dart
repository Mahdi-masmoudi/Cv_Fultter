import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GallerieDetailPage extends StatefulWidget {
  final String gallerie;

  GallerieDetailPage(this.gallerie);

  @override
  _GallerieDetailPage createState() => _GallerieDetailPage(gallerie);
}

class _GallerieDetailPage extends State<GallerieDetailPage> {
  var gallerieData;
  final String gallerie;
  int currentPage = 1;
  int size = 10;
  int totalPages=1;

  ScrollController _scrollController = new ScrollController();
  List<dynamic> hits = [];

  _GallerieDetailPage(this.gallerie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: totalPages == 0
                ? Text('Pas de Résultats')
                : Text(
                    "${widget.gallerie},Page ${currentPage}/${totalPages}",
                  )),
        body: (gallerieData == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: (gallerieData == null ? 0 : hits.length),
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 55,
                        child: Card(
                          color: Colors.teal,
                          child: Center(
                            child: Text(
                              "${gallerieData['hits'][index]['tags']}",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          // Your image goes here
                          child: Image.network(
                            gallerieData['hits'][index]['webformatURL'],
                            fit: BoxFit
                                .fitWidth,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )));
  }

  @override
  void initState() {
    super.initState();
    getGallerieData(widget.gallerie);
        _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGallerieData(widget.gallerie);
        }
      }
    });
  }
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  void getGallerieData(String gallerie) {
    print(" " + gallerie);
    String url =
        "https://pixabay.com/api/?key=40254219-54b2d0982ab2872453febeeff&q=${gallerie}&page=${currentPage}&per_page=${size}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.gallerieData = json.decode(resp.body);
        hits.addAll(gallerieData['hits']);
        totalPages = (gallerieData['totalHits'] / size).ceil();
        hits = gallerieData['hits'];
      });
    }).catchError((err) {
      print(err);
    });
  }


}
