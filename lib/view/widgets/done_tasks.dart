import 'package:flutter/material.dart';
class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Done Task',
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
      ),
    ));
  }
}
