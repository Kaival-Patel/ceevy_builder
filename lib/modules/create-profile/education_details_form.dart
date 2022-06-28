import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/profile/education_details_model.dart';
import 'package:resume_builder/modules/create-profile/profile_form_controller.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/utils/constants/constants.dart';
import 'package:resume_builder/utils/widgets/snackbar.dart';
import 'package:resume_builder/utils/widgets/textfield.dart';

class EducationDetailsForm extends StatefulWidget {
  EducationDetailsForm({Key? key}) : super(key: key);

  @override
  State<EducationDetailsForm> createState() => _EducationDetailsFormState();
}

class _EducationDetailsFormState extends State<EducationDetailsForm> {
  var c = Get.find<ProfileFormController>();
  List<EducationDetails> educationDetails = [];
  @override
  void initState() {
    // TODO: implement initState
    educationDetails = c.resumeProfile.education;
    if (educationDetails.isNotEmpty) {
      educationDetails.sort((a, b) => a.sortedPos.compareTo(b.sortedPos));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              if (educationDetails.isEmpty) ...[
                SizedBox(
                  height: context.height * 0.3,
                ),
                Center(
                  child: Text("No Educational events added"),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () async {
                          var result = await Get.bottomSheet(
                              AddEducationDetails(),
                              isScrollControlled: true);
                          if (result is EducationDetails) {
                            educationDetails.add(result);
                            setState(() {});
                          }
                        },
                        child: Text("Add Education"))),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Divider(),
                    ),
                    Text("Education Events (Reorder to arrange)"),
                    Expanded(
                      flex: 5,
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var result = await Get.bottomSheet(
                            AddEducationDetails(),
                            isScrollControlled: true);
                        if (result is EducationDetails) {
                          educationDetails.add(result);
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
                ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => EducationDetailsCard(
                          educationDetails: educationDetails[index],
                          key: Key(index.toString()),
                          onEdit: () async {
                            var result = await Get.bottomSheet(
                                AddEducationDetails(
                                    educationDetails: educationDetails[index]),
                                isScrollControlled: true);
                            if (result is EducationDetails) {
                              educationDetails[index] = result;
                              setState(() {});
                            }
                          },
                          onDelete: () async {
                            educationDetails.removeAt(index);
                            setState(() {});
                          },
                        ),
                    itemCount: educationDetails.length,
                    onReorder: (oldIndex, newIndex) {
                      if (newIndex > oldIndex) {
                        newIndex = newIndex - 1;
                      }
                      final task = educationDetails.removeAt(oldIndex);
                      educationDetails.insert(newIndex, task);
                      setState(() {});
                    })
              ]
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                for (var i = 0; i < educationDetails.length; i++) {
                  educationDetails[i].sortedPos = i;
                }
                c.resumeProfile.education = educationDetails;
                c.saveResume(c.resumeProfile);
                c.currentProfileStep(c.currentProfileStep() + 1);
              },
              child: Text('Save and Next')),
        )
      ],
    );
  }
}

class EducationDetailsCard extends StatelessWidget {
  EducationDetails educationDetails;
  void Function()? onEdit;
  void Function()? onDelete;
  EducationDetailsCard(
      {required this.educationDetails, Key? key, this.onDelete, this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: context.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              AppAssets.dragIcon,
              color: context.theme.primaryColor.withOpacity(0.5),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 1,
                          color: context.theme.disabledColor)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 20,
                              width: 70,
                              color: context.theme.primaryColor,
                              child: Center(
                                child: Text(
                                  educationDetails.time,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            educationDetails.title,
                            style: context.textTheme.headline6,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            educationDetails.place,
                            style:
                                TextStyle(color: context.theme.disabledColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddEducationDetails extends StatelessWidget {
  EducationDetails? educationDetails;
  AddEducationDetails({Key? key, this.educationDetails}) : super(key: key);
  TextEditingController timeCTRL = TextEditingController();
  TextEditingController titleCTRL = TextEditingController();
  TextEditingController placeCTRL = TextEditingController();
  static final GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if (this.educationDetails != null) {
      timeCTRL.text = this.educationDetails!.time;
      titleCTRL.text = this.educationDetails!.title;
      placeCTRL.text = this.educationDetails!.place;
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
                  'Add Educational Event',
                  style: context.textTheme.headline6,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              CustomTextField(
                hint: 'Time (e.g. 2018-2019)',
                filled: true,
                controller: timeCTRL,
                keyBoardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return 'Time cannot be empty';
                  }
                },
                onChanged: (v) {},
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                hint: 'Title (e.g. Bachelor of Science in Computer Science)',
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
                height: 5,
              ),
              CustomTextField(
                hint: 'Place (e.g. University of Lagos)',
                filled: true,
                controller: placeCTRL,
                keyBoardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return 'Place cannot be empty';
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
                            result: EducationDetails(
                                place: placeCTRL.text,
                                time: timeCTRL.text,
                                title: titleCTRL.text));
                      } catch (err) {
                        snack(msg: 'Something is wrong', type: SnackType.Error);
                        logger.e(err);
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add Event"),
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
