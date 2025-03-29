class dataModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  const dataModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory dataModel.fromJson(Map<String, dynamic> json) {
    return dataModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
