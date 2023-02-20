// import 'package:flutter/cupertino.dart';
// import 'package:sqflite/sqflite.dart';
//
// import 'constant.dart';
//
// class DataBaseHelper {
//   late Database database;
//   void createDataBase() async {
//     database = await openDatabase(
//         'ToDo.db',
//         version: 7,
//         onCreate: (database, version) {
//           database.execute('''
//           CREATE TABLE newtasks
//            (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT,status TEXT)
//              ''').then((value) => {
//             print('created')
//           }).catchError((onError) {
//             debugPrint(onError.toString());
//           });
//         },
//         onOpen: (database) {
//
//           getData(database).then((value) {
// tasks=value;
//           print(tasks);
//           });
//
//
//         },onUpgrade: (database,oldv,newv)async{
//       return await  database.execute('''
//     CREATE TABLE newtasks
//            (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT,status TEXT)
//
//     ''').then((value) {
//         print('create new task suc');
//       }).catchError((onError){
//         print(onError);
//       });
//     }
//     );
//   }
//
//   Future insertDatabase({
//     required String title,
//     required String time,
//     required String data,
//   }) async {
//     return await database.transaction((txn) async {
//       txn.rawInsert('''
//     INSERT INTO "newtasks" (title,time,date) VALUES ("$title","$time","$data")
//     ''').then((value) {
//         print('$value inserted');
//       }).catchError((onError) {});
//     });
//   }
//  Future<int> deleteData()async{
//     Database? mydb=await database;
//     int response=await mydb.delete('newtasks');
//     print('hussein');
//
//     return response;
//   }
//   Future <List<Map>> getData(database)async{
//     return await database.rawQuery('SELECT * FROM newtasks');
//   }
//
// }
