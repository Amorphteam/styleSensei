import 'package:flutter/material.dart';
import 'package:style_sensei/screens/body/body_screen.dart';
import 'package:style_sensei/screens/splash/splash_with_video.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:style_sensei/utils/analytics_helper.dart'; // Import the AnalyticsHelper to log events
import 'package:url_launcher/url_launcher.dart';

import '../../utils/untitled.dart';
import '../color_tones/color_tones_screen.dart';
import '../style/style_screen.dart';
import '../survey/survey_multistep.dart';
import '../survey/survey_multiple_choice.dart';
import '../survey/survey_satisfaction_rating.dart';
import '../survey/survey_binary_choice.dart';

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
          _buildListTile(title: AppLocalizations.of(context).translate('language'), context: context),
          _buildListTile(title: AppLocalizations.of(context).translate('body_type'), context: context),
          _buildListTile(title: AppLocalizations.of(context).translate('color_tone'), context: context),
          _buildListTile(title: AppLocalizations.of(context).translate('styles'), context: context),
          _buildListTile(title: AppLocalizations.of(context).translate('comfort_zone'), context: context),
          _buildSectionTitle(context, AppLocalizations.of(context).translate('activity')),
          _buildListTile(title: AppLocalizations.of(context).translate('likes'), context: context),
          _buildListTile(title: AppLocalizations.of(context).translate('dislikes'), context: context),
          _buildSectionTitle(context, AppLocalizations.of(context).translate('surveys')),
          _buildListTile(title: AppLocalizations.of(context).translate('multi_step_survey'), context: context),
          _buildListTile(title: AppLocalizations.of(context).translate('multiple_choice_survey'), context: context),
          _buildListTile(title: AppLocalizations.of(context).translate('satisfaction_rating_survey'), context: context),
          _buildListTile(title: AppLocalizations.of(context).translate('binary_choice_survey'), context: context),
          _buildSectionTitle(context, AppLocalizations.of(context).translate('about')),
          _buildListTile(title: AppLocalizations.of(context).translate('privacy_policy'), context: context),
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
          )),
    );
  }

  Widget _buildListTile({required BuildContext context, required String title}) {
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

      // Surveys
      AppLocalizations.of(context).translate('multi_step_survey'): SurveyMultistep(onClose: () {
        Navigator.pop(context);
      }),
      AppLocalizations.of(context).translate('multiple_choice_survey'): SurveyMultipleChoice(onClose: () {
        Navigator.pop(context);
      }),
      AppLocalizations.of(context).translate('satisfaction_rating_survey'): SurveySatisfactionRating(onClose: () {
        Navigator.pop(context);
      }),
      AppLocalizations.of(context).translate('binary_choice_survey'): SurveyBinaryChoice(onClose: () {
        Navigator.pop(context);
      }),
    };

    final screen = screens[title];

    // Log the event when a setting option is clicked
    AnalyticsHelper.logEvent('click_settings_option', {
      'option_name': title, // Pass the title of the setting option
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
