import 'package:dashbord/bloc/object_detection/object_detection_cubit.dart';
import 'package:dashbord/core/utils/naviagtion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_view.dart';

class DashboardView extends StatelessWidget {
  List<String> columnData = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObjectDetectionCubit, ObjectDetectionState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ObjectDetectionCubit.get(context);
        columnData = cubit.getGridData();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Data View"
            ),
            leading: BackButton(
              onPressed: (){
                AppNavigator.customNavigator(context: context, screen: HomeView(), finish: true);
                cubit.getAllData();

              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Expanded(
                 child: GridView.builder(
                   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                       maxCrossAxisExtent: 100,
                       mainAxisExtent: 50,
                       childAspectRatio: 4,
                       crossAxisSpacing: 20,
                       mainAxisSpacing: 20),
                   itemCount: 4 + (cubit.objectDetection!.objects!.length *4),
                   itemBuilder: (BuildContext context, int index) {
                     return Column(
                       children: [
                           Text(
                             columnData[index],
                           ),


                       ],
                     );
                   },
                 ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
