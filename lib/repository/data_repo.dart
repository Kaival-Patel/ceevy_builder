import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/category/category_model.dart';
import 'package:resume_builder/styles/app-assets.dart';

DataRepo dataRepo = Get.put(DataRepo(), permanent: true);

class DataRepo extends GetxController {
  List<CVCategory> trendingCategories = [];
  List<CVCategory> categories = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addTrendingCategories();
    addAllCategories();
  }

  addTrendingCategories() {
    trendingCategories.add(CVCategory(
      name: 'MINIMAL',
      asset: AppAssets.minimal_ct,
      status: 1,
    ));
    trendingCategories.add(CVCategory(
      name: 'SUPER',
      asset: AppAssets.super_ct,
      status: 1,
    ));
    trendingCategories.add(CVCategory(
      name: 'PROFESSIONAL',
      status: 1,
      asset: AppAssets.pro_ct,
    ));
  }

  addAllCategories() {
    categories = [
      ...trendingCategories,
      CVCategory(
        name: 'SIMPLE',
        asset: AppAssets.simple_ct,
        status: 1,
      ),
      CVCategory(
        name: 'MODERN',
        asset: AppAssets.modern_ct,
        status: 1,
      )
    ];
  }
}
