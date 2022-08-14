import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:guruapp/Screen/profile.dart';
import 'package:guruapp/Screen/subjectScreen.dart';
import 'package:guruapp/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  final List classdata;
  final List subjectdata;
  final userID;

  MainScreen({Key key, this.classdata, this.subjectdata, this.userID})
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var classid;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phonenoController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  int _classid;
  // ignore: unused_field
  String _name;
  // ignore: unused_field
  String _email;
  // ignore: unused_field
  String _phone;
  String username;
  String useremail;
  String userphone;
  bool isDialog = true;
  var myplanList;
  var subjectPlanId;
  List<String> messagesString;
 
  @override
  void initState() {
    super.initState();
     getdialogdata();
   
  }

  getdialogdata() async {
    var prefs = await SharedPreferences.getInstance();
    username = prefs.getString('name');
    useremail = prefs.getString('email');
    userphone = prefs.getString('phone');
    if (username == null || username == "") {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _displayDialog(context));
    }
    print(isDialog);
     getMyPlanList();
  }

  abc() async {
    var prefer = await SharedPreferences.getInstance();
    prefer.setString('name', _nameController.text);
    prefer.setString('email', _emailController.text);
    prefer.setString('phone', _phonenoController.text);
    //prefer.setBool('showDialog', isDialog);
  }

  getMyPlanList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access');
    print(accessToken);

    var response = await http.get(
        Uri.parse('http://myguruji.org/insight/tutorials-dev/api/my-plans'),
        headers: {
          "Authorization": "Bearer " + accessToken,
          "cache-control": "no-cache"
        });
    int statusCode = response.statusCode;
    print(statusCode);
    print(response.body);
    final result = json.decode(response.body.toString());
    print(result);
    myplanList = result;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setStringList('string_list_key', myplanList);
    
    // getdialogdata();

    // ignore: unused_local_variable
    // for (final name in data.keys) {
    //   teacherlist = data["teachers"];
    //   teacherListData = teacherlist;
    // }
  }

  

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
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

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    List newclass = widget.classdata;
    List subjectname = widget.subjectdata;
    var userinfo = widget.userID;
    

    print(userinfo);
    print(newclass);
    print(subjectname);

    return WillPopScope(
      onWillPop: onbackpressed,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xff17181c),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Select Class", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/img3.png"),
              //fit: BoxFit.cover,
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Container(
              width: 250,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: newclass.length,
                itemBuilder: (BuildContext context, int index) => Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xff72327c),
                        const Color(0xffba3395),
                      ]),
                      borderRadius: BorderRadius.circular(10)),
                  child: new GestureDetector(
                    onTap: () {
                      setState(() {
                        _classid = index;
                        // ignore: unused_local_variable
                        final fruitMap = newclass.asMap();
                        // subjectPlanId=myplanList[index]["id"].toString();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubjectScreen(
                                      classs: newclass,
                                      subject: subjectname,
                                      id: newclass[index]["id"].toString(),
                                      userID: userinfo,
                                      myplan: myplanList,
                                    )));
                      });
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color(0xff72327c),
                            const Color(0xffba3395),
                          ]),
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          newclass[index]["class"] + "th",
                          style: mediumTextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onbackpressed() {
    exit(0);
  }

  void _displayDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.grey[800],
              content: Container(
                height: 310,
                width: 300,
                color: Colors.grey[800],
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Text(
                      "Details are required",
                      style: mediumTextStyle(),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      // initialValue: _name,
                      keyboardType: TextInputType.name,
                      autofocus: false,
                      controller: _nameController,
                      validator: validateName,
                      onSaved: (value) => _name = value,

                      //enabled: false,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Enter Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Color(0xff17181c),
                          filled: true,
                          suffixIcon: Image.asset(
                            'assets/images/name.png',
                            color: Colors.grey,
                          )),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      // initialValue: useremail,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      controller: _emailController,
                      validator: validateEmail,
                      onSaved: (value) => _email = value,

                      // enabled: false,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Color(0xff17181c),
                          filled: true,
                          suffixIcon: Image.asset(
                            'assets/images/email.png',
                            color: Colors.grey,
                          )),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _phonenoController,
                      validator: validateMobile,
                      onSaved: (value) => _phone = value,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Enter PhoneNumber',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Color(0xff17181c),
                          filled: true,
                          suffixIcon: Image.asset(
                            'assets/images/phone.png',
                            color: Colors.grey,
                          )),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        abc();
                        // isDialog = false;
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          Navigator.pop(context, true);
                        } else {
                          print("enter the field");
                        }
                      },
                      child: Container(
                        height: 50,

                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xffe03e4d),
                              const Color(0xffd1225a),
                              const Color(0xffe87233),
                            ]),
                            borderRadius: BorderRadius.circular(15)),
                        // height: MediaQuery.of(context).size.height,
                        width: 100,
                        child: Center(
                          child: Text(
                            "Ok",
                            style: mediumTextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }
}
