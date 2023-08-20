
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/modules/write_comment/write_comment.dart';
import 'package:socialapp/shared/social_cubit/social_cubit.dart';

import '../../shared/constants/constants.dart';


Widget buildPostItem(PostModel model,BuildContext context, index) {
  return index !=null? Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFirstPartInPost(model.image!,model.name!,model.dateTime! ,context),
            buildHorizontalLine(),
            buildPostText(model.text! ,context),
            const SizedBox(height: 6,),
            //buildPostTags(),

            if(model.postImage !='')
             buildPostImage(model.postImage!),
            buildPostLiksAndCommentButtons(context,index),
            // Container(
            //   height: 1,
            //   color: Colors.grey[300],
            // ),
            buildHorizontalLine(),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WriteComment(index: index,)));
                    },
                    child: Row(
                      children: [
                         CircleAvatar(
                          backgroundImage: NetworkImage(
                              model.image!),
                          radius: 15,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text('write a comment ...',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(height: 1.4)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: const Row(
                    children: [
                      Icon(FontAwesomeIcons.heart,color: Colors.red,),
                      SizedBox(width: 8,),
                      Text('Like')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )) : CircularProgressIndicator();
}

Widget buildPostLiksAndCommentButtons(context,index) {
  return Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children:  [
                const Icon(FontAwesomeIcons.heart,color: Colors.red,),
                const SizedBox(width: 10,),
                Text('${SocialCubit.get(context).likes[index]} likes'),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        child: InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                const Icon(FontAwesomeIcons.comment,color: Colors.amber,),
                const SizedBox(width: 10,),
                Text('${SocialCubit.get(context).comments[index]} comments'),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildPostImage(String postImage) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(
        height: 150,
        width: double.infinity,
        decoration:  BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(postImage),
          ),
        )),
  );
}

Widget buildPostTags() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      width: double.infinity,
      child: Wrap(
        children: [
          Container(
            child: MaterialButton(
              minWidth: 1.0,
              padding: EdgeInsets.zero,
              onPressed: (){},
              child: Text('#software_development',style: TextStyle(color: Colors.blue),),
            ),
            height: 20,
          ),
          Container(
            child: MaterialButton(
              minWidth: 1.0,
              padding: EdgeInsets.zero,
              onPressed: (){},
              child: Text('#software_development',style: TextStyle(color: Colors.blue),),
            ),
            height: 20,
          ),
          Container(
            child: MaterialButton(
              minWidth: 1.0,
              padding: EdgeInsets.zero,
              onPressed: (){},
              child: Text('#software_development',style: TextStyle(color: Colors.blue),),
            ),
            height: 20,
          ),
          Container(
            child: MaterialButton(
              minWidth: 1.0,
              padding: EdgeInsets.zero,
              onPressed: (){},
              child: Text('#software_development',style: TextStyle(color: Colors.blue),),
            ),
            height: 20,
          ),
          Container(
            child: MaterialButton(
              minWidth: 1.0,
              padding: EdgeInsets.zero,
              onPressed: (){},
              child: Text('#software_development',style: TextStyle(color: Colors.blue),),
            ),
            height: 20,
          ),
          Container(
            child: MaterialButton(
              minWidth: 1.0,
              padding: EdgeInsets.zero,
              onPressed: (){},
              child: Text('#software_development',style: TextStyle(color: Colors.blue),),
            ),
            height: 20,
          ),
        ],
      ),
    ),
  );
}

Widget buildPostText(String postText,BuildContext context) {
  return Text(
    postText,
    style: Theme.of(context).textTheme.subtitle1,
  );
}

Widget buildHorizontalLine() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Container(
      height: 1,
      color: Colors.grey[300],
    ),
  );
}

Widget buildFirstPartInPost(String image,String name,String dateTime,BuildContext context) {
  return Row(
    children: [
        CircleAvatar(
        backgroundImage: NetworkImage(
            image),
        radius: 25,
      ),
      const SizedBox(
        width: 15,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, height: 1.4),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.check_circle,
                color: defaultColor,
                size: 16,
              )
            ],
          ),
          Text(dateTime,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(height: 1.4)),
        ],
      ),
      const Spacer(),
      //SizedBox(widconst th: 15,),
      IconButton(
          onPressed: () {}, icon: const Icon(Icons.more_horiz))
    ],
  );
}

Widget buildImageCard() {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.all(8),
    elevation: 10,
    child: Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: const [
        Image(
          image: NetworkImage(
              'https://img.freepik.com/free-photo/charming-friendly-selfassured-attractive'
                  '-curly-woman-waving-cute-with-palm-say-hi-hello-sm_1258-143041.jpg?w=1380&t=st=1682387983~exp=1682388583~hmac='
                  '83be59e768d93fa9ea4a0b73195902e90ab314c4fb7e8444b907b90e11f9cb24'),
          height: 200,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Communicate with your friends',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}