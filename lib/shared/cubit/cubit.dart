import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/Archived_Tasks/Done_Tasks/New_Tasks/newTasks.dart';
import 'package:flutter_application_1/modules/Archived_Tasks/Done_Tasks/done.dart';
import 'package:flutter_application_1/modules/Archived_Tasks/archived.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppsState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> Screens = [
    newTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  var database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];

  List<Map> archivedtasks = [];

  void createdatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT, time INT,date INT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDatafromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,time,date,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDataBaseState());
        getDatafromDatabase(database);
      }).catchError((error) {
        print('error when inserting new record ${error.toString()}');
      });
      return null;
    });
  }

  void getDatafromDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];
    emit(AppGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.foreach((element) {
        if (element['status' == 'new'])
          newtasks.add(element);
        else if (element['status' == 'done'])
          donetasks.add(element);
        else
          archivedtasks.add(element);
      });

      emit(AppGetDataBaseState());
    });
  }

  void updataData({
    required String status,
    required int id,
  }) async {
    await database.rawUpdate(
      'UPDATE tasks SET status = ?, WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDatafromDatabase(database);
      emit(AppupdatetDataBaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void ChangeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
