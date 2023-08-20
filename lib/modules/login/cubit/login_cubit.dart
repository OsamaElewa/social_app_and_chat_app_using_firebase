
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';


class SocialLoginCubit extends Cubit<SocialLoginState>{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  IconData suffix=Icons.visibility_outlined;
  bool isPasswordShown=false;

  void changeVisibility(){
    suffix= isPasswordShown? Icons.visibility_outlined: Icons.visibility_off;
    isPasswordShown= !isPasswordShown;
    emit(SocialLoginVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
}){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
}
}