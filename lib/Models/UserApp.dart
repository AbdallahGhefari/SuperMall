class AppUser{

  String email;
  String? id;
  String? password;
  String userName;
  String phone;

  AppUser({required this.email,required this.userName,required this.phone,this.id,this.password});

  Map<String,dynamic> toMap(){
    return{
      "email" : email,
      "userName" : userName,
      "phone" : phone,
      "password" : password,
      "id" : id,
    };
  }


  factory AppUser.fromMap(Map<String,dynamic> map){
    return AppUser(
      email: map["email"] ,
      userName: map["userName"] ,
      phone: map["phone"] ,
      password: map["password"]
    );
  }


}