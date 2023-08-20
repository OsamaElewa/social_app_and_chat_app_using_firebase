import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/social_cubit/social_cubit.dart';
import 'package:socialapp/shared/social_cubit/social_states.dart';

import 'components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){

      },
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty ,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

              child: Column(
              children: [
                buildImageCard(),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context,index) => const SizedBox(height: 10,),
                    itemCount: SocialCubit.get(context).posts.length),
                //buildPostItem(context),
              ],
            ),
          ),
          fallback: (context) => const CircularProgressIndicator(),
        );
      },
    );
  }
}
