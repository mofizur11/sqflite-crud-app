import 'package:flutter/material.dart';
import 'package:sqflite_crud/add_contact.dart';
import 'package:sqflite_crud/contacts.dart';
import 'package:sqflite_crud/helper.dart';


class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter SQLite'),
        centerTitle: true,
      ),
      //add Future Builder to get contacts
      body: FutureBuilder<List<Contact>>(
        future: DBHelper.readContacts(), //read contacts list here
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          //if snapshot has no data yet
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
          //if snapshot return empty [], show text
          //else show contact list
          return snapshot.data!.isEmpty
              ? const Center(
                  child: Text('No Contact in List yet!'),
                )
              : ListView(
                  children: snapshot.data!.map((contacts) {
                    return Center(
                      child: ListTile(
                        title: Text(contacts.name),
                        subtitle: Text(contacts.contact),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await DBHelper.deleteContacts(contacts.id!);
                            setState(() {
                              //rebuild widget after delete
                            });
                          },
                        ),
                        onTap: () async {
                          //tap on ListTile, for update
                          final refresh = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => AddContacts(
                                        contact: Contact(
                                          id: contacts.id,
                                          name: contacts.name,
                                          contact: contacts.contact,
                                        ),
                                      )));

                          if (refresh) {
                            setState(() {
                              //if return true, rebuild whole widget
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddContacts()));

          if (refresh) {
            setState(() {
              //if return true, rebuild whole widget
            });
          }
        },
      ),
    );
  }
}
