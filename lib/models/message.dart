class Message {
  String? title;
  String? body;
  String? image;
  String? topic;

  Message({
    this.title,
    this.body,
    this.image,
    this.topic,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        title: json['title'],
        body: json['body'],
        image: json['image'],
        topic: json['topic'],
      );

  static List<Message> fromJsonList(List jsonList) =>
      jsonList.map((item) => Message.fromJson(item)).toList();

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "image": image,
        "topic": topic,
      };

  Map<String, dynamic> toJsonNotification() => {
        "title": title,
        "body": body,
        "image": image,
      };
}
