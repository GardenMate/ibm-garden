import 'dart:html';

import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Container(
              color: Colors.white,
              child: Center(
                  child: AppText(
                text: "Sustainable ming Practices",
                size: 30,
              )),
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 5, bottom: 10),
            ),
          ),
          pinned: true,
          backgroundColor: Color.fromARGB(255, 255, 228, 182),
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/CategoryPageImg/img5.gif",
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Text(
                "Through decades of science and practice, the following farming practices have proven effective in achieving sustainability, especially when used in combination:Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations."),
          ),
        )
      ],
    ));
  }
}
