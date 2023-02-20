import 'package:flutter/material.dart';
class CustomShowTasks extends StatelessWidget {
  const CustomShowTasks({Key? key, required this.model}) : super(key: key);
final Map model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
           CircleAvatar(
            radius: 40,
            child: Text(
              '${model['time']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                '${model['title']}',
                style:const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const  SizedBox(height: 5,),
              Text('${model['date']}',
                  style:const TextStyle(fontSize: 15, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
