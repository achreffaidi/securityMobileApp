
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

extension ExtendedState on State{

  toast(String text){
    Toast.show(text, this.context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

}