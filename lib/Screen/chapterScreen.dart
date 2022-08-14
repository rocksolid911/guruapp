import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guruapp/Screen/bottomNavigationScreen.dart';
import 'package:guruapp/Screen/planScreen.dart';
import 'package:guruapp/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChapterScreen extends StatefulWidget {
  final List chapteruser;
  final String teacheruser;
  final String classId;
  final String subjectId;
  final String subjectName;
  final String id;
  final String userID;
  final bool isLock;

  const ChapterScreen({
    Key key,
    @required this.chapteruser,
    this.teacheruser,
    this.classId,
    this.subjectId,
    this.subjectName,
    this.userID,
    this.id,
    this.isLock
  }) : super(key: key);

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  // ignore: unused_field
  int _id;
  String chapterid;
  bool fabIsVisible = true;
  var planlist;
  List planlistData;
  bool isLock;

  @override
  Widget build(BuildContext context) {
    List chapterList = widget.chapteruser;

    String teacherid = widget.teacheruser;
    print(teacherid);
    String userid = widget.userID;
    print(userid);

    String classid = widget.classId;
    print(classid);
    String subjectid = widget.subjectId;
    print(subjectid);
    String subjectname = widget.subjectName;
    print(subjectname);
    isLock=widget.isLock;

    getTopicList() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access');
      print(accessToken);

      var response = await http.get(
          Uri.parse(
              'http://myguruji.org/insight/tutorials-dev/public/api/auth/search_tutorials' +
                  "/" +
                  userid +
                  "/" +
                  classid +
                  "/" +
                  subjectid +
                  "/" +
                  teacherid +
                  "/" +
                  chapterid),
          headers: {
            "Authorization": "Bearer " + accessToken,
            "cache-control": "no-cache"
          });
      int statusCode = response.statusCode;
      print(statusCode);
      print(response.body);
      Map mapRes = json.decode(response.body);
      List data = mapRes['data'] as List;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationScreen(
                    teacherID: teacherid,
                    classID: classid,
                    subjectID: subjectid,
                    subjectName:subjectname,
                    useriD: userid,
                    data: data,
                    isLock: isLock,
                  )
              // SelectTopicScreen(data: data,
              //   )
              ));

      // } else {
      //   return showDialog<void>(
      //     context: context,
      //     barrierDismissible: false, // user must tap button!
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Text('Alert Message'),
      //         content: SingleChildScrollView(
      //           child: ListBody(
      //             children: <Widget>[
      //               Text("Data Not Found"),
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
    }

    getplanApi() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access');
      print(accessToken);

      var response = await http.get(
          Uri.parse(
              'http://myguruji.org/insight/tutorials-dev/public/api/plans' +
                  "/" +
                  classid +
                  "/" +
                  subjectid),
          headers: {
            "Authorization": "Bearer " + accessToken,
            "cache-control": "no-cache"
          });
      int statusCode = response.statusCode;
      print(statusCode);
      print(response.body);
      Map mapRes = json.decode(response.body);
      final data = mapRes['data'] as Map;

      // ignore: unused_local_variable
      for (final name in data.keys) {
        planlist = data["plans"];
        planlistData = planlist;

        if (statusCode == 200) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlanScreen(
                        planuser: planlistData,
                      )));
        }
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff17181c),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Select Chapter",
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          flexibleSpace: Container(
            //color: Colors.red,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xffe03e4d),
                  const Color(0xffd1225a),
                  const Color(0xffe87233),
                ]),
                borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(40.0),
                    bottomRight: const Radius.circular(40.0))),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: new GestureDetector(
            onTap: () {},
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: chapterList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    //color: Colors.red,
                    color: Color(0xff17181c),
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
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
                                chapterid = chapterList[index]["id"].toString();
                                print(chapterid);
                                getTopicList();
                              });
                            },
                            child: Container(
                                width: 250,
                                color: Color(0xff040706),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 14.0),
                                child: Text(
                                  chapterList[index]["chapter_name"],
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GestureDetector(
          onTap: () {
            check().then((intenet) {
              if (intenet != null && intenet) {
                getplanApi();
              } else {
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
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                "Upgrade",
                style: mediumTextStyle(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
