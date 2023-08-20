import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_layout/social_layout.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

import '../../components/components.dart';
import '../register/register_screen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLoginCubit, SocialLoginState>(
      listener: (context, state) {
        if (state is SocialLoginErrorState) {
          showToast(text: state.error, state: ToastState.ERROR);
        }
        if(state is SocialLoginSuccessState){
          showToast(text: 'login is done successfully', state: ToastState.SUCCESS);
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            navigateAndFinish(context, const SocialLayout());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'login now to communicate with your friends',
                        style: TextStyle(fontSize: 20.0, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: SocialLoginCubit
                            .get(context)
                            .isPasswordShown,
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password must not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(SocialLoginCubit
                                .get(context)
                                .suffix),
                            onPressed: () {
                              SocialLoginCubit.get(context)
                                  .changeVisibility();
                              // setState(() {
                              //   ispassword=! ispassword;
                              // });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) =>
                            Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,);
                                    print(emailController.text);
                                    print(passwordController.text);
                                  }
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // MaterialButton(
                              //   onPressed:(){
                              //     if(formKey.currentState!.validate()) {
                              //       print(emailController.text);
                              //       print(passwordController.text);
                              //     }
                              //   },
                              //   child:const Text(
                              //     'LOGIN',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //     ),
                              //   ) ,
                              // ),
                            ),
                        fallback: (context) =>
                        const Center(child: CircularProgressIndicator(),),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account',
                          ),
                          TextButton(
                            onPressed: () {
                              navigateReplacmentTo(context, MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                            },
                            child: const Text(
                              'REGISTER NOW',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
