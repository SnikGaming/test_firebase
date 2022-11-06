import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _controller,
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
    );
  }

  Future createUser({String? name}) async {
    final docUser = FirebaseFirestore.instance.collection("users");
  }
}
