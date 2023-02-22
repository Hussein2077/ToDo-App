import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
    AppCubit cubit = AppCubit.get(context);

    return ConditionalBuilder(
      condition: cubit.newTasks.isNotEmpty,
      builder: (BuildContext context) {
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.separated(
                itemBuilder: (context, i) => CustomShowTasks(
                      model: cubit.newTasks[i],
                    ),
                separatorBuilder: (context, i) => Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                itemCount: cubit.newTasks.length);
          },
        );
      },
      fallback: (BuildContext context) {
        return cubit.newTasks.isEmpty
            ?const Center(
              child:  Text('There is not new tasks!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.teal
        ),
        ),
            )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
