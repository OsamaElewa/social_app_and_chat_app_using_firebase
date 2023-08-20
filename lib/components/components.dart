import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateReplacmentTo(context, Widget) => Navigator.pushReplacement(context, Widget);

void printFullText(String text){
  final pattern=RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;

    case ToastState.ERROR:
      color = Colors.red;
      break;

    case ToastState.WARNING:
      color = Colors.yellowAccent;
      break;
  }
  return color;
}

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[300],
  ),
);
