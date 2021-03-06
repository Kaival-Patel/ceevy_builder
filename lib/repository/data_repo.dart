import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/category/category_model.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:resume_builder/modules/resume/simple/aztec/aztec.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/utils/classes/resume_aztec_class.dart';
import 'package:resume_builder/utils/classes/resume_cache_class.dart';
import 'package:resume_builder/utils/classes/resume_inferno_class.dart';
import 'package:resume_builder/utils/classes/resume_mirage_class.dart';
import 'package:resume_builder/utils/classes/resume_overpass_class.dart';

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
    var cache = CVCategory(
      name: 'MINIMAL',
      asset: AppAssets.minimal_ct,
      resumeList: [CacheResume()],
      status: 1,
    );
    trendingCategories.add(cache);
    var inferno = CVCategory(
      name: 'SUPER',
      asset: AppAssets.super_ct,
      status: 1,
    );
    inferno.resumeList=[InfernoResume()];
    trendingCategories.add(inferno);
    var overpass = CVCategory(
      name: 'PROFESSIONAL',
      status: 1,
      asset: AppAssets.pro_ct,
    );
    overpass.resumeList=[OverpassResume()];
    trendingCategories.add(overpass);
  }

  addAllCategories() {
    var simple_ct = CVCategory(
      name: 'SIMPLE',
      asset: AppAssets.simple_ct,
      status: 1,
    );
    simple_ct.resumeList = [AztecResume()];
    var modern_ct = CVCategory(
      name: 'MODERN',
      asset: AppAssets.modern_ct,
      status: 1,
    );
    modern_ct.resumeList = [MirageResume()];
    categories = [...trendingCategories, simple_ct, modern_ct];
  }
}
