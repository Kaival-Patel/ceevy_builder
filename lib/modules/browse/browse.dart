import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/browse/browse_controller.dart';

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
              height: 10,
            ),
            TrendingCVBar()
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: context.height * 0.3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: c.bgAssets
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4),
                            child: TrendingCard(bgAsset: e),
                          ))
                      .toList()),
            ))
      ],
    );
  }
}

class TrendingCard extends StatelessWidget {
  String bgAsset;
  TrendingCard({required this.bgAsset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(
        bgAsset,
      ),
    );
  }
}
