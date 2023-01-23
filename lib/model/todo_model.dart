import 'dart:convert';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  TodoModel({
    required this.title,
    required this.description,
    required this.creationDate,
    required this.completed,
    required this.uid,
    required this.productId,
  });

  String title;
  String description;
  String creationDate;
  bool completed;
  String uid;
  String productId;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    title: json["Title"],
    description: json["Description"],
    creationDate: json["CreationDate"],
    completed: json["Completed"],
    uid : json['Uid'],
    productId: json['ProductId'],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Description": description,
    "CreationDate": creationDate,
    "Completed": completed,
    "Uid": uid,
    "ProductId": productId,

  };
}
