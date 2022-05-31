import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/onboarding/onboarding_controller.dart';
import 'package:resume_builder/styles/app-colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  var c = Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Obx(
          () => Align(
            alignment: c.models[c.index].alignment,
            child: AnimatedContainer(
              curve: Curves.ease,
              duration: Duration(milliseconds: 300),
              height: c.models[c.index].height,
              width: c.models[c.index].width,
              decoration: BoxDecoration(
                color: c.models[c.index].bgCurveColor,
                borderRadius: c.models[c.index].radius,
              ),
              alignment: c.models[c.index].alignment,
            ),
          ),
        ),
        PageView.builder(
          controller: c.smController,
          itemBuilder: (context, index) => Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      c.models[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        c.models[index].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: context.theme.disabledColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onPageChanged: (index) => c.page.value = index,
          itemCount: c.models.length,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmoothPageIndicator(
                  controller: c.smController,
                  count: c.models.length,
                  effect: ExpandingDotsEffect(
                      dotHeight: 5,
                      dotWidth: 5,
                      activeDotColor: context.theme.primaryColor),
                  onDotClicked: (i) {},
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: Get.width * 0.9,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Get Started',
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
