import 'package:flutter/material.dart';

import 'package:build_my_garden/helpers/appcolors.dart';
import 'package:build_my_garden/models/category.dart' as category;
import 'package:flutter/foundation.dart';

class Utils {
  static List<category.Category> getMockedCategories() {
    return [
      category.Category(
          color: AppColors.first,
          name: "Sustainable \nFarming Practices \nfor our Environment",
          imgName: "img1",
          subCategories: []),
      category.Category(
          color: AppColors.second,
          name: "Homemade \nCompost from \nyour Kitchen",
          imgName: "img2",
          subCategories: []),
      category.Category(
          color: AppColors.third,
          name: "Boxed Planting \nfor Urban areas",
          imgName: "img3",
          subCategories: []),
      category.Category(
          color: AppColors.fourth,
          name: "Save our Soil",
          imgName: "img4",
          subCategories: [])
    ];
  }
}
