import 'package:flutter/material.dart';
import 'package:sqflite_crud/contact.dart';
import 'package:sqflite_crud/db_helper.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key, this.contact}) : super(key: key);

  final Contact? contact;

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name!;
      _nameController.text = widget.contact!.contact!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('THis is GUlistan')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildTextField(_nameController, 'Name'),
            const SizedBox(
              height: 10,
            ),
            _buildTextField(_contactController, 'Contact'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  await DBHelper.createContact(Contact(
                      name: _nameController.text,
                      contact: _contactController.text));
                },
                child: const Text('Add Contact'))
          ],
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: hint,
          hintText: hint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );
  }
}
