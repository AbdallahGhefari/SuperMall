import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:superstore/AppRouter.dart';
import 'package:superstore/UI/Screens/Auth/LogInScreen.dart';
import 'package:superstore/UI/Screens/Auth/SignUpScreen.dart';

import '../ColorsUi.dart';
import '../Widgets/BottomWidete.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(Navigator.canPop(context)){
          Navigator.pop(context,"Yes pop");
          return Future.value(true);
        }
        else {
          print('No pop');
          showDialog(
              context: AppRouter.navKey.currentContext!,
              builder: (context){
                return Dialog(
                  backgroundColor: Colors.white.withOpacity(.9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 20.h,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25.r),topLeft: Radius.circular(25.r))
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/power.png',height: 100.h,),
                      ),
                      SizedBox(height: 10.h,),
                      Text('Are you sure to exit the application?',style: TextStyle(color: ColorsUi.Color2,fontWeight: FontWeight.bold),),
                      SizedBox(height: 30.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text('NO',style: TextStyle(fontSize: 15.sp),),
                            onPressed: () {
                              AppRouter.popFromWidget();
                            },
                          ),
                          FlatButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text('YES',style: TextStyle(fontSize: 15.sp),),
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  ),
                );
              });
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 100.h,),
                Lottie.asset('assets/animation/logoS.json',height: 200.h),
                SizedBox(height: 15.h,),
                Text('Welcome To',style: TextStyle(fontSize: 25.sp),),
                Text('Super Mall',style: TextStyle(fontSize: 35.sp),),
                const Spacer(),
                InkWell(
                  onTap: (){
                    AppRouter.NavigatorToWidget(LogInScreen());

                  },
                  child: SizedBox(
                      width: 300.w,
                      child: BottomWidget(title: 'Log In',)),
                ),
                SizedBox(height: 15.h,),
                InkWell(
                  onTap: (){
                    AppRouter.NavigatorToWidget(SignUpScreen());

                  },
                  child: SizedBox(
                    width: 300.w,
                      child: BottomWidget(title: 'Sign Up',)),
                ),
                SizedBox(height: 100.h,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
