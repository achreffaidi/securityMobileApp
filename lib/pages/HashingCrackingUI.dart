import 'package:flutter/material.dart';
import 'package:security/widget/MainList.dart';

class HashingCrackingUI extends StatefulWidget {
  @override
  _HashingCrackingUIState createState() => _HashingCrackingUIState();
}

class _HashingCrackingUIState extends State<HashingCrackingUI> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(2, 55, 71, 1),
          title: Text("Hashing"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(2, 55, 71, 1),Color.fromRGBO(1, 30, 40, 1), Color.fromRGBO(1, 22, 28, 1)])),
          child: Center(
            child: Center(
              child: ListBuilder.getHashingList(context),
            ),
          ),

        )
    );
  }
}
