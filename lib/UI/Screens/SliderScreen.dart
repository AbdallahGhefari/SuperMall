import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:superstore/AppRouter.dart';
import 'package:superstore/UI/ColorsUi.dart';
import 'package:superstore/UI/Screens/HomeScreen.dart';

class IntroScreenDefaultState extends StatefulWidget {
  @override
  State<IntroScreenDefaultState> createState() => _IntroScreenDefaultStateState();
}

class _IntroScreenDefaultStateState extends State<IntroScreenDefaultState> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      Slide(
        title: "Choose your products",
        description:
        "There are more than 250 brands of men's and women's shoes and clothing in the catalog",
        pathImage: "assets/images/choose product.png",
        heightImage: 400.h,
        backgroundColor: ColorsUi.Color2,
      ),
    );
    slides.add(
      Slide(
        title: "Add to cart",
        description:
        "Just 2 clicks and you can buy all the fashion news with home delivery",
        pathImage: "assets/images/add to cart.png",
        heightImage: 400.h,
        backgroundColor: ColorsUi.Color2,
      ),
    );
    slides.add(
      Slide(
        title: "Fast Delivery",
        description:
        "The order can be paid by cash at the time fo delivery",
        pathImage: "assets/images/Delivery2.png",
        heightImage: 400.h,
        backgroundColor: ColorsUi.Color2,
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    AppRouter.NavigatorToWidgetWithReplacement(HomeScreen());
    print("End of slides");
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      onDonePress: onDonePress,
    );
  }
}