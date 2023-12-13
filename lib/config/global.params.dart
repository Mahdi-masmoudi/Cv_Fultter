import 'package:flutter/material.dart';

import '../notifier/theme.dart';


class GlobalParams  {
  static MonTheme themeActuel=MonTheme();

  static List<Map<String, dynamic>>menus= [
  {"title": "Home", "icon": Icon (Icons.home, color: Colors.teal,), "route":"/home"} ,
  {"title": "Métèo", "icon": Icon (Icons.sunny_snowing, color: Colors.teal,), "route":"/meteo"} ,
  {"title": "Gallerie", "icon": Icon (Icons.photo, color: Colors.teal,), "route":"/gallerie"} ,
  {"title": "Contact", "icon": Icon (Icons.contact_page, color: Colors.teal,), "route":"/contact"} ,
  {"title": "Parametres", "icon": Icon (Icons.settings, color: Colors.teal,), "route":"/parametres"} ,
  {"title": "pays", "icon": Icon (Icons.location_city, color: Colors.teal,), "route":"/Pays"} ,
  {"title": "Déconnexion", "icon": Icon (Icons.logout, color: Colors.teal,), "route":"/login"} ];
  static List<Map<String,dynamic>>accueil=[
    {"title":"Métèo","image":AssetImage('assets/images/meteo.png'),"route":"/meteo"},
    {"title":"Gallerie","image":AssetImage('assets/images/gallerie.png'),"route":"/gallerie"},
    {"title":"pays","image":AssetImage('assets/images/pays.png'),"route":"/Pays"},
    {"title":"Contact","image":AssetImage('assets/images/contact.png'),"route":"/contact"},
    {"title":"Parameters","image":AssetImage('assets/images/parametres.png'),"route":"/parametres"},
    {"title":"Déconnexion","image":AssetImage('assets/images/deconnexion.png'),"route":"/login"},


  ];
}

