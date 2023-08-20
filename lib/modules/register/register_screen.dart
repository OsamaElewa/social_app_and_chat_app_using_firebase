import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_layout/social_layout.dart';


import '../../components/components.dart';
import '../login/login_screen.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if(state is SocialCreateUserSuccessState){
            showToast(text: 'Register is successfully done', state: ToastState.SUCCESS);
            navigateAndFinish(context, const SocialLayout());
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
                          'Register',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text(
                          'register now to communicate with your friends',
                          style: TextStyle(fontSize: 20.0, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
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
                          obscureText: SocialRegisterCubit
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
                              icon: Icon(SocialRegisterCubit
                                  .get(context)
                                  .suffix),
                              onPressed: () {
                                SocialRegisterCubit.get(context)
                                    .changeVisibility();
                              },
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'phone',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) =>
                              Container(
                                width: double.infinity,
                                color: Colors.blue,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialRegisterCubit.get(context)
                                          .registerData(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
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
                              'Already have an account',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateReplacmentTo(context, MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              },
                              child: const Text(
                                'LOGIN NOW',
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
      ),
    );
  }
}
