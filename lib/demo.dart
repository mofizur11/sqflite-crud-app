import 'package:flutter/material.dart';
import 'package:sqflite_crud/add_contacts.dart';
import 'package:sqflite_crud/contact.dart';
import 'package:sqflite_crud/db_helper.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local DB')),
      body: FutureBuilder<List<Contact>>(
          future: DBHelper.readContact(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Loading ......')
                  ],
                ),
              );
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text('Vai data nai '),
                  )
                : ListView(
                    children: snapshot.data!.map((contacts) {
                      return Center(
                        child: Card(
                            elevation: 10,
                            child: ListTile(
                              title: Text('${contacts.name}'),
                              subtitle: Text('${contacts.contact}'),
                            )),
                      );
                    }).toList(),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddContact()));

          if (refresh) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
