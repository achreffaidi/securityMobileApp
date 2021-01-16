import 'package:flutter/material.dart';
import 'package:security/pages/symmetric/ChatroomUI.dart';
import 'package:security/widget/MainList.dart';
import 'package:security/widget/dialog/ChatroomDialog.dart';
import 'package:security/util/Extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AsymmetricUI extends StatefulWidget   {
  @override
  _AsymmetricUIState createState() => _AsymmetricUIState();
}

class _AsymmetricUIState extends State<AsymmetricUI> with RouteAware {

  @override
  void initState() {
    super.initState();
    _checkIfHasKeys();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
  @override
  void didPopNext() {
    _checkIfHasKeys();
  }
  bool hasKeys = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(80, 0, 0, 1),
          title: Text("Symmetric"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(80, 0, 0, 1),Color.fromRGBO(20, 0, 0, 1), Color.fromRGBO(15, 0, 0, 1)])),
          child: Center(
            child: Center(
              child: ListBuilder.getAsymmetricList(context,hasKeys),
            ),
          ),

        )
    );
  }



  void _checkIfHasKeys() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    hasKeys =  preferences.containsKey('publicKey');
    setState(() {
    });
  }
}
