import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/chat/chat_page.dart';
import 'package:socialapp/modules/feeds/feeds_page.dart';
import 'package:socialapp/modules/users/users_page.dart';
import 'package:socialapp/post_screen/post_screen.dart';
import 'package:socialapp/shared/constants/constants.dart';
import 'package:socialapp/shared/social_cubit/social_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../modules/settings/settings_page.dart';
import '../network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatScreen(),
    PostsScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = ['Home', 'Chats', 'Posts','Settings'];

  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUser();
      //emit(SocialGetAllUserStates());
    }
    if (index == 2) {
      emit(SocialNewPostStates());
    } else {
      currentIndex = index;
      emit(SocialChangeNavBarStates());
    }
  }

  UserModel? userModel;

  void getUser() {
    emit(SocialLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'uId')).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(value.data());
      emit(SocialSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialErrorStates(error.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessStates());
    } else {
      print('no image selected');
      emit(SocialProfileImagePickedErrorStates());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessStates());
    } else {
      print('no image selected');
      emit(SocialCoverImagePickedErrorStates());
    }
  }



  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,}) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio,image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorStates());
    });
  }



  void uploadCoverImage({
        required String name,
        required String phone,
        required String bio,}) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorStates());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingStates());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUser(
  //         name: name,
  //         phone: phone,
  //         bio: bio
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      isEmailVerified: false,
      bio: bio,
      image: userModel!.image,
      cover: cover?? userModel!.cover,
      email: image?? userModel!.email,
      uId: userModel!.uId,
      password: userModel!.password,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUser();
    }).catchError((error) {
      emit(SocialUserUpdateErrorStates());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessStates());
    } else {
      print('no image selected');
      emit(SocialPostImagePickedErrorStates());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        print(value);
      }).catchError((error) {
        emit(SocialCreatePostErrorStates());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingStates());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessStates());
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessStates());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(SocialGetPostsLoadingStates());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostsSuccessStates());
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessStates());
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          emit(SocialGetCommentsSuccessStates());
        }).catchError((error) {});
      });

      emit(SocialGetPostsSuccessStates());
    }).catchError((error) {
      emit(SocialGetPostsErrorStates(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessStates());
    }).catchError((error) {
      emit(SocialLikePostErrorStates(error.toString()));
    });
  }

  void commentPost(String postId, String comment) {
    emit(SocialCommentsPostLoadingStates());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': comment}).then((value) {
      emit(SocialCommentsPostSuccessStates());
    }).catchError((error) {
      emit(SocialCommentsPostErrorStates(error.toString()));
    });
  }

  List<UserModel> allUsers = [];

  void getAllUser() {
    emit(SocialGetAllUserLoadingStates());
    if (allUsers.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.id != CacheHelper.getData(key: 'uId')) {
            allUsers.add(UserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUserSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUserErrorStates(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? imageUrl,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
      imageUrl: imageUrl ?? '',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessageErrorStates(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessageErrorStates(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessStates());
    });
  }

  File? messageImage;

  Future<void> getMessageImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      emit(SocialMessageImagePickedSuccessStates());
    } else {
      print('no image selected');
      emit(SocialMessageImagePickedErrorStates());
    }
  }

  void uploadMessageImage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('messages/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
            receiverId: receiverId,
            dateTime: dateTime,
            text: text,
            imageUrl: value);
        print(value);
      }).catchError((error) {
        emit(SocialCreateMessageErrorStates(error.toString()));
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }
}
