import 'package:flutter/material.dart';
import 'package:security/widget/MainList.dart';

class EncodingDecodingUI extends StatefulWidget {
  @override
  _EncodingDecodingUIState createState() => _EncodingDecodingUIState();
}

class _EncodingDecodingUIState extends State<EncodingDecodingUI> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(80, 0, 0, 1),
          title: Text("Encoding"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(80, 0, 0, 1),Color.fromRGBO(20, 0, 0, 1), Color.fromRGBO(15, 0, 0, 1)])),
          child: Center(
            child: Center(
              child: ListBuilder.getCodingDecodingList(context),
            ),
          ),

        )
    );
  }
}
