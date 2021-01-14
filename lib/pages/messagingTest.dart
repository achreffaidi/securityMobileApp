import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security/util/messaging/messagingService.dart';

class MessagingUI extends StatefulWidget {
  @override
  _MessagingUIState createState() => _MessagingUIState();
}

class _MessagingUIState extends State<MessagingUI> {

  TextEditingController _controllerId = TextEditingController();
  TextEditingController _controllerMessage= TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if(!Provider.of<MessagingService>(context).initialized){
      Provider.of<MessagingService>(context).initUserName("ghost");
      Provider.of<MessagingService>(context).initChannel("GL4");
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controllerId,
              decoration: InputDecoration(hintText: "Receiver ID"),
            ),
            TextField(
              controller: _controllerMessage,
              decoration: InputDecoration(hintText: "Message"),
            ),
            RaisedButton.icon(onPressed: _sendMessage, icon: Icon(Icons.send), label: Text("Send")),
            Text(Provider.of<MessagingService>(context).messages.toString())

          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    Provider.of<MessagingService>(context,listen: false).sendMessage(_controllerMessage.text.toString(), _controllerId.text.toString());
  }

  @override
  void dispose() {
    Provider.of<MessagingService>(context).disconnect();
    super.dispose();
  }
}
