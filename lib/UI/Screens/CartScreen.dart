import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:superstore/Providers/FirebaseProvider.dart';

import '../../AppRouter.dart';
import '../ColorsUi.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _counter = 0;
  late Uint8List _imageFile;
  saved(Uint8List image) async {
     await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
  }
  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );}

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();


  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context,provider,x) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
            centerTitle: true,
            elevation: 0,
            foregroundColor: ColorsUi.Color2,
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                    child: provider.Cart?.length==0?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/empty-cart.png',height: MediaQuery.of(context).size.height/4,),
                        SizedBox(height: 30.h,),
                        Text('Cart is empty',style: TextStyle(color: ColorsUi.Color1,fontSize: 25.sp),),
                      ],
                    ):
                   ListView.builder(
                    itemCount: provider.Cart?.length??0,
                      itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      // padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: CachedNetworkImage(
                              imageUrl: provider.Cart![index].images!.first,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => new Icon(Icons.error),
                              width: 130.w,height: 130.w,fit: BoxFit.cover
                            ),
                            // child: Image.network(provider.Cart![index].images!.first,fit: BoxFit.cover,
                            // width: 130.w,height: 130.w,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: SizedBox(
                              height: 130.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(provider.Cart![index].title!,overflow: TextOverflow.ellipsis,),
                                        Text(provider.Cart![index].category!.name!),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   alignment: Alignment.center,
                                  //   width: 120.w,
                                  //   padding: EdgeInsets.all(8),
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(20),
                                  //       color: ColorsUi.Color2
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //     children: [
                                  //       Text('+',style: TextStyle(fontSize: 20.sp,color: Colors.white),),
                                  //       Text('10',style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                  //       Text('-',style: TextStyle(fontSize: 20.sp,color: Colors.white),),
                                  //
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 130.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text((provider.Cart![index].price!.toString()) +' \$',style: TextStyle(fontSize: 25.sp),),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20.r)
                                  ),
                                  child:
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.delete_outline_rounded,size: 50.sp,color: Colors.white,),
                                    onPressed: (){
                                      provider.deleteProductFromCart(provider.Cart![index].id.toString(),
                                          provider.appUser!.id.toString());
                                    },
                                  )
                                  // Icon(Icons.delete_outline_rounded,size: 50.sp,color: Colors.white,),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })),
                SizedBox(height: 30.h,),
                Text('Totals',style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('NO Products',style: TextStyle(fontSize: 20.sp),),
                          Text(provider.Cart?.length.toString()??'0',style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total ',style: TextStyle(fontSize: 20.sp),),
                          Text(provider.total.toString() +' \$',style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold,color: ColorsUi.Color1),),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h,),
                GestureDetector(
                  onTap: (){
                    showDialog(
                        context: AppRouter.navKey.currentContext!,
                        builder: (context){
                          return Screenshot(
                            controller: screenshotController,
                            child: Dialog(
                              backgroundColor: Colors.white.withOpacity(.9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r)
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: ColorsUi.Color2,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(25.r),topLeft: Radius.circular(25.r))
                                    ),
                                    child: Text('Invoice',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),),
                                  ),
                                  SizedBox(height: 10.h,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('name: ',
                                          style: TextStyle(color: ColorsUi.Color2),),
                                        Text(Provider.of<FirebaseProvider>(context).appUser!.userName,
                                          style: TextStyle(color: ColorsUi.Color4),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('Email: ',
                                          style: TextStyle(color: ColorsUi.Color2),),
                                        Text(Provider.of<FirebaseProvider>(context).appUser!.email,
                                          style: TextStyle(color: ColorsUi.Color4),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  Text('Products',
                                    style: TextStyle(color: ColorsUi.Color2,fontSize: 20.sp),),
                                  SizedBox(height: 10.h,),
                                  provider.Cart?.length==0?
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/empty-cart.png',height: MediaQuery.of(context).size.height/8,),
                                  SizedBox(height: 30.h,),
                                  Text('Cart is empty',style: TextStyle(color: ColorsUi.Color1,fontSize: 18.sp),),
                                ],)
                                  :
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: provider.Cart?.length??0,
                                        itemBuilder: (context,index){
                                        return Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text((index+1).toString()+'- '),
                                                      Text(provider.Cart![index].title!,
                                                          style: TextStyle(color: ColorsUi.Color2)),
                                                    ],
                                                  ),
                                                  Text(provider.Cart![index].price!.toString() + ' \$',
                                                    style: TextStyle(color: ColorsUi.Color4),),
                                                ],
                                              ),
                                              Divider()
                                            ],
                                          ),
                                        );
                                        }),
                                  ),
                                  SizedBox(height: 30.h,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('NO Products',style: TextStyle(color: ColorsUi.Color2),),
                                        Text(provider.Cart?.length.toString()??'0',style: TextStyle(color: ColorsUi.Color4),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Total ',style: TextStyle(color: ColorsUi.Color2),),
                                        Text(provider.total.toString() +' \$',style: TextStyle(color: ColorsUi.Color4),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        FlatButton(
                                          color: Colors.green,
                                          textColor: Colors.white,
                                          child: Text('Back',style: TextStyle(fontSize: 15.sp),),
                                          onPressed: () {
                                            AppRouter.popFromWidget();
                                          },
                                        ),
                                        Spacer(),
                                        IconButton(onPressed: (){
                                          screenshotController
                                              .capture(delay: Duration(milliseconds: 10))
                                              .then((capturedImage) async {
                                            // ShowCapturedWidget(context, capturedImage!);
                                            saved(capturedImage!);
                                          }).catchError((onError) {
                                            print(onError);
                                          });
                                        }, icon: Icon(Icons.screenshot,color: ColorsUi.Color2,size:30.sp ))

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h,),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 200.w,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorsUi.Color1
                    ),
                    child: Text("Payment",style: TextStyle(fontSize: 20.sp,color: Colors.white),),
                  ),
                ),



              ],
            ),
          ),
        );
      }
    );
  }
}
