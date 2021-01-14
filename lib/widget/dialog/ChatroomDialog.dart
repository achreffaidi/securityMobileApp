import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security/util/styling/Text.dart';

import '../TextInput.dart';

class ChatroomDialog extends StatelessWidget {
  final void Function(String,String) callback;
  final State state;

  TextEditingController _room = TextEditingController();
  TextEditingController _pass = TextEditingController();

  ChatroomDialog({
    @required this.callback,
    @required  this.state
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
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Color.fromRGBO(2, 55, 71, 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            border: Border.all(
              color: Colors.blue,
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
                "Enter ChatRoom",
                style:

                GoogleFonts.alegreyaSansSc(textStyle: TextStyle(color: Colors.blue,fontSize: 30))

              ),
              SizedBox(height: 16.0),
              buildCustomInputField(true, "Room",_room, 50,false,true,state),
              buildCustomInputField(true, "Key",_pass, 50,false,true,state),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    if(_room.text.trim().isNotEmpty&&_pass.text.trim().isNotEmpty){
                      callback(_room.text,_pass.text);
                      Navigator.of(context).pop();// To close the dialog
                    }
                  },
                  child: Text("Enter",style: buttonStyle,),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }


}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
