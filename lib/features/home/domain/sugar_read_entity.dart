class SugarReadEntity {
  final String id;
  final String userId;
  final int sugarRead;
  final String date;
  final String measureTime;
  final String result;

  SugarReadEntity(this.id,this.userId, this.sugarRead, this.date, this.measureTime, this.result);

  factory SugarReadEntity.fromJson(Map<String, dynamic> json) {
    return SugarReadEntity(json['id'], json['userId'], json['sugarRead'], json['date'], json['type'], json['result']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['sugarRead'] = sugarRead;
    data['date'] = date;
    data['type'] = measureTime;
    data['result'] = result;
    return data;
  }
}