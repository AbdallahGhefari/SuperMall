import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:superstore/UI/Screens/HomeScreen.dart';
import 'package:superstore/UI/Screens/WelcomeScreen.dart';
import 'package:string_validator/string_validator.dart';
import '../AppRouter.dart';
import '../Data/AuthFirebaseHelper.dart';
import '../Data/StoreFirebaseHelper.dart';
import '../Models/ProductModel.dart';
import '../Models/UserApp.dart';
import '../UI/Screens/SliderScreen.dart';

class FirebaseProvider extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();

  TextEditingController forgetPasswordController = TextEditingController();

  GlobalKey<FormState> SignUpKey = GlobalKey();
  GlobalKey<FormState>? SignInKey = GlobalKey();
  GlobalKey<FormState>? ForgetKey = GlobalKey();

  AppUser? appUser;

  List<Product>? Cart;
  int? total = 0;

  nullValidation(String v){
    if(v.isEmpty) {
      return 'This field required';
    }}
  emailValidation(String v){
    if(v.isEmpty) {
      return 'This field required';
    }
    else if(!isEmail(v)) {
      return 'Wrong Email';
    }
  }
  passwordValidation(String v){
    if(v.length < 6) {
      return 'Wrong password';
    }}


  signIn()async{
    UserCredential? userCredential =    await AuthFirebaseHelper.authFirebaseHelper.signIn(emailSignInController.text, passwordSignInController.text);

    if(userCredential != null){
      appUser = await StoreFirebaseHelper.storeFirebaseHelper.getUserFromFirestore(userCredential.user!.uid);
      appUser!.id = userCredential.user!.uid;
      // SignInKey = null;
      // AppRouter.NavigatorToWidgetWithReplacement(DoneSignIn_Screen());
      AppRouter.NavigatorToWidgetWithReplacement(HomeScreen());
      emailSignInController.clear();
      passwordSignInController.clear();
      SignInKey = null;
    }

  }

  register()async{
    UserCredential? userCredential = await AuthFirebaseHelper.authFirebaseHelper.signUp(emailController.text, passwordController.text);
    AppUser appUser = AppUser(
        userName: userNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        id: userCredential!.user!.uid,
    );
    this.appUser = appUser;
    AppRouter.NavigatorToWidgetWithReplacement(IntroScreenDefaultState());
    await StoreFirebaseHelper.storeFirebaseHelper.addUserToFirestore(appUser);
    userNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();



  }

  checkUser()async{
    User? user = AuthFirebaseHelper.authFirebaseHelper.firebaseAuth.currentUser;
    if(user == null){
      AppRouter.NavigatorToWidgetWithReplacement(WelcomeScreen());

    }
    else{
      appUser = await StoreFirebaseHelper.storeFirebaseHelper.getUserFromFirestore(user.uid);
      appUser!.id = user.uid;
      AppRouter.NavigatorToWidgetWithReplacement(HomeScreen());

    }
  }

  signOut()async{
    AuthFirebaseHelper.authFirebaseHelper.signOut();
    SignInKey = GlobalKey();
    AppRouter.NavigatorToWidgetWithReplacement(WelcomeScreen());

  }

  forGetPassword()async{
    AuthFirebaseHelper.authFirebaseHelper.forgetPassword(forgetPasswordController.text);
    forgetPasswordController.clear();
    ForgetKey = null;
  }

  addProductOfCart(Product product,String idUser)async{
   await StoreFirebaseHelper.storeFirebaseHelper.addProductOfCart(product, idUser);
  }

  getCart()async{
    Cart = await StoreFirebaseHelper.storeFirebaseHelper.getCart(appUser!.id!);

    total = 0;
    if(Cart!= null){
      for(int i = 0 ; Cart!.length>i ; i++){
        total = (total! + Cart![i].price!.toInt());
      }
    }
    log(total.toString());

    notifyListeners();
  }
  deleteProductFromCart(String idProduct,String idUser)async{
    StoreFirebaseHelper.storeFirebaseHelper.deleteProductFromCart(idProduct, idUser);
    getCart();
    notifyListeners();
  }
  updateUser()async{
    AppUser NewappUser =AppUser(
        userName: userNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
    );

    NewappUser.id = appUser!.id;
    await StoreFirebaseHelper.storeFirebaseHelper.updateUser(NewappUser);
    appUser = await StoreFirebaseHelper.storeFirebaseHelper.getUserFromFirestore(NewappUser.id!);
    notifyListeners();
  }


}