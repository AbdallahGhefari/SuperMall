import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:superstore/Models/CategoryModel.dart';
import 'package:superstore/Models/ProductModel.dart';

import '../Data/DioHelper.dart';

class DioProvider extends ChangeNotifier{
  DioProvider(){
    getAllCategories();
    getAllProducts();
  }

  List<Category>? categories;
  String selectedCategory = '';
  List<Product>? products ;
  List<Product>? productsOfCategory;

  selectCategory(String idCategory){
    selectedCategory = idCategory;
    notifyListeners();
    log(products?.length.toString()??'null');
    // log(selectedCategory.toString());
    // log(products![1].categoryId.toString());

    if(selectedCategory == 'all'){
      productsOfCategory = products;
    }else{
      productsOfCategory = products?.where((element) {
        return element.category!.id.toString() == idCategory;
      }).toList();
    }
    // for(int i =0 ; i< products!.length ; i++){
    //   if (products?[i].category?.id.toString() == selectedCategory){
    //     productsOfCategory?.add(products![i]);
    //   }
    //   // log(products![i].category!.id.toString());
    // }
    notifyListeners();
    // log(productsOfCategory!.length.toString());
    // productsOfCategory = products!.map((e) (){
    //   if products[i].category!.name == selectedCategory
    // return products[i];
    // }
    // ).toList();
  }

  getAllCategories()async{
    categories = await DioHelper.dioHelper.getAllCategories();
    notifyListeners();
  }
  getAllProducts()async{
    products = await DioHelper.dioHelper.getAllProducts();
    notifyListeners();
    log('products lng = '+ (products?.length.toString()??'null'));
  }

  // getProductinCategory(String id)async{
  //   products!.where((element) {
  //     return element.category!.id!.toString() == id;
  //   }).toList();
  // }





}