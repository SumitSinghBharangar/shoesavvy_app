import 'package:flutter/material.dart';

class KeybordUtil{
  static void hideKeyboard(BuildContext context){
    FocusScopeNode currentfocus = FocusScope.of(context);
    if(!currentfocus.hasPrimaryFocus){
      currentfocus.unfocus();
    }
  }
}