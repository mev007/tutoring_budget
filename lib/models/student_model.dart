import 'model.dart';

class StudentModel implements Model {
  static String nameTable = 'Student';

  @override
  String id;
  
  final String firstName;
  final String lastName;
  final String adress;
  final String category;
  final String video;
  final double cost;
  final String note;

  StudentModel({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.adress = '',
    this.category = '',
    this.video = '',
    this.cost = 0,
    this.note = '',
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) => StudentModel(
        id: map['id'],
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        adress: map['adress'] ?? '',
        category: map['category'],
        video: map['video'],
        cost: map['cost'] ?? 0,
        note: map['note'] ?? '',
      );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'adress': adress,
        'category': category,
        'video': video,
        'cost': cost,
        'note': note,
      };
}
