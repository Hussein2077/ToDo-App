import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/controller/cubit/cubit.dart';
import 'package:todo/controller/cubit/states.dart';
import 'package:todo/shared/constant.dart';
import 'package:todo/shared/database_helper.dart';

import 'package:todo/view/widgets/custom_text_form.dart';
late Database database;


class HomePage extends StatelessWidget {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController timeController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool isBottomSheetShown = false;
  IconData iconData = Icons.edit;
  // DataBaseHelper dataBaseHelper = DataBaseHelper();

  HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..createDataBase(),

      child: BlocConsumer<AppCubit,AppStates>(
listener: ( context, state){},
        builder: ( context,state){
          AppCubit cubit=AppCubit.get(context);
  return  Scaffold(
    key: scaffoldKey,
    appBar: AppBar(
      title: const Text('ToDo'),
    ),
    body: ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (BuildContext context) {
        return cubit.screens[cubit.currentIndex];
      },
      fallback: (BuildContext context) {
        return tasks.isEmpty? const Center(child: Text('There is no tasks yet!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.teal,
          ),
        )) : const Center(child: CircularProgressIndicator());
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        if (isBottomSheetShown) {
          if (formKey.currentState!.validate()) {
            // dataBaseHelper
            //     .insertDatabase(
            //     title: taskController.text,
            //     time: timeController.text,
            //     data: dateController.text)
            //     .then((value) {
            //   Navigator.pop(context);
            //   isBottomSheetShown = false;
            //   //
            //   // setState(() {
            //   //   iconData = Icons.edit;
            //   // });
            // });
          }
        } else {
          scaffoldKey.currentState!
              .showBottomSheet(
                (context) => Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(
                    controller: taskController,
                    hintText: 'New Task',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.task),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Task must be not empty';
                      } else {
                        return null;
                      }
                    },
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return 'Time must be not empty';
                        } else {
                          return null;
                        }
                      },
                      controller: timeController,
                      hintText: 'Time',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.watch_later_outlined),
                      type: TextInputType.datetime,
                      onTap: () {
                        debugPrint('on tap');
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          timeController.text =
                              value!.format(context).toString();
                        });
                      }),
                  const SizedBox(height: 15),
                  MyTextField(
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return 'Date must be not empty';
                        } else {
                          return null;
                        }
                      },
                      controller: dateController,
                      hintText: 'Date',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.date_range),
                      type: TextInputType.datetime,
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050))
                            .then((value) {
                          dateController.text =
                              DateFormat.yMMMd().format(value!);
                        });
                      })
                ],
              ),
            ),
          )
              .closed
              .then((value) {
            isBottomSheetShown = false;

            // setState(() {
            //   iconData = Icons.edit;
            // });
          });
          isBottomSheetShown = true;

          // setState(() {
          //   iconData = Icons.add;
          // });
        }
      },
      child: Icon(iconData),
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: cubit.currentIndex,
      onTap: (i) {
cubit.changeIndex(i);        // setState(() {});
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.task,
            ),
            label: 'Tasks'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: 'Done'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archive'),
      ],
    ),
  );
        },

      ),
    );
  }
}
