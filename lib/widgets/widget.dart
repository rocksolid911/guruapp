import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset('assets/images/logo.png', height: 50),
  );
}

InputDecoration textPhoneInputDecoration(String hintText){
       return InputDecoration(
            hintText: hintText,
                              hintStyle: TextStyle(color: Colors.grey),
                              // focusedBorder: InputBorder.none,
                              // errorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.black,
                                filled: true,
                                suffixIcon: Image.asset(
                  'assets/images/phone.png',
                                  color:Colors.grey,
                                ) );
}

InputDecoration textPasswordInputDecoration(String hintText){
       return InputDecoration(
            hintText: hintText,
                              hintStyle: TextStyle(color: Colors.grey),
                              // focusedBorder: InputBorder.none,
                              // errorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.black,
                                filled: true,
                                suffixIcon: Image.asset(
                  'assets/images/password.png',
                                  color:Colors.grey,
                                ) );
}

 Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }



TextStyle simpleTextStyle(){
   return TextStyle(
     color: Colors.blue,
     fontSize: 14,
   );
}

TextStyle mediumTextStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontFamily: 'AdventPro',
  );
}