import 'package:flutter/material.dart';
import 'package:todo/shared/constant.dart';
import 'package:todo/view/widgets/CustomShowTasks.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, i) =>  CustomShowTasks( model: tasks[i],),
        separatorBuilder: (context, i) => Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
        itemCount: tasks.length);
  }
}
