import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superstore/Models/ProductOfCart.dart';

import '../Models/ProductModel.dart';
import '../Models/UserApp.dart';

class StoreFirebaseHelper{
  StoreFirebaseHelper._();
  static StoreFirebaseHelper storeFirebaseHelper = StoreFirebaseHelper._();

  CollectionReference <Map<String,dynamic>> userCollection =  FirebaseFirestore.instance.collection('Users');

  addUserToFirestore(AppUser appUser)async{
    await userCollection.doc(appUser.id).set(appUser.toMap());
    // await userCollection.add(appUser.toMap());

  }

  Future<AppUser> getUserFromFirestore(String id)async{
    DocumentSnapshot <Map<String,dynamic>> documentSnapshot = await userCollection.doc(id).get();
    Map<String,dynamic>? data = documentSnapshot.data();
    return AppUser.fromMap(data!);
  }

  addProductOfCart(Product product,String idUser)async{
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(idUser)
        .collection('Cart')
        .doc(product.id.toString())
        .set(product.toJson());
  }

  Future<List<Product>> getCart(String idUser)async{
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(idUser)
        .collection('Cart')
        .get();
    List<QueryDocumentSnapshot<Map<String,dynamic>>> documents =querySnapshot.docs;

    List<Product> cart = documents.map((e) {
      Product product = Product.fromJson(e.data());
      product.id =  int.parse(e.id);
      return product;
    }).toList();
    print(cart.length);
    return cart;
  }

  deleteProductFromCart(String idProduct,String idUser)async{
    await FirebaseFirestore.instance.collection('Users').doc(idUser).collection('Cart').doc(idProduct).delete();
  }
  updateUser(AppUser appUser)async{
    await FirebaseFirestore.instance.collection('Users').doc(appUser.id).update(appUser.toMap());
  }










}