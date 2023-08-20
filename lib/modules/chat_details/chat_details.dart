import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/shared/social_cubit/social_cubit.dart';
import 'package:socialapp/shared/social_cubit/social_states.dart';

class ChatDetails extends StatelessWidget {
  final UserModel model;

  ChatDetails({Key? key, required this.model}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: model.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.image!),
                    radius: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    model.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).messages.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message =
                              SocialCubit.get(context).messages[index];
                          if (message.senderId ==
                              SocialCubit.get(context).userModel!.uId) {
                            return buildMyMessage(message);
                          }
                          return buildFriendMessage(message);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .getMessageImage();
                                    },
                                    icon: const Icon(Icons.camera_alt),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            color: Colors.blue,
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed: () {
                                if (SocialCubit.get(context).messageImage == null) {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: model.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                } else {
                                  SocialCubit.get(context).uploadMessageImage(
                                      receiverId: model.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                }

                                messageController.text = '';
                              },
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) =>  Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Center(child: Text('start chat with your friend',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .getMessageImage();
                                    },
                                    icon: const Icon(Icons.camera_alt),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            color: Colors.blue,
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed: () {
                                if (SocialCubit.get(context).messageImage == null) {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: model.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                } else {
                                  SocialCubit.get(context).uploadMessageImage(
                                      receiverId: model.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                }

                                messageController.text = '';
                              },
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Align buildMyMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[300]?.withOpacity(0.7),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15)),
        ),
        child: Column(
          children: [
            model.imageUrl! == ''
                ? const SizedBox()
                : ClipRRect(
              borderRadius: BorderRadius.circular(15),
                  child: Image(
                      image: NetworkImage(model.imageUrl!),
                      height: 100,
                      width: 100,
                    fit: BoxFit.cover,
                    ),
                ),
            Text(
              model.text!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Align buildFriendMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15)),
        ),
        child: Column(
          children: [
            model.imageUrl! == ''
                ? const SizedBox()
                : Image(
              image: NetworkImage(model.imageUrl!),
              height: 100,
              width: 100,
            ),
            Text(
              model.text!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
