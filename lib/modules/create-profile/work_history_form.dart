import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/profile/education_details_model.dart';
import 'package:resume_builder/models/profile/work_history_details_model.dart';
import 'package:resume_builder/modules/create-profile/profile_form_controller.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/utils/constants/constants.dart';
import 'package:resume_builder/utils/widgets/snackbar.dart';
import 'package:resume_builder/utils/widgets/textfield.dart';

class WorkHistoryForm extends StatefulWidget {
  WorkHistoryForm({Key? key}) : super(key: key);

  @override
  State<WorkHistoryForm> createState() => _WorkHistoryFormState();
}

class _WorkHistoryFormState extends State<WorkHistoryForm> {
  var c = Get.find<ProfileFormController>();
  List<WorkHistoryDetails> workDetails = [];
  @override
  void initState() {
    // TODO: implement initState
    workDetails = c.resumeProfile.workDetails;
    workDetails.sort((a, b) => a.sortedPos.compareTo(b.sortedPos));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              if (workDetails.isEmpty) ...[
                SizedBox(
                  height: context.height * 0.3,
                ),
                Center(
                  child: Text("No Work experience added"),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          var result = await Get.bottomSheet(AddWorkDetails(),
                              isScrollControlled: true, ignoreSafeArea: false);
                          if (result is WorkHistoryDetails) {
                            workDetails.add(result);
                            setState(() {});
                          }
                        },
                        child: Text("Add Work History"))),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Divider(),
                    ),
                    Text("Work Experience (Reorder to arrange)"),
                    Expanded(
                      flex: 5,
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var result = await Get.bottomSheet(AddWorkDetails(),
                            isScrollControlled: true, ignoreSafeArea: false);
                        if (result is WorkHistoryDetails) {
                          workDetails.add(result);
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
                    itemBuilder: (context, index) => WorkDetailsCard(
                          workDetails: workDetails[index],
                          key: Key(index.toString()),
                          onEdit: () async {
                            var result = await Get.bottomSheet(
                                AddWorkDetails(workDetails: workDetails[index]),
                                isScrollControlled: true,
                                ignoreSafeArea: false);
                            if (result is WorkHistoryDetails) {
                              workDetails[index] = result;
                              setState(() {});
                            }
                          },
                          onDelete: () async {
                            workDetails.removeAt(index);
                            setState(() {});
                          },
                        ),
                    itemCount: workDetails.length,
                    onReorder: (oldIndex, newIndex) {
                      if (newIndex > oldIndex) {
                        newIndex = newIndex - 1;
                      }
                      final task = workDetails.removeAt(oldIndex);
                      workDetails.insert(newIndex, task);
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
                for (var i = 0; i < workDetails.length; i++) {
                  workDetails[i].sortedPos = i;
                }
                c.resumeProfile.workDetails = workDetails;
                c.saveResume(c.resumeProfile);
                Get.back();
                snack(
                    msg: 'Profile Created Successfully',
                    type: SnackType.Success);
              },
              child: Text('Finish')),
        )
      ],
    );
  }
}

class WorkDetailsCard extends StatelessWidget {
  WorkHistoryDetails workDetails;
  void Function()? onEdit;
  void Function()? onDelete;
  WorkDetailsCard(
      {required this.workDetails, Key? key, this.onDelete, this.onEdit})
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
                                  workDetails.time,
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
                            workDetails.title,
                            style: context.textTheme.headline6,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            workDetails.place,
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

class AddWorkDetails extends StatefulWidget {
  WorkHistoryDetails? workDetails;
  AddWorkDetails({Key? key, this.workDetails}) : super(key: key);
  static final GlobalKey<FormState> formkey = GlobalKey();

  @override
  State<AddWorkDetails> createState() => _AddWorkDetailsState();
}

class _AddWorkDetailsState extends State<AddWorkDetails> {
  TextEditingController timeCTRL = TextEditingController();

  TextEditingController titleCTRL = TextEditingController();

  TextEditingController placeCTRL = TextEditingController();

  List<TextEditingController> workExperiences = [];

  @override
  void initState() {
    // TODO: implement initState
    if (this.widget.workDetails != null) {
      timeCTRL.text = this.widget.workDetails!.time;
      titleCTRL.text = this.widget.workDetails!.title;
      placeCTRL.text = this.widget.workDetails!.place;
      for (var i = 0; i < widget.workDetails!.experience.length; i++) {
        workExperiences.add(TextEditingController(
          text: widget.workDetails!.experience[i],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.theme.scaffoldBackgroundColor),
        child: Form(
          key: AddWorkDetails.formkey,
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
                    'Add Work Experience',
                    style: context.textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      CustomTextField(
                        hint: 'Time (e.g. 2018-Present)',
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
                        hint: 'Title (e.g. Scientist Intern)',
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
                        hint: 'Place (e.g. NASA)',
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
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Divider(),
                          ),
                          Text("Add Points to the work experience"),
                          Expanded(
                            flex: 5,
                            child: Divider(),
                          ),
                          GestureDetector(
                            onTap: () async {
                              workExperiences.add(TextEditingController());
                              setState(() {});
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: CustomTextField(
                            hint: index.isEven
                                ? 'Responsible for making Telescope'
                                : 'Cut costs by 32% in less than six months',
                            filled: true,
                            controller: workExperiences[index],
                            keyBoardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                            validator: (v) {
                              if (v!.trim().isEmpty) {
                                return 'Experience cannot be empty';
                              }
                            },
                            onChanged: (v) {},
                            postFixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipOval(
                                  child: GestureDetector(
                                onTap: () {
                                  workExperiences.removeAt(index);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.grey[300]!,
                                  child: Center(
                                    child: Icon(
                                      Icons.clear,
                                      size: 15,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                        itemCount: workExperiences.length,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
                ),
                Container(
                  width: context.width,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: ElevatedButton(
                    onPressed: () {
                      if (AddWorkDetails.formkey.currentState!.validate()) {
                        try {
                          Get.back(
                              result: WorkHistoryDetails(
                                  place: placeCTRL.text,
                                  time: timeCTRL.text,
                                  title: titleCTRL.text,
                                  experience: workExperiences
                                      .map((e) => e.text)
                                      .toList()));
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
                        Text("Add Experience"),
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
      ),
    );
  }
}
