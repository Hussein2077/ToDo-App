import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/home_page.dart';

import 'controller/cubit/bloc_observer.dart';

void main() {  Bloc.observer = MyBlocObserver();

runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(

        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}