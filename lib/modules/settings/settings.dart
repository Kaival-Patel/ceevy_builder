import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/repository/version_repo.dart';
import 'package:resume_builder/utils/constants/constants.dart';
import 'package:resume_builder/utils/widgets/suggestion_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
        color: context.theme.scaffoldBackgroundColor,
        child: Column(children: [
          ListTile(
            leading: Icon(Icons.article),
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Learn how we process your data'),
            trailing: Icon(Icons.chevron_right),
            onTap: () async {
              final _url = Uri.parse(PRIVACY_POLICY);
              await launchUrl(_url);
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent),
            onTap: () {
              Get.bottomSheet(
                  SuggestionWidget(
                      title: 'Contact me',
                      subject: 'Complain/Query',
                      description: 'Hello, so my concern is '),
                  isScrollControlled: true);
            },
            title: Text(
              'Contact Me',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Contact via email regarding any query/suggestion'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(Icons.info),
            onTap: () {},
            title: Text(
              'App Version',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Obx(() {
              return Text(versionRepo.version());
            }),
          ),
        ]),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Row(children: []),
    );
  }
}
