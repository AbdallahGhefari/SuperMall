import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:superstore/AppRouter.dart';
import 'package:superstore/Models/ProductModel.dart';
import 'package:superstore/Providers/DioProvider.dart';
import 'package:superstore/UI/ColorsUi.dart';
import 'package:superstore/UI/Screens/DetailsProductScreen.dart';

import '../../Providers/FirebaseProvider.dart';
import 'CartScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);
  // int index;
  // ProductScreen(this.index);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(
      builder: (context,provider,x) {
        return

          Scaffold(
          body:
          (provider.productsOfCategory==null)?
          const Center(child: CircularProgressIndicator()):
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  backgroundColor:
                  _isShrink? ColorsUi.Color2:
                  Colors.transparent,
                  pinned: true,
                  expandedHeight: 230.h,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: true,
                    title: _isShrink
                        ?  Text(
                      provider.selectedCategory=='all'? 'All Products':
                      provider.productsOfCategory!.first.category!.name!,
                      // widget.index.toString(),
                    )
                        : null,
                    background: SafeArea(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CachedNetworkImage(
                              imageUrl: provider.productsOfCategory!.first.category!.image!,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => new Icon(Icons.error),
                              width: double.infinity,height: double.infinity,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.black26,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children:  [
                                  Text(
                                    provider.selectedCategory=='all'? 'All Products':
                                    provider.productsOfCategory!.first.category!.name!
                                    ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30.sp,
                                  shadows: [
                                    BoxShadow(
                                      offset: Offset(1,1),
                                      color: Colors.white,
                                      blurRadius: 15
                                    )
                                  ]),),
                                  SizedBox(height: 5.h,),
                                  Text((provider.productsOfCategory!.length.toString())+' Items',style: TextStyle(color: Colors.black,fontSize: 22.sp,
                                      shadows: [
                                        BoxShadow(
                                            offset: Offset(1,1),
                                            color: Colors.white,
                                            blurRadius: 15
                                        )
                                      ]),),
                                  SizedBox(height: 5.h,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: _isShrink
                  ? [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8, right: 12),
                  //   child: Row(
                  //     children: [
                  //       Padding(
                  //         padding:
                  //         const EdgeInsets.only(left: 8, right: 8),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: const [
                  //             Text(
                  //               "Super Mall",
                  //               style: TextStyle(
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         backgroundImage: AssetImage('assets/images/logoS.png'),
                  //
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: (){
                      Provider.of<FirebaseProvider>(context,listen: false).getCart();
                      AppRouter.NavigatorToWidget(CartScreen());
                      // provider.selectProductsOfCart;
                    },
                  )
                  ]
                  : null,
                ),
              ];
            },
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(



                        (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        // height: 150.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  // child: Image.network(provider.productsOfCategory?[index].images?.first??'',fit: BoxFit.fill,)
                              child: CachedNetworkImage(
                                imageUrl: provider.productsOfCategory?[index].images?.first??'',
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => new Icon(Icons.error),
                                fit: BoxFit.fill,
                              ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 10.h,),
                                        Text(provider.productsOfCategory?[index].title??'',style: TextStyle(fontSize: 15.sp),overflow: TextOverflow.ellipsis,),
                                        SizedBox(height: 7.h,),
                                        Text((provider.productsOfCategory?[index].price.toString()??'')+" \$",style: TextStyle(fontSize: 15.sp,color: Colors.black54),),
                                        SizedBox(height: 15.h,),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        AppRouter.NavigatorToWidget(DetailsProductScreen(provider.productsOfCategory![index]));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5,top: 5,bottom: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: ColorsUi.Color2
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("View details",style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                            SizedBox(width: 15.w,),
                                            Icon(Icons.keyboard_arrow_right,color: Colors.white)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],

                                ),
                              ),
                            )
                          ],
                        )
                      );

                    },
                    childCount: provider.productsOfCategory?.length??0,
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


// ListTile(
// leading: ClipRRect(
// borderRadius: BorderRadius.circular(10),
// child: Image.network('https://api.lorem.space/image/furniture?w=640&h=480&r=9206',width: 80.w,)),
// title: Text('Tasty Steel Ball'),
// subtitle: Text("920 \$"),
// trailing: Icon(Icons.keyboard_arrow_right,color: ColorsUi.Color1,),
//
// ),
