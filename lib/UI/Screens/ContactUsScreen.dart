import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';


import '../ColorsUi.dart';
import '../Widgets/TextFieldWidget.dart';

class ContactUsScreen extends StatefulWidget {
   ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController massage = TextEditingController();
  // late FocusNode myFocusNode;
  // @override
  // void initState() {
  //   super.initState();
  //   myFocusNode = FocusNode();
  // }
  // @override
  // void dispose() {
  //   // Clean up the focus node when the Form is disposed.
  //   myFocusNode.dispose();
  //
  //   super.dispose();
  // }


   Future<void> sendBYWhatsApp(String phone , String massage) async {
     String url = "whatsapp://send?phone=$phone&text=${Uri.encodeFull(massage)}";
     launchUrl(
       Uri.parse(url),
     );
   }

   Future<void> sendBYSMS(String phone , String massage) async {
     launchUrl(
       Uri.parse("sms:$phone?body=${Uri.encodeFull(massage)}"),

     );
   }
  Future<void> callPhone() async {
    launchUrl(
      Uri.parse("tel:0594301380"),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Contact Us'),

        centerTitle: true,
        elevation: 0,
        foregroundColor: ColorsUi.Color2,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Send Massage',style: TextStyle(fontSize: 20.sp,color: ColorsUi.Color2),),
                SizedBox(height: 30.h,),
                TextFormField(
                  // autofocus: false,
                  // focusNode: myFocusNode,
                  maxLines: 7,
                    controller: massage,
                    style: TextStyle(fontSize: 20.sp),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: ColorsUi.Color2, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: ColorsUi.Color2, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: ColorsUi.Color2, width: 2),
                      ),
                      // prefixIcon: icon,
                      labelText: 'Massage',
                      labelStyle: TextStyle(color: ColorsUi.Color3),
                      hintText: 'Write your massage',
                      hintStyle: TextStyle(fontSize: 15.sp,color: Colors.grey.shade300),
                    )
                ),
                SizedBox(height: 15.h,),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    GestureDetector(
                      onTap: (){
                        sendBYSMS('+972592838976', massage.text);

                      },
                        child: Image.asset('assets/images/sms (1).png',height: 50.h,)),
                      SizedBox(width: 15.w,),
                    GestureDetector(
                      onTap: (){
                        sendBYWhatsApp('+972592838976', massage.text);
                      },
                        child: Image.asset('assets/images/whatsapp (2).png',height: 50.h,)),
                  ],

                  ),

                ),
                Divider(
                  height: 50.h,
                ),
                // SizedBox(height: 15.h,),
                Text('Call Us',style: TextStyle(fontSize: 25.sp,color: ColorsUi.Color2),),
                SizedBox(height: 15.h,),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                      onTap: (){
                        callPhone();

                      },
                      child: Image.asset('assets/images/telephone.png',height: 50.h,)),
                ),




              ],
            ),
          ),
        ),
      ),

    );
  }
}
