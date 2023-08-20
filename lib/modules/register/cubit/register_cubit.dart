import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';

import 'package:socialapp/modules/register/cubit/register_state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = false;

  void changeVisibility() {
    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off;
    isPasswordShown = !isPasswordShown;
    emit(SocialRegisterVisibilityState());
  }

  void registerData(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
        password: password,
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String uId,
  }) {
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      password: password,
      image: 'https://img.freepik.com/free-photo/young-man-student-with-notebooks-showing'
          '-thumb-up-approval-smiling-satisfied-blue-studio-background_1258-65597.'
          'jpg?w=1060&t=st=1682528316~exp=1682528916'
          '~hmac=bec6c8d3601f25f3213bd9aff56af5b4b8268729361f15e552038720594af69c',
      bio: 'write your bio...',
      cover: 'https://img.freepik.com/free-photo/abstract-uv-ultraviolet'
          '-light-composition_23-2149243965.jpg?w=1060&t=st'
          '=1682544786~exp=1682545386~hmac=f4b72c4463bef7807ace1b6f9ddff1683aed'
          '7d2b9aa4f8a9292fd025ae091065',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}
