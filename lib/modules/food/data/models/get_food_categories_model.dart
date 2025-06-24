import '../../domain/entities/food_categories_entity.dart';

class GetFoodCategoriesModel {
  List<Categories>? categories;

  GetFoodCategoriesModel({this.categories});

  GetFoodCategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<FoodCategoryEntity> toEntity() {
    if (categories == null) return [];
    return categories!.map((category) => category.toEntity()).toList();
  }
}

class Categories {
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Categories({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCategory'] = idCategory;
    data['strCategory'] = strCategory;
    data['strCategoryThumb'] = strCategoryThumb;
    data['strCategoryDescription'] = strCategoryDescription;
    return data;
  }

  FoodCategoryEntity toEntity() {
    return FoodCategoryEntity(
      idCategory: idCategory ?? '',
      strCategory: strCategory ?? '',
      strCategoryThumb: strCategoryThumb ?? '',
      strCategoryDescription: strCategoryDescription ?? '',
    );
  }
}
