import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security/pages/Settings.dart';
import 'package:security/pages/messagingTest.dart';
import 'package:security/util/messaging/messagingService.dart';
import 'package:flutter/services.dart';
import 'widget/MainList.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MessagingService(),
        ),
      ],
      child: MaterialApp(
        title: 'Crypto',
        navigatorObservers: [routeObserver],
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyHomePage(title: 'Crypto'),
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
backgroundColor: Color.fromRGBO(80, 0, 0, 1),
        title: Text(widget.title),
        actions: [
          IconButton(icon: Icon(Icons.settings,color: Colors.white,), onPressed: _navigateToSettings)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromRGBO(80, 0, 0, 1),Color.fromRGBO(20, 0, 0, 1), Color.fromRGBO(15, 0, 0, 1)])),
        child: Center(
          child: Center(
            child: ListBuilder.getMainList(context),
          ),
        ),

      )
    );
  }

  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsUI()),
    );
  }
}
