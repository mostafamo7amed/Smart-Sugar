class MessageModel {
  String? text;
  bool isGPT;
  String? dateTime;

  MessageModel({
    this.text,
    this.dateTime,
    required this.isGPT
  });

}