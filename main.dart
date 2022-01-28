import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Bmi_calc.dart';
import 'package:flutter_application_1/Layouts/homeLayout.dart';
import 'package:flutter_application_1/bmi_result_screen.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/shared/bloc_observer.dart';
import 'package:flutter_application_1/users.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeLayout(),
    );
  }
}
