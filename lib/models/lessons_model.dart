import 'package:tutoring_budget/utils.dart';

import 'model.dart';

class LessonsModel implements Model {
  static String nameTable = 'Lessons';

  @override
  String id;
  
  final DateTime dateTime;
  final String idStudent;
  final double cost;
  double balance; // Для відображення зелени/червоним кольором.

  LessonsModel({
    required this.id,
    required this.dateTime,
    required this.idStudent,
    required this.cost,
    this.balance = 0,
  });

  factory LessonsModel.fromMap(Map<String, dynamic> map) => LessonsModel(
        id: map['id'],
        dateTime: Utils.integerToDateTime(map['dateTime']),
        idStudent: map['idStudent'] ?? '',
        cost: map['cost'] ?? 0,
      );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'dateTime': Utils.integerFromDateTime(dateTime),
        'idStudent': idStudent,
        'cost': cost,
      };
}
