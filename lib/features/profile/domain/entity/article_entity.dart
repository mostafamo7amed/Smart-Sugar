class ArticleEntity {
  final String? id;
  final String title;
  final String description;
  final String image;
  final String date;

  ArticleEntity(
      {this.id,
        required this.date,
      required this.title,
      required this.description,
      required this.image});

  factory ArticleEntity.formMap(Map<String, dynamic> map) {
    return ArticleEntity(
        id: map['id'],
        date: map['date'],
        title: map['title'],
        description: map['description'],
        image: map['image']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'date': date
    };
  }
}
