import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dashbord/models/object_detection.dart';
import 'package:dashbord/services/dio_helper/dio_service.dart';
import 'package:dashbord/src/app_color.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'object_detection_state.dart';

class ObjectDetectionCubit extends Cubit<ObjectDetectionState> {
  ObjectDetectionCubit() : super(ObjectDetectionInitial());

  static ObjectDetectionCubit get(context) => BlocProvider.of(context);
  ObjectDetection? objectDetection;
  List<double>? xInputs;
  int? length ;

  getAllData(){
    emit(ObjectDetectionLoadingState());
    DioHelper.getData(url: 'getWeaponResponse').then((value) {
      var jsonData= jsonDecode(value.data);
      objectDetection = ObjectDetection.fromJson(jsonData);
      length = objectDetection!.objects!.length ;
      //print(objectDetection!.objects![length! - 1].toString());
      //setInputGraph();
      emit(ObjectDetectionSuccessState());
    }).catchError((error){
      print(error);
      emit(ObjectDetectionErrorState(error));
    });
  }

  List<Feature> setInputGraph(){
    Map<int , int> hoursCounter = {0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0};
    List<double> percintageData =[] ;
    objectDetection!.objects!.forEach((element) {
      print("loop");
      print(element.time);
      var hour = int.parse(element.time!.substring(0 , 2)) % 12;
      hoursCounter[hour]  = hoursCounter[hour]! + 1;
    });
    for (int i = 0 ; i < 12; i++){
      print(hoursCounter[i]!);
      print(length!);
      var a = hoursCounter[i]! *0.1;
      print(a);
      percintageData.add(a);
      print("here");
    }
    List<Feature> feature = [
      Feature(
        title: "Guns",
        color: AppColors.kPrimaryGreen,
        data: percintageData,
      ),
    ];
    return feature;

  }

  List<String> getGridData(){
    List<String> data = ["ID" , "Type" , "Location" , "Date"];
    int i = 1;
    objectDetection!.objects!.reversed.forEach((element) {
      data.add(i.toString());
      data.add(element.typeOfWeapon!);
      data.add(element.location!.substring(0 ,21));
      data.add(element.date!.substring(0,16));
      i++;
    });

    return data;
  }



}
