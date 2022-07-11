import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/utils/widgets/suggestion_widget.dart';

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
            title: Text('Privacy Policy',style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text('Learn how we process your data'),
            trailing: Icon(Icons.chevron_right),
            onTap: (){

            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent),
            onTap: (){
              Get.bottomSheet(SuggestionWidget(
                  title: 'Contact me',
                  subject: 'Complain/Query',
                  description: 'Hello, so my concern is '),isScrollControlled: true);
            },
            title: Text('Contact Me',style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text('Contact via email regarding any query/suggestion'),
            trailing: Icon(Icons.chevron_right),
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
