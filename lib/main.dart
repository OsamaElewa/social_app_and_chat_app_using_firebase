import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:socialapp/layout/social_layout/social_layout.dart';
import 'package:socialapp/modules/login/cubit/login_cubit.dart';
import 'package:socialapp/modules/login/login_screen.dart';
import 'package:socialapp/shared/bloc_observer.dart';
import 'package:socialapp/shared/constants/constants.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';
import 'package:socialapp/shared/social_cubit/social_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SocialCubit()..getUser()..getPosts()..getAllUser(),
          ),
          BlocProvider(create: (context) => SocialLoginCubit(),)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: defaultColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
              actionsIconTheme: IconThemeData(color: Colors.grey,size: 25),
              iconTheme: IconThemeData(color: Colors.black)
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              elevation: 20.0,
              //type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.grey
            ),
          ),
          home: startWidget,
        ));
  }
}
