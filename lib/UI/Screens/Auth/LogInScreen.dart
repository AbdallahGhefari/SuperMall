import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:superstore/AppRouter.dart';
import 'package:superstore/Providers/FirebaseProvider.dart';
import 'package:superstore/UI/Screens/Auth/ForgetPasswordScreen.dart';
import 'package:superstore/UI/Screens/ProductScreen.dart';
import 'package:superstore/UI/Screens/WelcomeScreen.dart';

import '../../ColorsUi.dart';
import '../../Widgets/BottomWidete.dart';
import '../../Widgets/TextFieldWidget.dart';
import '../HomeScreen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context,provider,x) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('LOG IN',style: TextStyle(color: ColorsUi.Color2),),
            centerTitle: true,
            leading: IconButton(
              onPressed:()=> AppRouter.NavigatorToWidgetWithReplacement(WelcomeScreen()),
              icon: Icon(Icons.arrow_back_rounded,color: ColorsUi.Color2,),
            ),
          ),
          body: SafeArea(

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: provider.SignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/animation/96322-password-login-security.json',),

                      TextFieldWidget(
                        validator: provider.emailValidation,
                        controller: provider.emailSignInController,
                        label: 'Email Address',
                        hint: 'example@mail.com',
                        icon: Icon(Icons.alternate_email_rounded,color: ColorsUi.Color2,),
                      ),
                      SizedBox(height: 15.h,),
                      TextFieldWidget(
                        password: true,
                        validator: provider.passwordValidation,
                        controller: provider.passwordSignInController,
                        label: 'Password',
                        hint: '123456789',
                        icon: Icon(Icons.password_outlined,color: ColorsUi.Color2,),
                      ),
                      SizedBox(height: 10.h,),
                      GestureDetector(
                        onTap: (){
                          AppRouter.NavigatorToWidget(ForgetPasswordScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Did you forget a password?',style: TextStyle(fontSize: 18.sp,color: ColorsUi.Color1,
                              shadows: [BoxShadow(
                                offset: Offset(1,1),
                                color: Colors.grey,
                                blurRadius: 25,
                              )]),),
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      InkWell(
                        onTap: (){
                          if(provider.SignInKey!.currentState!.validate())
                          {
                            provider.signIn();
                            // AppRouter.NavigatorToWidget(HomeScreen());
                          }
                        },
                          child: BottomWidget(title: 'Log In',))
                    ],
                  ),
                ),
              ),
            ),
          ),

        );
      }
    );
  }
}
