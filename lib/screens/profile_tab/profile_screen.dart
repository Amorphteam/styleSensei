import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                        'Saved Products',
                        style: Theme
                            .of(context)
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
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                NetworkImage('https://via.placeholder.com/150'),
                // Replace with actual image URL
              ),
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
            ),          ),
          ListTile(
            title: Text('Phone'),
            subtitle: Text('+123456789'),
            // Replace with dynamic data
            leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/call_bold.svg'),
            ),          ),
          ListTile(
            title: Text('About Me'),
            subtitle: Text(
              'This is a description about myself. It is just a placeholder text.',
            ),
            // Replace with dynamic data
            leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/show_bold.svg'),
            ),          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
                child: TextButton(
                  child: Text('Edit Profile',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      )), onPressed: () {},
                )
            ),
          )
        ],
      ),
    );
  }
}
