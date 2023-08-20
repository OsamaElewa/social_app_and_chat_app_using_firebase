import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/modules/edit_profile_screen/edit_profile_screen.dart';
import 'package:socialapp/shared/social_cubit/social_cubit.dart';
import 'package:socialapp/shared/social_cubit/social_states.dart';

import '../../shared/constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: model !=null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(model!.cover!),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(model.image!),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  model.name!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  model.bio!,
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: InkWell(
                //         child: Column(
                //           children: [
                //             Text(
                //               '100',
                //               style: Theme.of(context).textTheme.subtitle2,
                //             ),
                //             Text(
                //               'Posts',
                //               style: Theme.of(context).textTheme.caption,
                //             ),
                //           ],
                //         ),
                //         onTap: () {},
                //       ),
                //     ),
                //     Expanded(
                //       child: InkWell(
                //         child: Column(
                //           children: [
                //             Text(
                //               '100',
                //               style: Theme.of(context).textTheme.subtitle2,
                //             ),
                //             Text(
                //               'Posts',
                //               style: Theme.of(context).textTheme.caption,
                //             ),
                //           ],
                //         ),
                //         onTap: () {},
                //       ),
                //     ),
                //     Expanded(
                //       child: InkWell(
                //         child: Column(
                //           children: [
                //             Text(
                //               '100',
                //               style: Theme.of(context).textTheme.titleSmall,
                //             ),
                //             Text(
                //               'Posts',
                //               style: Theme.of(context).textTheme.bodySmall,
                //             ),
                //           ],
                //         ),
                //         onTap: () {},
                //       ),
                //     ),
                //     Expanded(
                //       child: InkWell(
                //         child: Column(
                //           children: [
                //             Text(
                //               '100',
                //               style: Theme.of(context).textTheme.titleSmall,
                //             ),
                //             Text(
                //               'Posts',
                //               style: Theme.of(context).textTheme.bodySmall,
                //             ),
                //           ],
                //         ),
                //         onTap: () {},
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: Colors.red,
                        onPressed: () {
                          signOut(context);
                        },
                        child: const Text(
                          'LOG OUT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                      },
                      child: const Icon(FontAwesomeIcons.pen),
                    ),
                  ],
                ),
              ],
            ),
          ),
          fallback: (context) => const CircularProgressIndicator(),
        );
      },
    );
  }
}
