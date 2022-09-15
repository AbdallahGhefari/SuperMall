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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context,listen: false).userNameController.clear();
    Provider.of<FirebaseProvider>(context,listen: false).emailController.clear();
    Provider.of<FirebaseProvider>(context,listen: false).passwordController.clear();
    Provider.of<FirebaseProvider>(context,listen: false).phoneController.clear();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context,provider,x) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('SIGN UP',style: TextStyle(color: ColorsUi.Color2),),
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
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                child: Form(
                  key: provider.SignUpKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Image.asset('assets/images/sign-up.png',height: 250.h,),
                      SizedBox(height: 30.h,),
                      TextFieldWidget(
                        controller: provider.userNameController,
                        validator: provider.nullValidation,
                        label: 'Full name',
                        hint: 'Abdallah Al-Ghefari',
                        icon: Icon(Icons.drive_file_rename_outline_rounded,color: ColorsUi.Color2,),
                      ),
                      SizedBox(height: 15.h,),
                      TextFieldWidget(
                        controller: provider.emailController,
                        validator: provider.emailValidation,
                        label: 'Email Address',
                        hint: 'example@mail.com',
                        icon: Icon(Icons.alternate_email_rounded,color: ColorsUi.Color2,),
                      ),
                      SizedBox(height: 15.h,),
                      TextFieldWidget(
                        controller: provider.passwordController,
                        validator: provider.passwordValidation,
                        label: 'Password',
                        hint: '123456789',
                        icon: Icon(Icons.password_outlined,color: ColorsUi.Color2,),
                      ),
                      SizedBox(height: 15.h,),
                      TextFieldWidget(
                        validator: provider.nullValidation,
                        controller: provider.phoneController,
                        label: 'Phone',
                        hint: '0594301380',
                        icon: Icon(Icons.phone_android_outlined,color: ColorsUi.Color2,),
                      ),
                      SizedBox(height: 30.h,),
                      GestureDetector(
                          onTap: (){
                            if(provider.SignUpKey.currentState!.validate()) {
                            provider.register();
                          }
                        },
                          child: BottomWidget(title: 'Sign Up',))
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
