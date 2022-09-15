

import 'dart:developer';

import 'package:dio/dio.dart';

import '../Models/CategoryModel.dart';
import '../Models/ProductModel.dart';

class DioHelper{
 DioHelper._();
 static DioHelper dioHelper = DioHelper._();

 Dio dio = Dio();




 Future<List<Category>> getAllCategories()async{
   Response response = await dio.get('https://api.escuelajs.co/api/v1/categories/');
   // log(response.data.toString());
   List cats = response.data;
   List<Category> categories = cats.map((e) => Category.fromJson(e)).toList();
   log(response.data.toString());
   return categories;
 }

 Future<List<Product>> getAllProducts()async{
   Response response = await dio.get('https://api.escuelajs.co/api/v1/products');
   log(response.data.toString());
   List pros = response.data;
   List<Product> products = pros.map((e) => Product.fromJson(e)).toList();
   log(response.data.toString());
   return products;
 }




 //  Future<List<Products>> getProductsCategory(String category)async{
 //   // log('https://dummyjson.com/products/category/$category');
 //   Response response = await dio.get('https://dummyjson.com/products/category/$category');
 //   // log(response.data.toString());
 //   ProductModel productModel = ProductModel.fromJson(response.data);
 //   List<Products>? products = productModel.products;
 //   log(products!.length.toString());
 //   return products;
 // }



}