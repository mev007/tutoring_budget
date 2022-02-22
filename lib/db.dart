import 'dart:async';
import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tutoring_budget/utils.dart';

import 'models/model.dart';

abstract class DB {
  static Database? _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) return;
    try {
      var databasesPath = await getDatabasesPath();
      String _path = join(databasesPath, 'Tutor.db');
      print('>>> Path >>>$_path');

      ///Відкриває БД і якщо немає таблиць, то створює їх
      _db = await openDatabase(_path, version: _version,
          onCreate: (db, ver) async {
        await db.execute("""
        CREATE TABLE "Student" (
	        "id"	TEXT PRIMARY KEY,
	        "firstName"	TEXT,
	        "lastName"	TEXT,
	        "adress"	TEXT,
	        "category"	TEXT,
	        "video"	TEXT,
	        "cost"	REAL,
	        "note"	TEXT
        )""");
        await db.execute("""
        CREATE TABLE "Lessons" (
	        "id"	TEXT PRIMARY KEY,
	        "dateTime"	INTEGER,
	        "idStudent"	TEXT,
	        "cost"	REAL
        )""");
        await db.execute("""
        CREATE TABLE "Finances" (
	        "id"	TEXT PRIMARY KEY,
	        "idStudent"	TEXT,
	        "dateTime"	INTEGER,
	        "sum"	REAL
        )""");
      });
    } catch (ex) {
      log('Error open/create: ${ex.toString()}');
    }
  }

  ///Показує список map заданої таблиці [table]
  static Future<List<Map<String, dynamic>>?> query(String table) async {
    try {
      return await _db?.query(table);
    } catch (e) {
      log('Error query: ${e.toString()}');
    }
  }

  ///Вставляє map [model] в задану таблицю [table]
  static Future<void> insert(String table, Model model) async {
    try {
      await _db?.insert(
        table,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      log('Error insert: ${e.toString()}');
    }
  }

  ///Видаляє з [table] записи із заданими [id]
  static Future<void> deleteFromId(String table, String id) async {
    try {
      final response =
          await _db?.delete(table, where: 'id = ?', whereArgs: [id]);
      log('>>> Видалено із таблиці: $table записів $response');
    } catch (e) {
      log('Error delete: ${e.toString()}');
    }
  }

  /// Вибірка з [table] по полю [columnDate] даних за заданий період дати
  /// з [firstDay]  по [lastDay]
  static Future<List<Map<String, dynamic>>?> queryDateBetween(String table,
      String columnDate, DateTime firstDay, DateTime lastDay) async {
    try {
      final firstInt = Utils.integerFromDateTime(firstDay);
      final lastInt = Utils.integerFromDateTime(lastDay);
      final sqlString =
          "SELECT * FROM $table WHERE $columnDate BETWEEN $firstInt AND $lastInt";
      final response = await _db?.rawQuery(sqlString);
      return response;
    } catch (e) {
      log('Error query: ${e.toString()}');
    }
  }

  /// Вибірка з [table] по полю [columnDate] даних по заданому параметру [id]
  static Future<List<Map<String, dynamic>>?> queryDateOnId(
      String table, String columnDate, String id) async {
    try {
      final sqlString = "SELECT * FROM $table WHERE $columnDate=\"$id\"";
      final response = await _db?.rawQuery(sqlString);
      return response;
    } catch (e) {
      log('Error query: ${e.toString()}');
    }
  }

/*
  ///Очищає все та вставляє дані в таблицю City
  static Future<void> insertCity(City? city) async {
    final value = {
      'id': city?.id,
      'name': city?.name,
      'country': city?.country,
    };
    try {
      await _db?.delete('City');
      await _db?.insert('City', value);
    } catch (e) {
      print('insertCity>>> $e');
    }
  }

  ///Очищає все та вставляє дані в таблицю WeatherList
  static Future<void> insertWeatherList(List<WeatherList> list) async {
    // list.removeRange(5, list.length);
    await _db?.delete('WeatherList');
    for (var item in list) {
      final value = {
        'dt': item.dt,
        'temp': item.main.temp,
        'pressure': item.main.pressure,
        'humidity': item.main.humidity,
        'description': item.weather[0].description,
        'speed': item.wind.speed,
      };
      try {
        await _db?.insert(
          'WeatherList',
          value,
        );
      } catch (e) {
        print('insertWeatherList>>> $e');
      }
    }
  }

  // static Future<void> update(String table, Model model) async {
  //   try {
  //     await _db.update(
  //       table,
  //       model.toMap(),
  //       where: 'id = ?',
  //       whereArgs: [model.id],
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // static Future<int> delete(String table, Model model) async =>
  //     await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);

  ///Читає дані з БД в модельку WeatherModel
  static Future<WeatherModel> readModel() async {
    final city = await query('City').then((value) => City(
          value?[0]['id'] ?? 0,
          value?[0]['name'] ?? '',
          value?[0]['country'] ?? '',
        ));
    final listWeather = await query('WeatherList').then((value) {
      return value
          ?.map((e) => WeatherList(
                e['dt'].toInt(),
                Main(
                  e['temp'].toDouble(),
                  e['pressure'].toDouble(),
                  e['humidity'].toDouble(),
                ),
                [
                  Weather(
                    e['description'].toString(),
                    'icon',
                  )
                ],
                Wind(
                  e['speed'].toDouble(),
                ),
              ))
          .toList();
    });
    return WeatherModel('0', 'cash', list: listWeather, city: city);
  } */
}
