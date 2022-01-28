import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class newTasksScreen extends StatelessWidget {
  const newTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newtasks;
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildtaskitem(tasks[index], context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
            itemCount: tasks.length);
      },
    );

    // return ListView.separated(
    //     itemBuilder: (context, index) => buildtaskitem(tasks[index]),
    //     separatorBuilder: (context, index) => Container(
    //           width: double.infinity,
    //           height: 1.0,
    //           color: Colors.grey[300],
    //         ),
    //     itemCount: tasks.length);
  }
}
