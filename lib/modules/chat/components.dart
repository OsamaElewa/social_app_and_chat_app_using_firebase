import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/modules/chat_details/chat_details.dart';

import '../../models/user_model.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.model}) : super(key: key);
  final UserModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetails(model: model),));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      model.image!),
                  radius: 30,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(model.name!,
                    style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 15,),
            const Divider(color: Colors.grey,height: 1),
          ],
        ),
      ),
    );
  }
}


class AllUserList extends StatelessWidget {
  const AllUserList({Key? key, required this.allUsers}) : super(key: key);
  final List<UserModel> allUsers;
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: allUsers.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) =>  ChatItem(model: allUsers[index],),
        separatorBuilder: (context, index) => const SizedBox(height: 15,),
        itemCount: allUsers.length,),
      fallback: (context) => const CircularProgressIndicator(),
    );
  }
}

