import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:superstore/AppRouter.dart';
import 'package:superstore/Providers/FirebaseProvider.dart';
import 'package:superstore/Providers/DioProvider.dart';
import 'package:superstore/UI/ColorsUi.dart';
import 'package:superstore/UI/Screens/CartScreen.dart';
import 'package:superstore/UI/Screens/MapScreen.dart';
import 'package:superstore/UI/Screens/ProductScreen.dart';
import 'package:superstore/UI/Screens/SliderScreen.dart';

import 'Auth/SettingsScreen.dart';
import 'ContactUsScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(
      builder: (context,provider,x) {
        return
          WillPopScope(

            onWillPop: () {
              if(Navigator.canPop(context)){
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
                                    // Provider.of<FirebaseProvider>(context,listen: false).signOut();
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
                // Navigator.pop(context,"Yes pop");
                return Future.value(false);
              }else{
                return Future.value(false);
              }
            },
            child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: (){
                  Provider.of<FirebaseProvider>(context,listen: false).getCart();
                  AppRouter.NavigatorToWidget(CartScreen());
                  // provider.selectProductsOfCart;
                },
              )],
              title: Text('Home'),

              centerTitle: true,
              elevation: 0,
              foregroundColor: ColorsUi.Color2,
              backgroundColor: Colors.transparent,
            ),
            body:
            provider.categories==null?
                const Center(child: CircularProgressIndicator()):
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Last Offers',style: TextStyle(color: ColorsUi.Color3,fontSize: 25.sp),),
                  ),
                  ImageSlideshow(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*.2,
                    initialPage: 0,

                    indicatorColor: ColorsUi.Color1,
                    indicatorBackgroundColor: ColorsUi.Color2,
                    children: [
                      Image(image: CachedNetworkImageProvider(provider.categories![0].image!),
                        width: 360.w,fit:BoxFit.cover,),
                      Image(image: CachedNetworkImageProvider(provider.categories![1].image!),
                        width: 360.w,fit:BoxFit.cover,),
                      Image(image: CachedNetworkImageProvider(provider.categories![2].image!),
                        width: 360.w,fit:BoxFit.cover,),
                    ],
                    onPageChanged: (value) {
                      // AppRouter.NavigatorToWidget(Details_Screen(provider.Courses[value]));
                    },

                    autoPlayInterval: 4000,

                    /// Loops back to first slide.
                    isLoop: true,
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Collections',style: TextStyle(color: ColorsUi.Color3,fontSize: 25.sp),),
                        GestureDetector(
                          onTap: (){
                            provider.selectCategory('all');
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductScreen()));

                          },
                          // onTap: ()=>AppRouter.NavigatorToWidget(ProductScreen()),
                            child: Text('All Products',style: TextStyle(color: ColorsUi.Color1,fontSize: 18.sp),)
                            ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // itemCount: 5,
                      itemCount: provider.categories!.length,
                        itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(15),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: CachedNetworkImage(
                                imageUrl: provider.categories![index].image!,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => new Icon(Icons.error)
                                ,height: 140.h,width:double.infinity,fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.only(left: 8),
                              height: 50.h,

                              width: 200.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.white
                              ),
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(provider.categories![index].name!,style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis)),
                                      Text('View all products',style: TextStyle(fontSize: 10.sp,color: Colors.black54),),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(onPressed: (){
                                    log(provider.categories![index].id.toString());
                                    provider.selectCategory(provider.categories![index].id.toString());
                                    AppRouter.NavigatorToWidget(ProductScreen());
                                  }, icon: Icon(Icons.keyboard_arrow_right))
                                ],
                              ),
                            )
                          ],
                        )

                      );
                    }),
                  ),

                ],
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorsUi.Color2
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        SizedBox(height: 100.h,),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35.r,
                          child: Text(Provider.of<FirebaseProvider>(context).appUser?.userName.characters.first.toUpperCase()??'',
                            style: TextStyle(fontSize: 30.sp,color: ColorsUi.Color1),
                          ),
                          // backgroundImage: NetworkImage('https://api.lorem.space/image/face?w=640&h=480&r=4511'),
                        ),
                        SizedBox(height: 10.h,),
                        Text(Provider.of<FirebaseProvider>(context).appUser?.userName??'',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),),
                        SizedBox(height: 20.h,),
                        Row(
                          children: [
                            Icon(Icons.alternate_email_rounded,color: Colors.white,),
                            SizedBox(width: 10.w,),
                            Text(Provider.of<FirebaseProvider>(context).appUser?.email??'',style: TextStyle(color: Colors.white),),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Icon(Icons.phone,color: Colors.white,),
                            SizedBox(width: 10.w,),
                            Text(Provider.of<FirebaseProvider>(context).appUser?.phone??'',style: TextStyle(color: Colors.white),),
                          ],
                        ),
                        SizedBox(height: 40.h,)

                      ],
                    ),
                  ),
                  //  UserAccountsDrawerHeader(
                  //   decoration: BoxDecoration(
                  //     color: ColorsUi.Color2
                  //   ),
                  //   accountName: Text(Provider.of<FirebaseProvider>(context).appUser?.userName??''),
                  //   accountEmail: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(Provider.of<FirebaseProvider>(context).appUser?.email??''),
                  //       SizedBox(height: 5.h,),
                  //       Text(Provider.of<FirebaseProvider>(context).appUser?.phone??''),
                  //     ],
                  //   ),
                  //
                  //   currentAccountPicture: CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     child: Text(Provider.of<FirebaseProvider>(context).appUser?.userName.characters.first.toUpperCase()??'',
                  //     style: TextStyle(fontSize: 30.sp,color: ColorsUi.Color1),
                  //     ),
                  //     // backgroundImage: NetworkImage('https://api.lorem.space/image/face?w=640&h=480&r=4511'),
                  //   ),
                  // ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.gps_fixed),
                    title: Text("Local"),
                    onTap: () {
                      AppRouter.NavigatorToWidget(MapScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("Contact Us"),
                    onTap: () {
                      AppRouter.NavigatorToWidget(ContactUsScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () {
                      AppRouter.NavigatorToWidget(SettingsScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.subdirectory_arrow_left_rounded),
                    title: Text("Sign Out"),
                    onTap: () {
                      Provider.of<FirebaseProvider>(context,listen: false).signOut();
                    },
                  ),
                ],
              ),
            ),
        ),
          );
      }
    );
  }
}
