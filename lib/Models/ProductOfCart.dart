class ProductOfCart{

  String? id;
  int? quantity;

  ProductOfCart({required this.id,required this.quantity});

  Map<String,dynamic> toMap(){
    return{
      "id" : id,
      "quantity" : quantity
    };
  }


  factory ProductOfCart.fromMap(Map<String,dynamic> map){
    return ProductOfCart(
      id: map["id"] ,
      quantity: map["quantity"]
    );
  }


}