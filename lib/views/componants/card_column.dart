import 'package:dashbord/core/utils/naviagtion.dart';
import 'package:dashbord/services/sp_helper/cache_helper.dart';
import 'package:dashbord/src/app_color.dart';
import 'package:flutter/material.dart';

import 'my_text.dart';

class CardColumn extends StatelessWidget {
  final String title;
  final String description;
  final Color iconColor;
  final Color backgroundIconColor;
  final Color circleColor;
  final screen;
  final icon;
  final cubic;


  CardColumn(
      {required this.title,
      required this.description,
      required this.iconColor,
      required this.backgroundIconColor,
      required this.circleColor,
      this.icon, this.screen, this.cubic});

  @override
  Widget build(BuildContext context) {
    print(SharedPreferencesHelper.getData(key: 'lNumber'));
    return Container(
      child: GestureDetector(
        onTap: (){
          AppNavigator.customNavigator(context: context, screen: screen, finish: false);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: AppColors.kPrimaryWhite,

          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: circleColor,
                  radius: 40,
                  child: circleColor != backgroundIconColor ? Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: backgroundIconColor,
                    child: Icon(
                      Icons.timeline,
                      color: iconColor,
                    ),
                  ) : Row(
                    children: [
                      Icon(
                        icon,
                        color: iconColor,
                        size: 40,
                      ),
                      cubic.length > SharedPreferencesHelper.getData(key: 'lNumber') ?
                         CircleAvatar(
                           backgroundColor: AppColors.kPrimaryRed,
                           child: Text(
                               (cubic.length - SharedPreferencesHelper.getData(key: 'lNumber')).toString()
                           ),
                         ) : SizedBox()
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MYText(textColor: AppColors.kPrimaryBlack, text: title, size: 25, bold: true),
                    MYText(textColor: Colors.grey, text: description, size: 15, bold: false),
                  ],
                ),

              ],
            ),
          ),

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
    );
  }
}
