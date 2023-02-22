import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubit/cubit.dart';
import '../../controller/cubit/states.dart';
import 'CustomShowTasks.dart';
class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit=AppCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, i) =>  CustomShowTasks( model: cubit.doneTasks[i],),
            separatorBuilder: (context, i) => Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            itemCount: cubit.doneTasks.length);
      },
    );
  }
}
