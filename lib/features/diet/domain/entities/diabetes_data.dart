class DiabetesData {
  final DiabetesType type1;
  final DiabetesType type2;

  DiabetesData({required this.type1, required this.type2});

  factory DiabetesData.fromJson(Map<String, dynamic> json) {
    return DiabetesData(
      type1: DiabetesType.fromJson(json['type_1_diabetes']),
      type2: DiabetesType.fromJson(json['type_2_diabetes']),
    );
  }
}

class DiabetesType {
  final Map<String, String> importantTips;
  final List<MealPlan> mealPlans;
  final Map<String, String> suitableExercises;
  final String note;

  DiabetesType({
    required this.importantTips,
    required this.mealPlans,
    required this.suitableExercises,
    required this.note,
  });

  factory DiabetesType.fromJson(Map<String, dynamic> json) {
    return DiabetesType(
      importantTips: Map<String, String>.from(json['important_tips']),
      mealPlans: (json['meal_plan'] as List)
          .map((plan) => MealPlan.fromJson(plan))
          .toList(),
      suitableExercises: Map<String, String>.from(json['suitable_exercises']),
      note: json['note'],
    );
  }
}

class MealPlan {
  final String day;
  final String breakfast;
  final String lunch;
  final String dinner;
  final String snacks;

  MealPlan({
    required this.day,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      day: json['day'],
      breakfast: json['breakfast'],
      lunch: json['lunch'],
      dinner: json['dinner'],
      snacks: json['snacks'],
    );
  }
}
