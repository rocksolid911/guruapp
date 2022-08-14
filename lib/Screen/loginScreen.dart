import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:guruapp/Screen/otpScreen.dart';
import 'package:guruapp/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: PhoneLoginUser(),
        ));
  }
}

class PhoneLoginUser extends StatefulWidget {
  @override
  _PhoneLoginUserState createState() => _PhoneLoginUserState();
}

class _PhoneLoginUserState extends State<PhoneLoginUser> {
  TextEditingController _phonenoController = new TextEditingController();

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  // ignore: unused_field
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  final requiredValidator =
      RequiredValidator(errorText: 'this field is required');

  var isLoading = false;
  // ignore: unused_field
  bool _visible = false;
  String _phone;
  // ignore: non_constant_identifier_names
  var userphone;
  var userotp;
  // ignore: unused_field
  bool _autoValidate = false;

  void _postdata() async {
    setState(() {
      isLoading = true;
    });

    final form = _formKey.currentState;
    if (form.validate()) {
      _visible = true;
      form.save();
      print('Success Login');
      print(_phone);

      Map<String, dynamic> bodys = {'phone_no': _phone};
      String encodedBody =
          bodys.keys.map((key) => "$key=${bodys[key]}").join("&");
      var bodyEncoded = json.encode(bodys);
      print(bodyEncoded);

      var response = await http.post(
          Uri.parse(
              "http://myguruji.org/insight/tutorials-dev/public/api/auth/login-otp"),
          body: encodedBody,
          headers: {
            "charset": "utf-8",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      print(response);
      setState(() {
        isLoading = false;
      });
      int statusCode = response.statusCode;
      print(statusCode);
      print(response.body);
      
      if(response.statusCode==200){
        Map mapRes = json.decode(response.body);
      userphone = mapRes['phone'];
      userotp=mapRes['otp'];
      if (statusCode == 200) {
        var preferences = await SharedPreferences.getInstance();
        preferences.setString('phone', userphone);
        preferences.setInt('otp', userotp);
        preferences.setInt('status', statusCode);
        var status = preferences.getInt('status');
        print(status);
        // ignore: unused_local_variable
        var savedValue = preferences.getString('phone');

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OtpScreen(otp: userotp,)));
      }
      }

      // Map mapRes = json.decode(response.body);
      // userphone = mapRes['phone'];
      // userotp=mapRes['otp'];
      // if (statusCode == 200) {
      //   var preferences = await SharedPreferences.getInstance();
      //   preferences.setString('phone', userphone);
      //   preferences.setInt('otp', userotp);
      //   preferences.setInt('status', statusCode);
      //   var status = preferences.getInt('status');
      //   print(status);
      //   // ignore: unused_local_variable
      //   var savedValue = preferences.getString('phone');

      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => OtpScreen(otp: userotp,)));
      // } 
      else {
        _visible = true;
        print('user invalid');
       // _showMyDialog();
        Fluttertoast.showToast(
            msg: "OOps!! Server Unavailble, Please try after some time",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      print('Not true Validate');
      setState(() {
        isLoading = false;
      });
      setState(() {
        _autoValidate = true;
      });
    }
  }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Alert Message'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text("Invalid Authentication"),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           // ignore: deprecated_member_use
  //           FlatButton(
  //             child: Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff17181c),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img4.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 60.0),
                            child: Form(
                              key: _formKey,
                              child: Column(children: [
                                Image.asset(
                                  'assets/images/gurujilogo.png',
                                  width: 150,
                                  height: 150,
                                ),
                                SizedBox(height: 20),
                                Container(
                                    child: Text(
                                  "We will send you an One Time Password on this mobile number",
                                  style: TextStyle(
                                    fontFamily: 'AdventPro',
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                                SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  controller: _phonenoController,
                                  validator: validateMobile,
                                  onSaved: (value) => _phone = value,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      hintText: 'Enter Phone Number',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'AdventPro',
                                      ),
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.all(16),
                                      fillColor: Colors.black,
                                      filled: true,
                                      suffixIcon: Image.asset(
                                        'assets/images/phone.png',
                                        color: Colors.grey,
                                      )),
                                ),
                                SizedBox(height: 30),
                                new GestureDetector(
                                  onTap: () {
                                    check().then((intenet) {
                                      if (intenet != null && intenet) {
                                        _postdata();
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
                                  },
                                  child: !isLoading
                                      ? Container(
                                          alignment: Alignment.center,
                                          width: 180,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          decoration: BoxDecoration(
                                              color: Color(0xff040706),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'AdventPro',
                                            ),
                                          ),
                                        )
                                      : CircularProgressIndicator(),
                                ),
                              ]),
                            )))))));
  }
}
