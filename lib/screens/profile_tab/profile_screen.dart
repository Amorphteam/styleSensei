import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style_sensei/screens/body/body_screen.dart';
import 'package:style_sensei/screens/splash/splash_with_video.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:style_sensei/utils/analytics_helper.dart';
import 'package:style_sensei/utils/user_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/untitled.dart';
import '../color_tones/color_tones_screen.dart';
import '../detail_screen/widgets/combine_surveys.dart';
import '../style/cubit/style_cubit.dart';
import '../style/style_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 16),
          _buildProfileHeader(context),
          SizedBox(height: 16),
          _buildSectionTitle(context, AppLocalizations.of(context).translate('appearance_preferences')),
          _buildListTile(
              title: AppLocalizations.of(context).translate('language'),
              icon: Icons.language,
              context: context),
          _buildListTile(
              title: AppLocalizations.of(context).translate('body_type'),
              icon: Icons.accessibility,
              context: context),
          _buildListTile(
              title: AppLocalizations.of(context).translate('color_tone'),
              icon: Icons.palette,
              context: context),
          _buildListTile(
              title: AppLocalizations.of(context).translate('styles'),
              icon: Icons.style,
              context: context),
          _buildListTile(
              title: AppLocalizations.of(context).translate('comfort_zone'),
              icon: Icons.view_comfortable,
              context: context),
          _buildSectionTitle(context, AppLocalizations.of(context).translate('activity')),
          _buildListTile(
              title: AppLocalizations.of(context).translate('likes'),
              icon: Icons.thumb_up,
              context: context),
          _buildListTile(
              title: AppLocalizations.of(context).translate('dislikes'),
              icon: Icons.thumb_down,
              context: context),
          _buildSectionTitle(context, AppLocalizations.of(context).translate('about')),
          _buildListTile(
              title: AppLocalizations.of(context).translate('privacy_policy'),
              icon: Icons.privacy_tip,
              context: context),

          // Section for the "Tell Us What You Think" and survey button
          Container(
              color: Colors.grey.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns the text and button on the same row
                children: [
                  Text(
                    AppLocalizations.of(context).translate('tell_us_what_you_think'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CombinedSurveyScreen(onClose: () {
                          Navigator.pop(context); // Close survey and return to profile
                        })),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Text color
                      backgroundColor: Colors.black, // Background color
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                      ),
                      elevation: 0, // Remove shadow/elevation if required
                    ),
                    child: Text(
                      AppLocalizations.of(context).translate('start_survey'),
                      style: TextStyle(
                        fontSize: 16, // Text size
                        color: Colors.white, // Ensure the text color is white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/logo/logo.png', height: 70, width: 70),
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
        ),
      ),
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
      AppLocalizations.of(context).translate('language'): SplashWithVideo(isFromSettings: true),
      AppLocalizations.of(context).translate('body_type'): BodyTypeSelectionScreen(isFromSettings: true),
      AppLocalizations.of(context).translate('color_tone'): ColorTonesScreen(isFromSettings: true),
      AppLocalizations.of(context).translate('styles'): StyleScreen(isFromSettings: true),
      AppLocalizations.of(context).translate('privacy_policy'): 'https://amorphteam.com/style_sensei/privacy_policy.html',
    };

    final screen = screens[title];

    // Log the event when a setting option is clicked
    AnalyticsHelper.logEvent('click_settings_option', {
      'option_name': title,
    });

    if (screen is Widget) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    } else if (screen is String) {
      _launchURL(screen);
    } else {
      showSnackbar(context, AppLocalizations.of(context).translate('feature_error'));
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
