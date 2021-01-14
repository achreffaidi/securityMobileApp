import 'package:flutter/material.dart';
import 'package:security/widget/MainList.dart';
import 'package:security/widget/dialog/ChatroomDialog.dart';
import 'package:security/util/Extensions.dart';

class SymmetricUI extends StatefulWidget {
  @override
  _SymmetricUIState createState() => _SymmetricUIState();
}

class _SymmetricUIState extends State<SymmetricUI> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(2, 55, 71, 1),
          title: Text("Symmetric"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(2, 55, 71, 1),Color.fromRGBO(1, 30, 40, 1), Color.fromRGBO(1, 22, 28, 1)])),
          child: Center(
            child: Center(
              child: ListBuilder.getSymmetricList(context,showPopUp),
            ),
          ),

        )
    );
  }

  Null showPopUp(){
    showDialog(
      context: context,
      builder: (BuildContext context) => ChatroomDialog(
        callback: (room,key){
          toast(room+" - "+key);
        },
        state: this,
      ),
    );
  }
}
