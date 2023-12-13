import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'package:voyage/pages/ajout_modif_contact.page.dart';
import 'package:voyage/services/contact.service.dart';

import '../menu/drawer.widget.dart';
import '../model/contact.model.dart';

class ContactPage extends StatefulWidget {
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactService contactService = ContactService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Contact Page'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FormHelper.submitButton("Ajouter", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AjoutModifContactPage()),
                ).then((value) {
                  setState(() {});
                });
              },
                  borderRadius: 10,
                  btnColor: Colors.teal,
                  borderColor: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            _fetchData(),
          ],
        ));
  }

  _fetchData() {
    return FutureBuilder<List<Contact>>(
      future: contactService.listeContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> contacts) {
        if (contacts.hasData) return _buildDataTable(contacts.data!);
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildDataTable(List<Contact> ListContacts) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListUtils.buildDataTable(context, ["Nom", "Telephone", "Action"],
          ["nom", "tel", ""], false, 0, ListContacts, (Contact c) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AjoutModifContactPage(
              modifMode: true,
              contact: c,
            ),
          ),
        ).then((value) {
          setState(() {});
        });
      }, (Contact c) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("supprimer Contact"),
              content:
                  const Text("Etes vous sur de vouloir supprimer ce contact ?"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FormHelper.submitButton(
                      "oui",
                      () {
                        contactService.supprimerContact(c).then((value) {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        });
                      },
                      width: 100,
                      borderRadius: 5,
                      btnColor: Colors.teal,
                      borderColor: Colors.teal,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    FormHelper.submitButton(
                      "Non",
                      () {
                        Navigator.of(context).pop();
                      },
                      width: 100,
                      borderRadius: 5,
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
          headingRowColor: Colors.teal,
          isScrollable: true,
          columnTextFontSize: 20,
          columnTextBold: false,
          columnSpacing: 50,
          onSort: (columnIndex, columnName, asc) {}),
    );
  }
}
