import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReadUserPage extends StatefulWidget {
  const ReadUserPage({super.key});

  @override
  State<ReadUserPage> createState() => _ReadUserPageState();
}

class _ReadUserPageState extends State<ReadUserPage> {
  final user_firebase = FirebaseFirestore.instance.collection('users');
  final _namecontroller = TextEditingController();
  final _birthdaycontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _namecontroller.dispose();
    _birthdaycontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: user_firebase.snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                final DocumentSnapshot doc = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                      title: Text(doc['name']),
                      subtitle: Text(doc['birthday']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  _update(doc);
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  _delete(doc);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      )),
                );
              }),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error data"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  Future<void> _delete([DocumentSnapshot? documentSnapshot]) async {
    await user_firebase.doc(documentSnapshot!.id).delete();
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    _namecontroller.clear();
    _birthdaycontroller.clear();
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                TextField(
                  controller: _namecontroller,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _birthdaycontroller,
                  decoration: InputDecoration(labelText: 'Birthday'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = _namecontroller.text;
                      final String birthday = _birthdaycontroller.text;
                      await user_firebase
                          .add({"name": name, "birthday": birthday});
                      _namecontroller.clear();
                      _birthdaycontroller.clear();
                    },
                    child: Icon(Icons.add))
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _namecontroller.text = documentSnapshot['name'];
      _birthdaycontroller.text = documentSnapshot['birthday'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                TextField(
                  controller: _namecontroller,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _birthdaycontroller,
                  decoration: InputDecoration(labelText: 'Birthday'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = _namecontroller.text;
                      final String birthday = _birthdaycontroller.text;
                      await user_firebase
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "birthday": birthday});
                      _namecontroller.clear();
                      _birthdaycontroller.clear();
                    },
                    child: Icon(Icons.save))
              ],
            ),
          );
        });
  }
}
