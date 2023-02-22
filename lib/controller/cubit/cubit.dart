import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/controller/cubit/states.dart';

import '../../view/widgets/archive_tasks.dart';
import '../../view/widgets/done_tasks.dart';
import '../../view/widgets/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(IntialState());
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

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

  void createDataBase() {
    openDatabase('ToDo.db', version: 7, onCreate: (database, version) {
      database
          .execute('''
          CREATE TABLE newtasks
           (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT,status TEXT)
             ''')
          .then((value) => {debugPrint('created')})
          .catchError((onError) {
            debugPrint(onError.toString());
          });
    }, onOpen: (database) {
      getData(database);
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
      database = value;
      emit(CreateDataBaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database.rawUpdate('''
    UPDATE newtasks SET status =? WHERE id =? 
    ''', [status, id]).then((value) {
      getData(database);
      emit(UpdateDataBaseState());
    });
  }

  Future insertDatabase({
    required String title,
    required String time,
    required String data,
  }) async {
    await database.transaction((txn) async {
      txn.rawInsert('''
    INSERT INTO "newtasks" (title,time,date,status) VALUES ("$title","$time","$data","new")
    ''').then((value) {
        debugPrint('$value inserted');
        emit(InsertDataBaseState());
        getData(database);
      }).catchError((onError) {});
    });
  }

void deleteData({
  required int id
}) async {

    database.rawDelete('DELETE FROM newtasks WHERE id =?',[id])
    .then((value) {
      getData(database);
      emit(DeleteDataBaseState());
    });


  }

  getData(database) async {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    emit(GetDataBaseState());
     database.rawQuery('SELECT * FROM newtasks').then((value){


       value.forEach((element) {
  if (element['status']=='new'){
    newTasks.add(element);
  }
  else if (element['status']=='done'){
    doneTasks.add(element);
  }else if(element['status']=='archive') {
   archiveTasks.add(element);

  }

       });
     });
  }

  bool isBottomSheetShown = false;
  IconData iconData = Icons.edit;

  void changeBottonSheetBar({required bool botton, required IconData icon}) {
    isBottomSheetShown = botton;
    iconData = icon;
    emit(ChangeBottonSheetState());
  }
}
