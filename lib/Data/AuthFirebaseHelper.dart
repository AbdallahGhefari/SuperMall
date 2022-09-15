import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../AppRouter.dart';
import '../Models/UserApp.dart';
import '../UI/ColorsUi.dart';

class AuthFirebaseHelper{
  AuthFirebaseHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static AuthFirebaseHelper authFirebaseHelper = AuthFirebaseHelper._();

  Future<UserCredential?> signIn (String email,String password)async{
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
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
                          color: ColorsUi.Color2,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25.r),topLeft: Radius.circular(25.r))
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/wrong-password.png',height: 100.h,),
                    ),
                    Text('Wrong email or password',style: TextStyle(color: ColorsUi.Color2,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.h,),
                    Text('Check your email to set the password',style: TextStyle(color: ColorsUi.Color2),),
                    SizedBox(height: 20.h,),
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('OK',style: TextStyle(fontSize: 15.sp),),
                      onPressed: () {
                        AppRouter.popFromWidget();
                      },
                    ),
                  ],
                ),
              );
            });
      }
    }
  }
  // updateUser()async{
  //   await firebaseAuth.currentUser?.updatePassword('aaaaaa');
  // }
  Future<UserCredential?> signUp(String email,String password)async{
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // AppRouter.popFromWidget();
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
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
                          color: ColorsUi.Color2,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25.r),topLeft: Radius.circular(25.r))
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/wrong-password.png',height: 100.h,),
                    ),
                    Text('Wrong password',style: TextStyle(color: ColorsUi.Color2,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.h,),
                    Text('Check your email to set the password',style: TextStyle(color: ColorsUi.Color2),),
                    SizedBox(height: 20.h,),
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('OK',style: TextStyle(fontSize: 15.sp),),
                      onPressed: () {
                        AppRouter.popFromWidget();
                      },
                    ),
                  ],
                ),
              );
            });
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
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
                          color: ColorsUi.Color2,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25.r),topLeft: Radius.circular(25.r))
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/wrong-password.png',height: 100.h,),
                    ),
                    Text('The account already exists for that email.',style: TextStyle(color: ColorsUi.Color2,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.h,),
                    Text('Check your email to set the password',style: TextStyle(color: ColorsUi.Color2),),
                    SizedBox(height: 20.h,),
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('OK',style: TextStyle(fontSize: 15.sp),),
                      onPressed: () {
                        AppRouter.popFromWidget();
                      },
                    ),
                  ],
                ),
              );
            });
      }
    } catch (e) {
      print(e);
    }
    return null;

  }
  checkUser()async{
    User? user = firebaseAuth.currentUser;
    if(user==null){
      // AppRouter.NavigatorToWidgetWithReplacement(SignIn_Screen());

    }
    else {
      // AppRouter.NavigatorToWidgetWithReplacement(Home_Screen());
      // StoreHelper.storeHelper.getUserFromFirestore(user.uid);
    }

  }
  signOut()async{
    firebaseAuth.signOut();
  }
  forgetPassword(String email)async{
    await firebaseAuth.sendPasswordResetEmail(email: email);
    // showDialog(
    //     context: AppRouter.navKey.currentContext!,
    //     builder: (context){
    //       return DialogWidget(
    //           content: 'checkEmail'.tr()
    //           , textButton: 'cancel'.tr());
    //     });
  }


}