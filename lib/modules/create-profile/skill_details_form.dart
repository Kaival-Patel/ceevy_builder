import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/profile/education_details_model.dart';
import 'package:resume_builder/models/profile/skill_details_model.dart';
import 'package:resume_builder/modules/create-profile/profile_form_controller.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/utils/constants/constants.dart';
import 'package:resume_builder/utils/widgets/snackbar.dart';
import 'package:resume_builder/utils/widgets/textfield.dart';
import 'package:uuid/uuid.dart';

class SkillDetailsForm extends StatefulWidget {
  SkillDetailsForm({Key? key}) : super(key: key);

  @override
  State<SkillDetailsForm> createState() => _SkillDetailsFormState();
}

class _SkillDetailsFormState extends State<SkillDetailsForm> {
  var c = Get.find<ProfileFormController>();
  List<SkillDetails> skillDetails = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    if (c.resumeProfile.skillDetails.isNotEmpty) {
      skillDetails = c.resumeProfile.skillDetails;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              if (skillDetails.isEmpty) ...[
                SizedBox(
                  height: context.height * 0.3,
                ),
                Center(
                  child: Text("No Skills added"),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () async {
                          var result = await Get.bottomSheet(AddSkillDetails(),
                              isScrollControlled: true);
                          if (result is SkillDetails) {
                            skillDetails.add(result);
                            setState(() {});
                          }
                        },
                        child: Text("Add Skill"))),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Divider(),
                    ),
                    Text("Skills"),
                    Expanded(
                      flex: 5,
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var result = await Get.bottomSheet(AddSkillDetails(),
                            isScrollControlled: true);
                        if (result is SkillDetails) {
                          skillDetails.add(result);
                          setState(() {});
                        }
                      },
                      child: ClipOval(
                        child: Container(
                          color: context.theme.primaryColor,
                          padding: EdgeInsets.all(2),
                          child: Icon(
                            Icons.add,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Divider(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: context.width,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: skillDetails
                        .map(
                          (e) => SkillDetailsCard(
                            skillDetail: e,
                            onEdit: () async {
                              var result = await Get.bottomSheet(
                                  AddSkillDetails(skillDetails: e),
                                  isScrollControlled: true);
                              if (result is SkillDetails) {
                                var index = skillDetails.indexWhere(
                                  (element) => element.id == e.id,
                                );
                                skillDetails[index] = result;
                                setState(() {});
                              }
                            },
                            onDelete: () async {
                              skillDetails.remove(e);
                              setState(() {});
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) => SkillDetailsCard(
                //     skillDetail: skillDetails[index],
                //     key: Key(index.toString()),
                //     onEdit: () async {
                //       var result = await Get.bottomSheet(
                //           AddSkillDetails(skillDetails: skillDetails[index]),
                //           isScrollControlled: true);
                //       if (result is SkillDetails) {
                //         skillDetails[index] = result;
                //         setState(() {});
                //       }
                //     },
                //     onDelete: () async {
                //       skillDetails.removeAt(index);
                //       setState(() {});
                //     },
                //   ),
                //   itemCount: skillDetails.length,
                // )
              ]
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                c.resumeProfile.skillDetails = skillDetails;
                c.saveResume(c.resumeProfile);
                c.currentProfileStep(c.currentProfileStep() + 1);
              },
              child: Text('Save and Next')),
        )
      ],
    );
  }
}

class SkillDetailsCard extends StatelessWidget {
  SkillDetails skillDetail;
  void Function()? onEdit;
  void Function()? onDelete;
  SkillDetailsCard(
      {required this.skillDetail, Key? key, this.onDelete, this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: context.width * 0.45,
        decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 1,
                  color: context.theme.disabledColor)
            ]),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    skillDetail.title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headline6,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: context.theme.cardColor,
                    child: IconButton(
                      splashRadius: 15,
                      onPressed: onEdit,
                      icon: SvgPicture.asset(
                        AppAssets.editIcon,
                        height: 20,
                        width: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Material(
                    color: context.theme.cardColor,
                    child: IconButton(
                      splashRadius: 15,
                      onPressed: onDelete,
                      icon: SvgPicture.asset(
                        AppAssets.deleteIcon,
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddSkillDetails extends StatelessWidget {
  SkillDetails? skillDetails;
  AddSkillDetails({Key? key, this.skillDetails}) : super(key: key);
  TextEditingController titleCTRL = TextEditingController();
  TextEditingController descCTRL = TextEditingController();
  static final GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if (this.skillDetails != null) {
      titleCTRL.text = this.skillDetails!.title;
      descCTRL.text = this.skillDetails!.id;
    }
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: context.theme.scaffoldBackgroundColor),
      child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  'Add Skill',
                  style: context.textTheme.headline6,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              CustomTextField(
                hint: 'Title (e.g. HTML, CSS, Javascript)',
                filled: true,
                controller: titleCTRL,
                keyBoardType: TextInputType.text,
                textInputAction: TextInputAction.next,
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
              Container(
                width: context.width,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      try {
                        Get.back(
                            result: SkillDetails(
                                title: titleCTRL.text, id: Uuid().v4()));
                      } catch (err) {
                        snack(msg: 'Something is wrong', type: SnackType.Error);
                        logger.e(err);
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add Skill"),
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
            ],
          ),
        ),
      ),
    );
  }
}
