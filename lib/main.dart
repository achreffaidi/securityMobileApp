import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security/pages/messagingTest.dart';
import 'package:security/util/messaging/messagingService.dart';

import 'widget/MainList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MessagingService(),
        ),
      ],
      child: MaterialApp(
        title: 'Security Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Security'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
backgroundColor: Color.fromRGBO(2, 55, 71, 1),
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromRGBO(2, 55, 71, 1),Color.fromRGBO(1, 30, 40, 1), Color.fromRGBO(1, 22, 28, 1)])),
        child: Center(
          child: Center(
            child: ListBuilder.getMainList(context),
          ),
        ),

      )
    );
  }
}
