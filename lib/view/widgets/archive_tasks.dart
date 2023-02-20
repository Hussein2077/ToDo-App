import 'package:flutter/material.dart';

import '../../shared/database_helper.dart';
class ArchiveTasks extends StatelessWidget {
  const ArchiveTasks({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // DataBaseHelper dataBaseHelper = DataBaseHelper();
    return  Center(child: Column(
      children: [
        const  Text('Archive Task',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),
        ),
        ElevatedButton(onPressed: (){
          // dataBaseHelper.deleteData();
        }, child: const Icon(Icons.delete))
      ],
    ));
  }
}
