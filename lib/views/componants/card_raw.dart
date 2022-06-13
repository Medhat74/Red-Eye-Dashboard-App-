import 'package:dashbord/src/app_color.dart';
import 'package:flutter/material.dart';

import 'my_text.dart';

class CardRaw extends StatelessWidget {
  final String text;
  final iconType;
  final int number;
  final Color color;
  var function;


  CardRaw({required this.text, this.iconType, required this.number, required this.color, this.function});

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      MYText(textColor: color, size: 10, text: text, bold: false,),
                      MYText(textColor: AppColors.kPrimaryBlack, size: 55, text: number.toString(), bold: true,),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 65,
                    width: 65,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: color,
                      child: IconButton(
                        icon: Icon(iconType,),
                        color: AppColors.kPrimaryWhite,
                        onPressed: () {
                          print("toot");
                          function.getAllData();
                        },
                      ),
                    ),
                  ),
                ),

              ],
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
