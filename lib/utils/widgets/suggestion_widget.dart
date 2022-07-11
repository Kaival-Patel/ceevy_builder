import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/routes/routes.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/utils/constants/constants.dart';
import 'package:resume_builder/utils/widgets/snackbar.dart';
import 'package:resume_builder/utils/widgets/textfield.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';

class SuggestionWidget extends StatefulWidget {
  String title;
  String subject;
  String? description;

  SuggestionWidget({Key? key,
    required this.title,
    required this.subject,
    required this.description})
      : super(key: key);
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<SuggestionWidget> createState() => _SuggestionWidgetState();
}

class _SuggestionWidgetState extends State<SuggestionWidget> {
  TextEditingController titleCTRL = TextEditingController();
  TextEditingController descriptionCTRL = TextEditingController();

  @override
  void initState() {
    autoFill();
    super.initState();
  }

  autoFill() {
    titleCTRL.text = widget.subject;
    if (widget.description != null) {
      descriptionCTRL.text = widget.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.theme.scaffoldBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          width: 45, height: 4, color: context.theme.hoverColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      '${widget.title}',
                      style: context.textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      'This will directly reach to me',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  Text(
                    'Subject',
                    style: TextStyle(
                      color: context.theme.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    hint: '${widget.title}',
                    filled: true,
                    controller: titleCTRL,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return 'Title cannot be empty';
                      }
                    },
                    onChanged: (v) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Body',
                    style: TextStyle(
                      color: context.theme.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    hint: '${widget.description}',
                    filled: true,
                    keyBoardType: TextInputType.multiline,
                    controller: descriptionCTRL,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return 'Body cannot be empty';
                      }
                    },
                    onChanged: (v) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: context.width,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (SuggestionWidget.formKey.currentState?.validate() ?? true) {
                          Get.back();
                          try {
                            final Uri _url = Uri.parse(
                                'mailto:kaivalpatel53@gmail.com?subject=${titleCTRL
                                    .text}&body=${descriptionCTRL.text}');
                            launchUrl(_url);
                          } catch (err) {
                            snack(
                                msg: 'Something is wrong', type: SnackType.Error);
                            logger.e(err);
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Send"),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
