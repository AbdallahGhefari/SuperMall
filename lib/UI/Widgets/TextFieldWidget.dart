import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ColorsUi.dart';

class TextFieldWidget extends StatelessWidget {
  // const TextFieldWidget({Key? key}) : super(key: key);
  TextFieldWidget({required this.validator,this.label,this.hint,this.icon,required this.controller,this.maxLines,this.password,this.enable});
  final Function? validator;
  late String? label;
  late String? hint;
  late Widget? icon;
  late int? maxLines;
  late double? height;
  late bool? password;
  late bool? enable;
  TextEditingController controller;

  var borderSide = BorderSide(color: ColorsUi.Color2, width: 2);
  var borderRadius = BorderRadius.all(Radius.circular(30));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 60.h,
      child: TextFormField(
        enabled: enable,
        validator: (x)=>validator!(x),
        obscureText: password??false,
        // maxLines: maxLines,
        controller: controller,

          style: TextStyle(fontSize: 20.sp),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: borderSide,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: borderSide,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: ColorsUi.Color1, width: 2),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: borderSide,
            ),
            prefixIcon: icon,
            labelText: label,
            labelStyle: TextStyle(color: ColorsUi.Color3),
            hintText: hint,
            hintStyle: TextStyle(fontSize: 15.sp,color: Colors.grey.shade300),
          )
      ),
    );
  }

}
