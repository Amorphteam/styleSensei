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
          _buildSectionTitle(context, 'Appearance and Preferences'),
          _buildListTile(
              title: 'Body type', icon: Icons.accessibility, context: context),
          _buildListTile(
              title: 'Color tone', icon: Icons.palette, context: context),
          _buildListTile(title: 'Styles', icon: Icons.style, context: context),
          _buildListTile(
              title: 'Comfort zone',
              icon: Icons.view_comfortable,
              context: context),
          _buildSectionTitle(context, 'Activity'),
          _buildListTile(
              title: 'Likes', icon: Icons.thumb_up, context: context),
          _buildListTile(
              title: 'Dislikes', icon: Icons.thumb_down, context: context),
          _buildSectionTitle(context, 'About'),
          _buildListTile(
              title: 'Licences', icon: Icons.description, context: context),
          _buildListTile(
              title: 'Privacy Policy',
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
          CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(UserController.user?.photoURL ??
                'https://via.placeholder.com/150'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(UserController.user?.displayName ?? '',
                style: Theme.of(context).textTheme.titleLarge),
          ),
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
    Widget? screen = null;
    String? url = null;
    String? error = null;
    switch (title) {
      case 'Body type':
        screen = BodyTypeSelectionScreen();
      case 'Color tone':
        screen = ColorTonesScreen();
      case 'Styles':
        screen = StyleScreen();
      case 'Licences':
        url = 'https://amorphteam.com/stylesensei/licences.html';
      case 'Privacy Policy':
        url = 'https://amorphteam.com/stylesensei/privacy_policy.html';
      case 'Likes':
        showSnackbar(
          context,
          AppLocalizations.of(context).translate('feature_error'),
        );
      case 'Dislikes':
        showSnackbar(
          context,
          AppLocalizations.of(context).translate('feature_error'),
        );
      case 'Comfort zone':
        showSnackbar(
          context,
          AppLocalizations.of(context).translate('feature_error'),
        );
    }

    if (screen != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen!,
        ),
      );
    }

    if (url != null) {
      _launchURL(url);
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
