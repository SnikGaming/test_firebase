import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_firebase/model.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _name = TextEditingController();
  final _birthday = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _birthday.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD USER"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _name,
              decoration: InputDecoration(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _birthday,
              decoration: InputDecoration(),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final user = User(
                  name: _name.text,
                  birthday: _birthday.text,
                );
                createUser(user: user).then((value) => Navigator.pop(context));
              },
              child: Text("ADD"))
        ],
      ),
    );
  }

  Future createUser({User? user}) async {
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .add({"name": "adadasda", "birthday": "asdadas"})
    //     .then((value) => Navigator.pop(context))
    //     .catchError((e) {
    //       print(e);
    //     });

    final docUser = FirebaseFirestore.instance.collection("users").doc();
    final json = user!.toJson();
    await docUser.set(json);
  }
}
