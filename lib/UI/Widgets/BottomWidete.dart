import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ColorsUi.dart';

class BottomWidget extends StatelessWidget {
  BottomWidget({required this.title});
  late String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(1,-1),
              blurRadius: 10,
              color: Colors.grey
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(30.r)),
        color: ColorsUi.Color2,
      ),
      child: Row(
        children: [
          Spacer(),
          Text(title,style: TextStyle(color: Colors.white,fontSize: 25.sp),),
          Spacer(),
          CircleAvatar(
            radius: 18.r,
            backgroundColor: Colors.white,
            child: Icon(Icons.keyboard_arrow_right,size: 30.sp,color: ColorsUi.Color3,),
          )
        ],
      ),
    );
  }
}
