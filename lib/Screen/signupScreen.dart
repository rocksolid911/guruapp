import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guruapp/Screen/loginScreen.dart';

import 'package:guruapp/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//import 'mainScreen.dart';
//import 'package:guruapp/Screen/mainScreen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phonenoController = new TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  // ignore: unused_field
  String _email;
  // ignore: unused_field
  String _password;
  // ignore: unused_field
  String _name;
  // ignore: unused_field
  String _phone;
  bool autoValidate = false;
  String registername;

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validatePassword(String value) {
    Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (value.length == 0) {
      return "Password is Required";
    } else if (!regex.hasMatch(value))
      return 'Password required: Alphabet, Number & 8 chars';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff17181c),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img2.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    'assets/images/gurujilogo.png',
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Create an account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                                SizedBox(height: 25),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  autofocus: false,
                                  controller: _nameController,
                                  validator: validateName,
                                  onSaved: (value) => _name = value,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      hintText: 'Enter Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.all(16),
                                      fillColor: Colors.black,
                                      filled: true,
                                      suffixIcon: Image.asset(
                                        'assets/images/name.png',
                                        color: Colors.grey,
                                      )),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  controller: _emailController,
                                  validator: validateEmail,
                                  onSaved: (value) => _email = value,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      hintText: 'Enter Email',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.all(16),
                                      fillColor: Colors.black,
                                      filled: true,
                                      suffixIcon: Image.asset(
                                        'assets/images/email.png',
                                        color: Colors.grey,
                                      )),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  controller: _phonenoController,
                                  validator: validateMobile,
                                  onSaved: (value) => _phone = value,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      hintText: 'Enter PhoneNumber',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.all(16),
                                      fillColor: Colors.black,
                                      filled: true,
                                      suffixIcon: Image.asset(
                                        'assets/images/phone.png',
                                        color: Colors.grey,
                                      )),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    controller: _passwordController,
                                    validator: validatePassword,
                                    onSaved: (value) => _password = value,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        hintText: 'Enter Password',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        focusedBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.all(16),
                                        fillColor: Colors.black,
                                        filled: true,
                                        suffixIcon: Image.asset(
                                          'assets/images/password.png',
                                          color: Colors.grey,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                new GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState.validate()) {
                                      check().then((intenet) {
                                        if (intenet != null && intenet) {
                                          registrationUser();
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please check the Internet Connection",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.pink,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      });

                                      //print("Successful");
                                      // Navigator.push(context,
                                      //  MaterialPageRoute(builder: (context) {
                                      //   return MainScreen(classdata);
                                      // }));
                                    } else {
                                      setState(() {
                                        // validation error
                                        autoValidate = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 180,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    decoration: BoxDecoration(
                                        color: Color(0xff040706),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(width: 5),
                                    new GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                        );
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                            )))))));
  }

  Future abc() async {
    var prefer = await SharedPreferences.getInstance();
    registername = prefer.getString("name");
    print(registername);
  }

  Future registrationUser() async {
    // url to registration php script
    var apiurl =
        "http://myguruji.org/insight/tutorials-dev/public/api/auth/signup";
    //json maping user entered details
    Map mapeddate = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone_no': _phonenoController.text,
      'password': _passwordController.text,
      'password_confirmation': _passwordController.text,
    };
    //send  data using http post to our php code
    http.Response response =
        await http.post(Uri.parse(apiurl), body: mapeddate);

    //getting response from php code, here
    var data = jsonDecode(response.body);
    print("DATA: $data");

    if (data[0]["status_code"] == 201) {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => OtpScreen(otp: ,)));
    } else {
      Fluttertoast.showToast(
          msg: "error!! Please check it again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
