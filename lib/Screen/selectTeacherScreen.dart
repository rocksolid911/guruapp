import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guruapp/Screen/chapterScreen.dart';
//import 'package:guruapp/Screen/chapterScreen.dart';
//import 'package:guruapp/Screen/selectTopicScreen.dart';
import 'package:guruapp/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//import 'bottomNavigationScreen.dart';

class SelectTeacherScreen extends StatefulWidget {
  final List teacheruser;
  final String classId;
  final String subjectId;
  final String subjectname;
  final String id;
  final userID;
  final bool isLock;

  const SelectTeacherScreen({
    Key key,
    @required this.teacheruser,
    this.classId,
    this.subjectId,
    this.subjectname,
    this.userID,
    this.id,
    this.isLock,
  }) : super(key: key);

  @override
  _SelectTeacherScreenState createState() => _SelectTeacherScreenState();
}

class _SelectTeacherScreenState extends State<SelectTeacherScreen> {
  // ignore: unused_field
  int _id;
  String teacherid;
  var chapterlist;
  List chapterListData;
  bool isLock;
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    List teacherList = widget.teacheruser;
    var userinfo = widget.userID;
    // ignore: unused_local_variable
    String userid = userinfo["id"].toString();
    // String username=userinfo["name"];
    // print(username);
    // String useremail=userinfo["email"];
    // print(useremail);
    String userphone=userinfo["phone_no"].toString();
    print(userphone);
    String classid = widget.classId;
    print(classid);
    String subjectid = widget.subjectId;
    print(subjectid);

    String subjectname=widget.subjectname;
    print (subjectname);

    print(userinfo);

     isLock=widget.isLock;


    getchapterList() async{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      String accessToken= prefs.getString('access');
      print(accessToken);

      // prefs.setString('username', username);
      // prefs.setString('useremail', useremail);
      prefs.setString('userphone', userphone);
      

      var response=await http.get(
        Uri.parse('http://myguruji.org/insight/tutorials-dev/public/api/auth/get_chapters'+
        "/"+ classid + "/" + subjectid + "/" + teacherid),

        headers: {
          "Authorization": "Bearer " + accessToken,
          "cache-control": "no-cache"
        });
        int statusCode= response.statusCode;
        print(statusCode);
        print(response.body);
        Map mapRes=json.decode(response.body);
         final data = mapRes['data'] as Map;
        // ignore: unused_local_variable
        for (final name in data.keys) {
        chapterlist = data["chapters"];
        chapterListData = chapterlist;

        if(statusCode==200){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChapterScreen(
            chapteruser: chapterListData,teacheruser:teacherid,classId:classid,subjectId:subjectid,
            subjectName:subjectname,userID:userid,isLock: isLock,
         )));
        }
      }  
    }
  



   
   if (teacherList.isNotEmpty) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xff17181c),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Select Teacher", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 130),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/img1.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: new GestureDetector(
              onTap: () {},
              child: ListView.builder(
                  itemCount: teacherList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Color(0xff17181c),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Card(
                        color: Color(0xff040706),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(children: [
                            Container(
                              width: 55.0,
                              height: 65.0,
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.purple,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.black,
                                    backgroundImage: AssetImage(
                                        'assets/images/gurujilogo.png'),
                                  )),
                            ),
                            new GestureDetector(
                              onTap: () {
                                setState(() {
                                  _id = index;
                                  teacherid =
                                      teacherList[index]["id"].toString();
                                  print(teacherid);
                                  check().then((intenet) {
                                      if (intenet != null && intenet) {
                                        getchapterList();
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
                                 
                                 // getTopicList();
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 220,
                                color: Color(0xff040706),
                                  padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 14.0),
                                  child: Text(
                                    teacherList[index]["teacher_name"],
                                    style: mediumTextStyle(),
                                  )),
                            )
                          ]),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xff17181c),
        appBar: AppBar(
          title: Text("Select Teacher", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 100),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Text(
              "No Teacher Found",
              style: TextStyle(
                  color: Colors.white, fontSize: 25, fontFamily: 'AdventPro'),
            ),
          ),
        ),
      );
    }
  }
}
