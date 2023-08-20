import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/social_cubit/social_states.dart';

import '../shared/social_cubit/social_cubit.dart';

class PostsScreen extends StatelessWidget {

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
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
                onPressed: () {
                  if(SocialCubit.get(context).postImage == null){
                    SocialCubit.get(context).createPost(
                        dateTime: DateTime.now().toString(),
                        text: textController.text,
                    );
                  }else{
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                  }
                },
                child: const Text('POST'),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingStates)
                  const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingStates)
                  const SizedBox(height: 20,),
                Row(
                  children:  [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          SocialCubit.get(context).userModel!.image!),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      SocialCubit.get(context).userModel!.name!,
                      style: TextStyle(fontWeight: FontWeight.bold, height: 1.4),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'What is in your mind...',
                        border: InputBorder.none)
                    ,
                  ),
                ),
                if(SocialCubit.get(context).postImage !=null)
                  Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: (){
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: const Icon(Icons.close,color: Colors.red,)
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image),
                            SizedBox(width: 8,),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
