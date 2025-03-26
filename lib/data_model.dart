class DataModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  const DataModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
