import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style_sensei/screens/body/body_screen.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:style_sensei/utils/user_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/untitled.dart';
import '../color_tones/color_tones_screen.dart';
import '../style/cubit/style_cubit.dart';
import '../style/style_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          _buildProfileHeader(context),
          SizedBox(
            height: 16,
          ),
          _buildSectionTitle(context, AppLocalizations.of(context).translate('appearance_preferences')),
          _buildListTile(
              title: AppLocalizations.of(context).translate('body_type'), icon: Icons.accessibility, context: context),
          _buildListTile(
              title: AppLocalizations.of(context).translate('color_tone'), icon: Icons.palette, context: context),
          _buildListTile(title: AppLocalizations.of(context).translate('styles'), icon: Icons.style, context: context),
          _buildListTile(
              title: AppLocalizations.of(context).translate('comfort_zone'),
              icon: Icons.view_comfortable,
              context: context),
          _buildSectionTitle(context, AppLocalizations.of(context).translate('activity')),
          _buildListTile(
              title: AppLocalizations.of(context).translate('likes'), icon: Icons.thumb_up, context: context),
          _buildListTile(
              title: AppLocalizations.of(context).translate('dislikes'), icon: Icons.thumb_down, context: context),
          _buildSectionTitle(context, AppLocalizations.of(context).translate('about')),
          _buildListTile(
              title: AppLocalizations.of(context).translate('privacy_policy'),
              icon: Icons.privacy_tip,
              context: context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/logo/logo.png', height: 70, width: 70),
          // Text(UserController.currentUser?.displayName ?? '',
          //     style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _buildListTile(
      {required BuildContext context,
      required String title,
      required IconData icon}) {
    return ListTile(
      title: Text(title),
      onTap: () {
        _openScreen(title, context);
      },
    );
  }

  void _openScreen(String title, BuildContext context) {
    final screens = {
      AppLocalizations.of(context).translate('body_type'): BodyTypeSelectionScreen(isFromSettings: true),
      AppLocalizations.of(context).translate('color_tone'): ColorTonesScreen(isFromSettings: true),
      AppLocalizations.of(context).translate('styles'): StyleScreen(isFromSettings: true),
      AppLocalizations.of(context).translate('privacy_policy'): 'https://amorphteam.com/style_sensei/privacy_policy.html',
    };

    final screen = screens[title];
    if (screen is Widget) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    } else if (screen is String) {
      _launchURL(screen);
    } else {
      showSnackbar(context, AppLocalizations.of(context).translate('feature_error'));
    }
  }
}



  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }




///          Container(
//               margin: EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         AppLocalizations.of(context).translate('profile_title'),
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleLarge
//                             ?.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               )),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(children: [
//               CircleAvatar(
//                 foregroundImage:
//                     NetworkImage(UserController.user?.photoURL ?? ''),
//               ),
//               SizedBox(height: 16.0,),
//               Text(
//                 UserController.user?.displayName ?? 'Name',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               Text(
//                 UserController.user?.email ?? 'test@gmail.com',
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//               SizedBox(height: 16.0,),
//
//             ]),
//           ),
//           SizedBox(height: 16.0),
//
//           ListTile(
//             title: Text('UserName'),
//             subtitle: Text('User12'),
//             // Replace with dynamic data
//             leading: IconButton(
//               onPressed: () {},
//               icon: ColorFiltered(
//                 colorFilter: ColorFilter.mode(
//                   Theme.of(context).colorScheme.onSurface,
//                   BlendMode.srcIn,
//                 ),
//                 child: ColorFiltered(
//                     colorFilter: ColorFilter.mode(
//                       Theme.of(context).colorScheme.onSurface,
//                       BlendMode.srcIn,
//                     ),
//                     child: SvgPicture.asset('assets/images/profile_bold.svg')),
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Email'),
//             subtitle: Text('user123@example.com'),
//             // Replace with dynamic data
//             leading: IconButton(
//               onPressed: () {},
//               icon: ColorFiltered(
//                   colorFilter: ColorFilter.mode(
//                     Theme.of(context).colorScheme.onSurface,
//                     BlendMode.srcIn,
//                   ),
//                   child: SvgPicture.asset('assets/images/send_bold.svg')),
//             ),
//           ),
//           ListTile(
//             title: Text('Phone'),
//             subtitle: Text('+123456789'),
//             // Replace with dynamic data
//             leading: IconButton(
//               onPressed: () {},
//               icon: ColorFiltered(
//                   colorFilter: ColorFilter.mode(
//                     Theme.of(context).colorScheme.onSurface,
//                     BlendMode.srcIn,
//                   ),
//                   child: SvgPicture.asset('assets/images/call_bold.svg')),
//             ),
//           ),
//           ListTile(
//             title: Text('About Me'),
//             subtitle: Text(
//               'Passionate about using fashion as a form of self-expression, I curate my style to tell a story with every outfit I wear.',
//             ),
//             // Replace with dynamic data
//             leading: IconButton(
//               onPressed: () {},
//               icon: ColorFiltered(
//                   colorFilter: ColorFilter.mode(
//                     Theme.of(context).colorScheme.onSurface,
//                     BlendMode.srcIn,
//                   ),
//                   child: SvgPicture.asset('assets/images/show_bold.svg')),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Center(
//                 child: TextButton(
//               child: Text('Edit Profile',
//                   style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                         color: Theme.of(context).primaryColor,
//                         fontWeight: FontWeight.bold,
//                       )),
//               onPressed: () async {
//                 await Future.delayed(Duration(microseconds: 200));
//                 final imageSelectionCubit =
//                     ImageSelectionCubit(); // Create an instance of HomeCubit
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BlocProvider(
//                       create: (context) => imageSelectionCubit,
//                       child: StyleScreen(),
//                     ),
//                   ),
//                 );
//               },
//             )),
//           )
