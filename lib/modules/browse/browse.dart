import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/category/category_model.dart';
import 'package:resume_builder/modules/browse/browse_controller.dart';
import 'package:resume_builder/modules/resume/resume_list.dart';
import 'package:resume_builder/repository/data_repo.dart';

class Browse extends StatelessWidget {
  Browse({Key? key}) : super(key: key);
  var c = Get.put(BrowseController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
            CategoriesBar()
          ],
        ),
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
              itemBuilder: (context, index) => Padding(
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
              itemBuilder: (context, index) => Padding(
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
