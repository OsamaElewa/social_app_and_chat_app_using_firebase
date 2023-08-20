import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/social_cubit/social_cubit.dart';
import 'package:socialapp/shared/social_cubit/social_states.dart';

class WriteComment extends StatelessWidget {
  WriteComment({super.key, this.index});
   final int? index;
  var commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: const Text('Create post'),
            actions: [
              TextButton(
                  onPressed: (){
                    SocialCubit.get(context).commentPost(SocialCubit.get(context).postsId[index!], commentController.text);
                  },
                  child: const Text('publish'))
            ],
          ),
          body: Column(
            children: [
              if(state is SocialCommentsPostLoadingStates)
                const LinearProgressIndicator(),
              if(state is SocialCommentsPostLoadingStates)
                const SizedBox(height: 20,),
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/portrait-upbeat-'
                            'playful-stylish-caucasian-girl-with-curly-hair-red-lipstick-winking-'
                            'showi_1258-81127.jpg?w=1060&t=st=1682389261~exp=1682389861~'
                            'hmac=a494ac3a2b5313bb1e51137e6f3a33d0411187fa233f97f7ade6ccf5b1c714ab'),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Osama Elewa',
                    style: TextStyle(fontWeight: FontWeight.bold, height: 1.4),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: commentController,
                  decoration: const InputDecoration(
                      hintText: 'Write your comment...',
                      border: InputBorder.none
                  ),
                ),
              ),
          ],
          ),
        );
      },
    );
  }
}
