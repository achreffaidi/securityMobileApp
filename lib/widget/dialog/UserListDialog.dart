import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:security/api/model/users.dart';
import 'package:security/pages/asymmetric/ChatroomUI.dart';
import 'package:security/util/messaging/messagingService.dart';
import 'package:security/util/styling/Text.dart';

import '../ButtonBuilder.dart';
import '../TextInput.dart';

class UserListDialog extends StatelessWidget {
  final void Function(String) callback;
  final List<User> users;
  UserListDialog({
    @required this.callback,
    @required this.users,
  });

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Consts.avatarRadius + Consts.padding,
        bottom: Consts.padding,
        left: Consts.padding,
        right: Consts.padding,
      ),
      margin: EdgeInsets.only(top: Consts.avatarRadius),
      decoration: new BoxDecoration(
        color: Color.fromRGBO(80, 0, 0, 1),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Consts.padding),
        border: Border.all(
          color: Colors.red,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Text(
            "Send Message to",
            style:

            GoogleFonts.alegreyaSansSc(textStyle: TextStyle(color: Colors.red,fontSize: 30))

          ),
          SizedBox(height: 16.0),
          Container(
            height: 300,
            child: ListView.builder(
                itemCount: users.length,
                itemBuilder: itemBuilder),
          )
        ],
      ),
    );
  }


  Widget itemBuilder(BuildContext context, int index) {
    return Container(
      child: ButtonBuilder.buildRaisedButton(context, () {
        callback(users[index].username);
      }, users[index].username,),

    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
