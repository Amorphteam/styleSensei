import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../style/cubit/style_cubit.dart';
import '../style/style_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/large_text_logo.png',
                    width: 12,
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Image.asset('assets/images/profile.png', width: 80,)
            ),
          ),
          SizedBox(height: 16.0),
          ListTile(
            title: Text('Username'),
            subtitle: Text('User123'),
            // Replace with dynamic data
            leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/profile_bold.svg'),
            ),
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text('user123@example.com'),
            // Replace with dynamic data
            leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/send_bold.svg'),
            ),
          ),
          ListTile(
            title: Text('Phone'),
            subtitle: Text('+123456789'),
            // Replace with dynamic data
            leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/call_bold.svg'),
            ),
          ),
          ListTile(
            title: Text('About Me'),
            subtitle: Text(
              'Passionate about using fashion as a form of self-expression, I curate my style to tell a story with every outfit I wear.',
            ),
            // Replace with dynamic data
            leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/show_bold.svg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
                child: TextButton(
              child: Text('Edit Profile',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      )),
              onPressed: () async {
                await Future.delayed(Duration(microseconds: 200));
                final imageSelectionCubit =
                    ImageSelectionCubit(); // Create an instance of HomeCubit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => imageSelectionCubit,
                      child: StyleScreen(),
                    ),
                  ),
                );
              },
            )),
          )
        ],
      ),
    );
  }
}
