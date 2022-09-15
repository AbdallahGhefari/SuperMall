import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../AppRouter.dart';
import '../../../Providers/FirebaseProvider.dart';
import '../../ColorsUi.dart';
import '../../Widgets/BottomWidete.dart';
import '../../Widgets/TextFieldWidget.dart';
import 'LogInScreen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context,provider,x) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Forget Password',style: TextStyle(color: ColorsUi.Color2),),
            centerTitle: true,
            leading: IconButton(
              onPressed:()=> AppRouter.popFromWidget(),
              icon: Icon(Icons.arrow_back_rounded,color: ColorsUi.Color2,),
            ),
          ),
          body: SafeArea(

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 80.h,),
                    Lottie.asset('assets/animation/94132-forgot-password.json',height: 270.h,animate: false),
                    SizedBox(height: 100.h,),
                    Form(
                      key: provider.ForgetKey,
                      child: TextFieldWidget(
                        validator: provider.emailValidation,
                        controller: provider.forgetPasswordController,
                        label: 'Email Address',
                        hint: 'example@mail.com',
                        icon: Icon(Icons.alternate_email_rounded,color: ColorsUi.Color2,),
                      ),
                    ),

                    SizedBox(height: 30.h,),
                    GestureDetector(
                        onTap: (){
                          if(provider.ForgetKey!.currentState!.validate())
                          {
                          provider.forGetPassword();
                          showDialog(
                              context: AppRouter.navKey.currentContext!,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.white.withOpacity(.9),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.r)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                            color: ColorsUi.Color2,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(25.r),
                                                topLeft:
                                                    Radius.circular(25.r))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/images/email.png',
                                          height: 100.h,
                                        ),
                                      ),
                                      Text(
                                        'Check your email',
                                        style: TextStyle(
                                            color: ColorsUi.Color2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        'Check your email to set the password',
                                        style:
                                            TextStyle(color: ColorsUi.Color2),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      FlatButton(
                                        color: Colors.green,
                                        textColor: Colors.white,
                                        child: Text(
                                          'OK',
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        onPressed: () {
                                          AppRouter
                                              .NavigatorToWidgetWithReplacement(
                                                  LogInScreen());
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                        child: BottomWidget(title: 'Get Password',)),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
