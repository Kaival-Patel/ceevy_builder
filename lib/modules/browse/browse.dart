import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/category/category_model.dart';
import 'package:resume_builder/modules/browse/browse_controller.dart';
import 'package:resume_builder/modules/resume/resume_list.dart';
import 'package:resume_builder/repository/data_repo.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/utils/widgets/suggestion_widget.dart';
import 'package:share_plus/share_plus.dart';

class Browse extends StatelessWidget {
  Browse({Key? key}) : super(key: key);
  var c = Get.put(BrowseController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderBar(),
                SizedBox(
                  height: 15,
                ),
                TrendingCVBar(),
                SizedBox(
                  height: 15,
                ),
                CategoriesBar(),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ComingSoonBar(),
        ],
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  HeaderBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CEEVY Builder',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text('Choose CV\'s and build your own from below',
                  style: TextStyle(
                    color: context.theme.disabledColor,
                  ))
            ],
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }
}

class TrendingCVBar extends StatelessWidget {
  TrendingCVBar({Key? key}) : super(key: key);
  var c = Get.find<BrowseController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 250,
            child: ListView.builder(
              itemCount: c.bgAssets.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                    child: TrendingCard(
                        bgAsset: c.bgAssets[index],
                        category: dataRepo.trendingCategories[index]),
                  ),
            ))
      ],
    );
  }
}

class TrendingCard extends StatelessWidget {
  String bgAsset;
  CVCategory category;

  TrendingCard({required this.bgAsset, required this.category, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: category.resumeList.isEmpty
          ? null
          : () {
        Get.to(ResumeList(
          category: category,
        ));
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 200,
        child: Stack(
          children: [
            Image.asset(
              bgAsset,
              width: 200,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  category.asset,
                  height: 200,
                  width: 130,
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesBar extends StatelessWidget {
  CategoriesBar({Key? key}) : super(key: key);
  var c = Get.find<BrowseController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              size: 18,
              color: context.theme.disabledColor,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 180,
            child: ListView.builder(
              itemCount: dataRepo.categories.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                      child: CategoryCard(
                        category: dataRepo.categories[index],
                      )),
            ))
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  CVCategory category;

  CategoryCard({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: category.resumeList.isEmpty
          ? null
          : () {
        Get.to(ResumeList(
          category: category,
        ));
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 170,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.5,
                  color: context.theme.disabledColor.withOpacity(0.1))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  category.asset,
                  height: 140,
                  width: 80,
                  fit: BoxFit.cover,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40,
              child: Center(
                  child: Text(
                    category.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
            ),
          )
        ]),
      ),
    );
  }
}

class ComingSoonBar extends StatelessWidget {
  ComingSoonBar({Key? key}) : super(key: key);
  var c = Get.find<BrowseController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 300,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                        color: context.theme.accentColor.withOpacity(0.5)),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: context.width * 0.5,
                                child: Text(
                                  "We are working on more resume templates",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: context.theme.primaryColor),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: context.width * 0.5,
                                child: Text(
                                  'Meanwhile you can share this app with your friends and family',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: context.theme.primaryColor),
                                    onPressed: () {
                                      Share.share('Get Ceevy Builder',
                                          subject:
                                          "Download Ceevy Builder from playstore and create awesome resumes that could look impressive to interviewer");
                                    },
                                    child: Text("Share")),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ClipRRect(
                              child: Image.asset(
                                AppAssets.planet,
                                height: 40,
                                width: 40,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, top: 17),
                    child: Transform.rotate(
                      angle: -50 / 360,
                      child: Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFCBC5F0),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Transform.rotate(
                      angle: 20 / 360,
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.theme.primaryColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Image.asset(
                                  AppAssets.peopleAvatar,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Kaival Patel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "App Developer",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.bottomSheet(SuggestionWidget(
                                      title: 'Suggest new feature',
                                      subject: 'Let me suggest a new feature',
                                      description: 'Our app should have '),isScrollControlled: true);
                                },
                                child: Text(
                                  "Suggest new features",
                                  style: TextStyle(
                                      fontSize: 11,
                                      decoration: TextDecoration.underline),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
