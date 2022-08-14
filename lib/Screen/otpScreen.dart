
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guruapp/Screen/mainScreen.dart';
import 'package:guruapp/widgets/widget.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class OtpScreen extends StatefulWidget {
 final int otp;


   OtpScreen({
    Key key,
    @required this.otp,
    
  }) : super(key: key);


  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String pinValue;
  // ignore: unused_field
  var isLoading = false;
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
  var phoneotp;


//   @override
//   void initState() {
//    getotp();
//     super.initState();
//   }
  
// getotp() async{
//   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
//   phoneotp =sharedPreferences.getInt('otp');
//   print(phoneotp);
// }

  getStringValuesSF() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String phoneValue = prefs.getString('phone');
    phoneotp=prefs.getInt('otp');
    print(phoneValue);
    print(pinValue);

    Map<String, dynamic> bodys = {'phone_no': phoneValue, 'otp': pinValue};
    String encodedBody =
        bodys.keys.map((key) => "$key=${bodys[key]}").join("&");
    var bodyEncoded = json.encode(bodys);
    print(bodyEncoded);
    var response = await http.post(
        Uri.parse(
            'http://myguruji.org/insight/tutorials-dev/public/api/auth/verify-otp'),
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
    Map mapRes = json.decode(response.body);

    var preferences = await SharedPreferences.getInstance();
    String str = json.encode(response.body);
    print(str);
    preferences.setString("data", str);

    final data = mapRes['data'] as Map;
    // ignore: unused_local_variable
    for (final name in data.keys) {
      accesstoken = data["access_token"];
      userinfo = data["user_info"];
      userclasses = data["classes"];
      usersubjects = data["subjects"];
      print(userclasses);

      useraccesstoken = accesstoken;
      userid = userinfo;
      
      userClassData = userclasses;
      userSubjectData = usersubjects;
    }

    if (accesstoken != null) {
      var prefer = await SharedPreferences.getInstance();
      prefer.setString('access', accesstoken);
      // prefer.setString('userinfo', userinfo);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen(
                  classdata: userClassData,
                  subjectdata: userSubjectData,
                  userID: userid)));
    } else {
      Fluttertoast.showToast(
          msg: "Please check the verification code",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }



  @override
  Widget build(BuildContext context) {
     phoneotp=widget.otp;

     return Scaffold(
       backgroundColor: Color(0xff17181c),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img2.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 120),
              height: 150,
              child: Center(
                  child: Text(
                "Verification Code is $phoneotp",
                style: TextStyle(
                    color: Colors.purple[50],
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'AdventPro'),
                textAlign: TextAlign.center,
              )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: Center(
                  child: Text(
                "Enter the Verification Code",
                style: TextStyle(
                    color: Colors.purple[50],
                    fontSize: 25,
                    fontFamily: 'AdventPro'),
                textAlign: TextAlign.center,
              )),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: PinEntryTextField(
                  showFieldAsBox: true,

                  onSubmit: (String pin) {
                    pinValue = '$pin';
                  }, // end onSubmit
                ), // end PinEntryTextField()
              ), // end Padding()
            ),
            SizedBox(height: 20),
            new GestureDetector(
              onTap: () {
                check().then((intenet) {
      if (intenet != null && intenet) {
         getStringValuesSF();
      }
      else{
        Fluttertoast.showToast(
          msg: "Please check the Internet Connection",
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
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                          color: Color(0xff040706),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Verify",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : CircularProgressIndicator(),
            ),
          ]),
        ),
      ),
    );
  }
}
