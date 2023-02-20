
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/controller/cubit/states.dart';

import '../../shared/constant.dart';
import '../../view/widgets/archive_tasks.dart';
import '../../view/widgets/done_tasks.dart';
import '../../view/widgets/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(IntialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = const [
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNAvBarState());
  }

  late Database database;

  void createDataBase()  {
  openDatabase('ToDo.db', version: 7,
        onCreate: (database, version) {
      database.execute('''
          CREATE TABLE newtasks
           (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT,status TEXT)
             ''').then((value) => {debugPrint('created')}).catchError((onError) {
            debugPrint(onError.toString());
          });
    }, onOpen: (database) {
      getData(database).then((value) {
        tasks = value;
        emit(GetDataBaseState());
        debugPrint(tasks.toString());
      });
    }, onUpgrade: (database, oldv, newv) async {
      return await database.execute('''
    CREATE TABLE newtasks
           (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT,status TEXT)
          
    ''').then((value) {
        debugPrint('create new task suc');
      }).catchError((onError) {
        debugPrint(onError);
      });
    }).then((value) {
      database=value;
      emit(CreateDataBaseState());
  });
  }

  Future insertDatabase({
    required String title,
    required String time,
    required String data,
  }) async {
    return await database.transaction((txn) async {
      txn.rawInsert('''
    INSERT INTO "newtasks" (title,time,date) VALUES ("$title","$time","$data")
    ''').then((value) {
        debugPrint('$value inserted');
      }).catchError((onError) {});
    });
  }

  Future<int> deleteData() async {
    Database? myDb =  database;
    int response = await myDb.delete('newtasks');
    debugPrint('hussein');

    return response;
  }

  Future<List<Map>> getData(database) async {
    return await database.rawQuery('SELECT * FROM newtasks');
  }
}
