class MealEntity {
  int? id;
  String? title;
  String? calories;
  String? carbs;
  String? protein;
  String? fat;
  String? ingredients;
  String? description;
  String? image;
  String? mealType;
  String? time;

  MealEntity({
      this.id,
      this.title,
      this.calories,
      this.carbs,
      this.protein,
      this.fat,
      this.ingredients,
      this.description,
      this.image,
      this.mealType,
      this.time
  });

  toMap() {
    return {
      'id': id,
      'title': title,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'ingredients': ingredients,
      'description': description,
      'image': image,
      'mealType': mealType,
      'time': time

    };
  }
}
