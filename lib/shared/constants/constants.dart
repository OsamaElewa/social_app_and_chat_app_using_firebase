//CacheHelper.clearData(key: 'token').then((value){
//                   navigateAndFinish(context,LoginScreen());

import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.clearData(key: 'uId').then((value){
    navigateAndFinish(context,LoginScreen());
 });
}
String? uId;

const defaultColor = Colors.blue;