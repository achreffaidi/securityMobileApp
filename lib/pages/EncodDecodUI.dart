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
          backgroundColor: Color.fromRGBO(2, 55, 71, 1),
          title: Text("Encoding"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(2, 55, 71, 1),Color.fromRGBO(1, 30, 40, 1), Color.fromRGBO(1, 22, 28, 1)])),
          child: Center(
            child: Center(
              child: ListBuilder.getCodingDecodingList(context),
            ),
          ),

        )
    );
  }
}
