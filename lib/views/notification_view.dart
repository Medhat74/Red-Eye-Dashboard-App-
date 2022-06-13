import 'package:dashbord/bloc/object_detection/object_detection_cubit.dart';
import 'package:dashbord/core/utils/naviagtion.dart';
import 'package:dashbord/core/utils/size_config.dart';
import 'package:dashbord/models/object_detection.dart';
import 'package:dashbord/models/object_detection.dart';
import 'package:dashbord/services/sp_helper/cache_helper.dart';
import 'package:dashbord/src/app_color.dart';
import 'package:dashbord/views/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'componants/my_text.dart';

class NotificationView extends StatelessWidget {
  final int count;
  NotificationView(this.count);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ObjectDetectionCubit, ObjectDetectionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubic = ObjectDetectionCubit.get(context);
          SharedPreferencesHelper.saveData(key: 'lNumber', value: cubic.length);
          return Scaffold(
            appBar: AppBar(
              title: Text("Detection Object"),
              leading: BackButton(
                onPressed: (){
                  AppNavigator.customNavigator(context: context, screen: HomeView(), finish: true);
                  cubic.getAllData();

                },
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: count,
                    //cubit.categories.length,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MYText(
                            size: 40,
                            text: "Type : ${cubic.objectDetection!.objects![index].typeOfWeapon.toString()}",
                            bold: true,
                            textColor: AppColors.kPrimaryBlack,
                          ),MYText(
                            size: 40,
                            text: cubic.objectDetection!.objects![index].date.toString().substring(0,10),
                            bold: false,
                            textColor: AppColors.kPrimaryBlack,
                          ),MYText(
                            size: 40,
                            text: cubic.objectDetection!.objects![index].date.toString().substring(10,18),
                            bold: true,
                            textColor: AppColors.kPrimaryBlack,
                          ),MYText(
                            size: 20,
                            text: cubic.objectDetection!.objects![index].location.toString(),
                            bold: true,
                            textColor: AppColors.kPrimaryBlack,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: AppColors.kPrimaryColor,
                            thickness: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
  }
}
