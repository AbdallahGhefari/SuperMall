import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:superstore/Models/ProductModel.dart';
import 'package:superstore/Providers/FirebaseProvider.dart';
import 'package:superstore/UI/ColorsUi.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../AppRouter.dart';
import 'CartScreen.dart';

class DetailsProductScreen extends StatelessWidget {
  // const DetailsProductScreen({Key? key}) : super(key: key);
  Product product;
  DetailsProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              Provider.of<FirebaseProvider>(context,listen: false).getCart();
              AppRouter.NavigatorToWidget(CartScreen());
              // provider.selectProductsOfCart;
            },
          )
        ],
        title: Text(product.category!.name!),
        centerTitle: true,
        elevation: 0,
        foregroundColor: ColorsUi.Color2,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                  child: CachedNetworkImage(
                    imageUrl: product.images!.last,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    height: MediaQuery.of(context).size.height/1.5,width:double.infinity,fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25) ),
                          color: Colors.white60
                        ),
                        child: Column(
                          children: [
                            Text(product.title??'',style: TextStyle(fontSize: 30.sp,)),
                            Text(product.price!.toString() + ' \$',style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold,),),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
            // RatingBarIndicator(
            //   rating: 3,
            //   itemBuilder: (context, index) => Icon(
            //     Icons.star_rounded,
            //     color: Colors.amber,
            //   ),
            //   itemCount: 5,
            //   itemSize: 30.sp,
            //   direction: Axis.horizontal,
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(product.description??''),

            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Provider.of<FirebaseProvider>(context,listen: false).addProductOfCart(product, Provider.of<FirebaseProvider>(context,listen: false).appUser!.id!);
                // AppRouter.NavigatorToWidget(CartScreen());
              },
              child: Container(
                alignment: Alignment.center,
                width: 200.w,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorsUi.Color2
                ),
                child: Text("Add to cart",style: TextStyle(fontSize: 20.sp,color: Colors.white),),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
