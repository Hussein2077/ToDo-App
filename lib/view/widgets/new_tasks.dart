import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/controller/cubit/states.dart';
import 'package:todo/shared/constant.dart';
import 'package:todo/view/widgets/CustomShowTasks.dart';

import '../../controller/cubit/cubit.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
listener: (context,state){},
    builder: (context,state){
      AppCubit cubit=AppCubit.get(context);
  return ListView.separated(
      itemBuilder: (context, i) =>  CustomShowTasks( model: cubit.tasks[i],),
      separatorBuilder: (context, i) => Container(
        height: 1.0,
        width: double.infinity,
        color: Colors.grey[300],
      ),
      itemCount: cubit.tasks.length);
    },
    );
  }
}
