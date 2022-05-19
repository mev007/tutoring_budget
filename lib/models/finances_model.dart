import 'package:tutoring_budget/utils.dart';

import 'model.dart';

class FinanceModel implements Model {
  static String nameTable = 'Finances';

  @override
  String id;
  
  final String idStudent;
  final DateTime dateTime;
  final double sum;

  FinanceModel({
    required this.id,
    required this.idStudent,
    required this.dateTime,
    required this.sum,
  });

  factory FinanceModel.fromMap(Map<String, dynamic> map) => FinanceModel(
        id: map['id'],
        idStudent: map['idStudent'] ?? '',
        dateTime: Utils.integerToDateTime(map['dateTime']),
        sum: map['sum'] ?? 0,
      );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'dateTime': Utils.integerFromDateTime(dateTime),
        'idStudent': idStudent,
        'sum': sum,
      };
}
