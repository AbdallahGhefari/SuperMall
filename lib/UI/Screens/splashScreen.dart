

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:superstore/Providers/FirebaseProvider.dart';
import 'package:superstore/UI/ColorsUi.dart';
import 'package:superstore/UI/Screens/WelcomeScreen.dart';

import '../../AppRouter.dart';
import 'ProductScreen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  initFun()async{
    // Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!).getAllCourses();
    await Future.delayed(Duration(seconds: 3));
    Provider.of<FirebaseProvider>(AppRouter.navKey.currentContext!,listen: false).checkUser();


    // AppRouter.NavigatorToWidgetWithReplacement(WelcomeScreen());

  }

  @override
  Widget build(BuildContext context) {
    initFun();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/animation/logoS.json',height: 200.h),
            SizedBox(height: 30.h,),
            Text('Super Mall',style: TextStyle(fontSize: 40.sp,color: ColorsUi.Color2,
            ),)


          ],
        ),
      ),
    );
  }
}
