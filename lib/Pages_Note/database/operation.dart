import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'LocalDataBase.dart';

class OperationdataInsert {
  final List colors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.amber,
    Colors.amberAccent,
    Colors.black45,
    Colors.cyan,
    Colors.cyan,
    Colors.greenAccent,
    Colors.deepPurple,
    Colors.lightBlueAccent
  ];
  SqlDb database = SqlDb();
  InsertData(String title, String note, Color passedColor) async {
    int response = await database.insertData('''
              INSERT INTO notes (`title`,`note`,`color`)
              VALUES  ("${title}","${note}","${passedColor}")
             ''');
    return response;
  }

  Future<List<Map>> redData(String massage) async {
    List<Map> response = await database.readData(massage);
    return response;
  }

  Future<List<Map>> ReadRow(int row) async {
    List<Map> response =
        await database.readData('SELECT * FROM notes WHERE id  = ${row}');
    return response;
  }

  UpdataData(String title, String note, Color passedColor , int id) async {
    var  response = await database.updateData(''' UPDATE notes SET title = "${title}", note  = "${note}",color = "${passedColor}" WHERE id = ${id} ''');
    print(response);

    return response;
  }


  DeleteData(int id) async {
    int  response = await database.deleteData("DELETE FROM notes WHERE id = ${id} ");
    print("$response") ;
    print("+++++++++++++++++++++++++++++++++++++") ;
    return response;
  }



  DeleteDataAll() async {
      await database.deleteAllData();

  }



}
