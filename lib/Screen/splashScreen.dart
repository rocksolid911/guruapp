import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:guruapp/Screen/container.dart';
import 'package:guruapp/Screen/loginScreen.dart';
import 'package:guruapp/Screen/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var login;
  var accesstoken;
  var userinfo;
  var data;
  var userclasses;
  var usersubjects;
  var id;

  var userclassname;
  String mapToStr;
  List userClassData;
  List userSubjectData;
  var useraccesstoken;
  var userid;
  var user;
  var token;

  @override
  void initState() {
    _abc();
    super.initState();
  }

  Future _abc() async {
    var prefer = await SharedPreferences.getInstance();
    token = prefer.getString("access");

   
    Timer(Duration(seconds: 3), () async {
      setState(() {
        login = token;
      });

      if (login == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      } 
      else {

    var preferences = await SharedPreferences.getInstance();
    var body = preferences.getString("data");
    var hdj = jsonDecode(body);
    print(hdj);
    Map mapRes = json.decode(hdj);
    final data = mapRes['data'] as Map;
    // ignore: unused_local_variable
    for (final name in data.keys) {
      userinfo = data["user_info"];
      userclasses = data["classes"];
      usersubjects = data["subjects"];
      print(userclasses);

      userid = userinfo;
      userClassData = userclasses;
      userSubjectData = usersubjects;
    }


        Navigator.push(context,MaterialPageRoute(builder: (context) => MainScreen(
        classdata: userClassData,subjectdata: userSubjectData,userID: userid)));
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>ContainScreen())); 
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17181c),
      body: Center(
        child: Image.asset(
          'assets/images/gurujilogo.png',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}


