import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/create-profile/education_details_form.dart';
import 'package:resume_builder/modules/create-profile/personal_details_form.dart';
import 'package:resume_builder/modules/create-profile/profile_form_controller.dart';
import 'package:resume_builder/modules/create-profile/skill_details_form.dart';
import 'package:resume_builder/modules/create-profile/summary_details_form.dart';
import 'package:resume_builder/modules/create-profile/work_history_form.dart';
import 'package:timelines/timelines.dart';
import 'dart:math';

class ProfileForm extends StatelessWidget {
  var c = Get.find<ProfileFormController>();
  ProfileForm({Key? key}) : super(key: key);
  List<Widget> formSteps = <Widget>[
    PersonalDetailsForm(),
    SummaryDetailsForm(),
    EducationDetailsForm(),
    SkillDetailsForm(),
    WorkHistoryForm()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: c.resumeProfile.label.isEmpty
              ? Text('Create Profile')
              : Text("Create ${c.resumeProfile.label}")),
      body: Column(
        children: [
          Container(
            height: 80,
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                connectorTheme: ConnectorThemeData(
                  space: 10.0,
                  thickness: 5.0,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemExtentBuilder: (_, __) => context.width / formSteps.length,
                contentsBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      c.formStepsName[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: c.currentFormColor(context, index),
                      ),
                    ),
                  );
                },
                indicatorBuilder: (_, index) {
                  return Obx(() {
                    var color;
                    var child;
                    if (index == c.currentProfileStep()) {
                      color = c.currentDotColor(context);
                      child = Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.circle,
                            size: 12,
                          ));
                    } else if (index < c.currentProfileStep()) {
                      color = c.prevDotColor(context);
                      child = Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12.0,
                      );
                    } else {
                      color = context.theme.disabledColor;
                    }
                    if (index <= c.currentProfileStep()) {
                      return Stack(
                        children: [
                          CustomPaint(
                            size: Size(20.0, 20.0),
                            painter: _BezierPainter(
                              color: color,
                              drawStart: index > 0,
                              drawEnd: index < c.currentProfileStep(),
                            ),
                          ),
                          DotIndicator(
                            size: 20.0,
                            color: color,
                            child: child,
                          ),
                        ],
                      );
                    } else {
                      return Stack(
                        children: [
                          CustomPaint(
                            size: Size(12.0, 12.0),
                            painter: _BezierPainter(
                              color: color,
                              drawEnd: index < formSteps.length - 1,
                            ),
                          ),
                          OutlinedDotIndicator(
                            borderWidth: 4.0,
                            color: color,
                          ),
                        ],
                      );
                    }
                  });
                },
                connectorBuilder: (_, index, type) {
                  if (index > 0) {
                    if (index == c.currentProfileStep()) {
                      final prevColor = c.currentFormColor(context, index - 1);
                      final color = c.currentFormColor(context, index);
                      List<Color> gradientColors;
                      if (type == ConnectorType.start) {
                        gradientColors = [
                          Color.lerp(prevColor, color, 0.5)!,
                          color
                        ];
                      } else {
                        gradientColors = [
                          prevColor,
                          Color.lerp(prevColor, color, 0.5)!
                        ];
                      }
                      return DecoratedLineConnector(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                          ),
                        ),
                      );
                    } else {
                      return SolidLineConnector(
                        color: c.currentFormColor(context, index),
                      );
                    }
                  } else {
                    return null;
                  }
                },
                itemCount: formSteps.length,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Expanded(child: formSteps[c.currentProfileStep()]),
          ),
        ],
      ),
    );
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
