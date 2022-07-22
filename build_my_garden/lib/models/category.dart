import 'dart:ui';

class Category{
  String name;  
  Color color;
  String imgName;
  List<Category> subCategories;


  Category(
    {
      required this.name,
      required this.color,
      required this.imgName,
      required this.subCategories
    }
  );
  
}