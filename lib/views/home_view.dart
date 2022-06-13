import 'package:dashbord/bloc/object_detection/object_detection_cubit.dart';
import 'package:dashbord/core/toast/toast.dart';
import 'package:dashbord/core/utils/size_config.dart';
import 'package:dashbord/enums/ToostStates.dart';
import 'package:dashbord/services/sp_helper/cache_helper.dart';
import 'package:dashbord/src/app_color.dart';
import 'package:dashbord/views/componants/card_column.dart';
import 'package:dashbord/views/componants/card_raw.dart';
import 'package:dashbord/views/componants/my_text.dart';
import 'package:dashbord/views/dashbord_view.dart';
import 'package:dashbord/views/notification_view.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeView extends StatelessWidget {
  bool done = false;
  late bool getState ;


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = AppBar().preferredSize.height;


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.0),
        child: AppBar(

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: MYText(textColor: AppColors.kPrimaryBlack, size: 30, text: "Dashboard", bold: true,),
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: MYText(text: "oscheros.com", size: 15, textColor: AppColors.kPrimaryColor, bold: true,),
              ),
            ],
          ),
          backgroundColor: Colors.white,

        ),
      ),

      body: BlocConsumer<ObjectDetectionCubit, ObjectDetectionState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is ObjectDetectionErrorState)
        {
          ToastConfig.showToast(msg: state.error.toString(), toastStates: ToastStates.Success);
          done = true;
          getState = false;
        }
        if(state is ObjectDetectionSuccessState)
        {
          ToastConfig.showToast(msg: "Success", toastStates: ToastStates.Success);
          done = true;
          getState = true;
        }
        if(state is ObjectDetectionLoadingState)
        {
          done = false;
        }

      },
      builder: (context, state) {
        var cubit = ObjectDetectionCubit.get(context);
        return RefreshIndicator(
            onRefresh: ()async{
              cubit.getAllData();
            },
            child: !done ?  Center(child: CircularProgressIndicator()) :
            !getState ? Center(
              child: Text("Error"),
            ) : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  /// first card
                  Expanded(
                    child: CardRaw(
                      text: "Total Detections",
                      number: cubit.length!,
                      color: AppColors.kPrimaryColor ,
                      iconType: Icons.timeline,
                      function: cubit,
                    ),
                  ),

                  /// two cards
                  Expanded(
                    flex: 2,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 200,
                            child: CardColumn(
                              title: "General",
                              backgroundIconColor: AppColors.kPrimaryWhite,
                              circleColor: AppColors.kPrimaryGreen,
                              description: "All",
                              iconColor: AppColors.kPrimaryGreen,
                              icon: Icons.settings,
                              screen: DashboardView(),

                            ),

                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 200,
                            child: CardColumn(
                              title: "Notification",
                              backgroundIconColor: AppColors.kPrimaryYellow,
                              circleColor: AppColors.kPrimaryYellow,
                              description: "Detection Type & Location",
                              iconColor: AppColors.kPrimaryWhite,
                              icon: Icons.notifications,
                              cubic: cubit,
                              screen: NotificationView((cubit.length! - SharedPreferencesHelper.getData(key: 'lNumber')) as int),
                            ),

                          ),
                        ),
                      ],

                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Card (
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [


                            LineGraph(
                              features: cubit.setInputGraph(),
                              size: Size(SizeConfig.screenWidth! - 2 , 200),
                              labelX: ['12', '1', '2', '3' , '4', '5' , '6' , '7', '8', '9', '10' , '11'],
                              labelY: ['20%', '40%', '60%', '80%', '100%'],
                              showDescription: false,
                              graphColor: AppColors.kPrimaryWhite,
                              graphOpacity: 0,
                              verticalFeatureDirection: true,
                              descriptionHeight: 130,
                            ),
                          ],
                        ),
                      ),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: CardRaw(
                      text: "Camera Regions",
                      number: 1,
                      color: AppColors.kPrimaryRed,
                      iconType: Icons.camera_alt,
                      function: (){},
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),

    );
  }

}
