import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/shared/social_cubit/social_cubit.dart';
import 'package:socialapp/shared/social_cubit/social_states.dart';

import '../../components/components.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();

  var bioController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialSuccessStates){
          showToast(text: 'your profile is updated successfully', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = model!.name!;
        bioController.text = model.bio!;
        phoneController.text = model.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: const Text('Edit Profile'),
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                child: const Text(
                  'UPDATE',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is SocialUserUpdateLoadingStates)
                      const LinearProgressIndicator(),
                    if (state is SocialUserUpdateLoadingStates)
                      const SizedBox(height: 5,),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        SizedBox(
                          height: 190,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: coverImage == null
                                    ? Container(
                                        height: 140,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(model.cover!),
                                              fit: BoxFit.cover),
                                        ),
                                      )
                                    : Container(
                                        height: 140,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                          image: DecorationImage(
                                              image: FileImage(coverImage),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    height: 130,
                                    width: 130,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: profileImage != null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image:
                                                      FileImage(profileImage),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      model.image!),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    child: IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context)
                                              .getProfileImage();
                                        },
                                        icon: const Icon(
                                            FontAwesomeIcons.camera)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              SocialCubit.get(context).getCoverImage();
                            },
                            icon: const Icon(FontAwesomeIcons.camera),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).profileImage != null)
                            Expanded(
                              child: MaterialButton(
                                color: Colors.blue,
                                onPressed: () {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                child: const Text('UPLOAD PROFILE',style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (SocialCubit.get(context).coverImage != null)
                              Expanded(
                              child: MaterialButton(
                                color: Colors.blue,
                                onPressed: () {
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                child: const Text('UPLOAD COVER',style: TextStyle(color: Colors.white),),
                              ),
                            ),
                        ],
                      ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        label: Text('NAME'),
                        hintText: 'Enter your name ',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'NAME MUST NOT BE EMPTY';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: bioController,
                      decoration: const InputDecoration(
                        label: Text('BIO'),
                        hintText: 'Enter your bio ',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        prefixIcon: Icon(Icons.info),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'BIO MUST NOT BE EMPTY';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        label: Text('Phone'),
                        hintText: 'Enter your Phone ',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PHONE MUST NOT BE EMPTY';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
