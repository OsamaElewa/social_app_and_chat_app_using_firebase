import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/main.dart';
import 'package:socialapp/post_screen/post_screen.dart';
import 'package:socialapp/shared/constants/constants.dart';
import 'package:socialapp/shared/social_cubit/social_cubit.dart';
import 'package:socialapp/shared/social_cubit/social_states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostStates){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  PostsScreen()));
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.house), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.commentDots), label: 'Chat'),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.filePen), label: 'Posts'),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.gear), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
