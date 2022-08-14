// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:guruapp/Screen/myplan.dart';
//import 'package:guruapp/Screen/profile.dart';
import 'package:guruapp/Screen/youtubeVideoPalyerScreen.dart';
// import 'package:http/http.dart' as http;

import 'package:guruapp/widgets/widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SelectTopicScreen extends StatefulWidget {
  final List data;
  final String namesubject;
  final bool isLock;


  const SelectTopicScreen({Key key, this.isLock,this.data, this.namesubject})
      : super(key: key);
  @override
  _SelectTopicScreenState createState() => _SelectTopicScreenState();
}

class _SelectTopicScreenState extends State<SelectTopicScreen> {
  var isLoading = false;
  // List myplanList;

  // getMyPlanList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String accessToken = prefs.getString('access');
  //   print(accessToken);

  //   var response = await http.get(
  //       Uri.parse('http://myguruji.org/insight/tutorials-dev/api/my-plans'),
  //       headers: {
  //         "Authorization": "Bearer " + accessToken,
  //         "cache-control": "no-cache"
  //       });
  //   int statusCode = response.statusCode;
  //   print(statusCode);
  //   print(response.body);
  //   final result = json.decode(response.body.toString());
  //   print(result);
  //    myplanList=result;
  
    
  //   // ignore: unused_local_variable
  //   // for (final name in data.keys) {
  //   //   teacherlist = data["teachers"];
  //   //   teacherListData = teacherlist;
  //   // }
  //   if (statusCode == 200) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => MyPlan(myplan: myplanList,),
  //         ));
  //   }
  // }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List topicdata = widget.data;
    var subjectt = widget.namesubject;
    // ignore: unused_local_variable
    var videoname, parts;
    var videoCode;
    var isfree;
    bool isLock=widget.isLock;

    return Scaffold(
        backgroundColor: Color(0xff17181c),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "$subjectt Topics",
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            flexibleSpace: Container(
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
        body: (topicdata.isNotEmpty)
            ? ListView.builder(
                itemCount: topicdata.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                      color: Color(0xff17181c),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Card(
                              color: Color(0xff040706),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(children: [
                                  Container(
                                    width: 65.0,
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
                                  Container(
                                      width: 175,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Text(
                                        topicdata[index]["video_name"],
                                        // topic.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: mediumTextStyle(),
                                      ))
                                ]),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            // child:
                            // new GestureDetector(
                            //   onTap: () {

                            //   },
                            child: Card(
                                color: Color(0xff040706),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Container(
                                    height: 65,
                                    child:
                                    //  (topicdata[index]["is_free"] == 0)
                                    //     ?
                                    (isLock==true)?
                                         IconButton(
                                            icon: Icon(Icons.play_circle_fill),
                                            color: Colors.white,
                                            onPressed: () {
                                              videoCode = calcultevideoCode(
                                                  topicdata[index]
                                                      ["video_link"]);
                                              print(videoCode);
                                              print(topicdata[index]
                                                  ["video_link"]);
                                              //status of paid or unpaid
                                              //
                                              isfree =
                                                  topicdata[index]["is_free"];
                                              print(isfree);

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        YouTubeVideoPlayerScreen(
                                                      videoname: videoCode,
                                                    ),
                                                  ));
                                            }):
                                         (topicdata[index]["is_free"] == 0)
                                        ?IconButton(
                                            icon: Icon(
                                              Icons.lock,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please purchase the course",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.pink,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              // getMyPlanList();
                                            },
                                          ):IconButton(
                                            icon: Icon(
                                              Icons.play_circle_fill,
                                              color: Colors.white,
                                            ),
                                            onPressed: (){
                                               videoCode = calcultevideoCode(
                                                  topicdata[index]
                                                      ["video_link"]);
                                              print(videoCode);
                                              print(topicdata[index]
                                                  ["video_link"]);
                                              //status of paid or unpaid
                                              //
                                              isfree =
                                                  topicdata[index]["is_free"];
                                              print(isfree);

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        YouTubeVideoPlayerScreen(
                                                      videoname: videoCode,
                                                    ),
                                                  ));
                                            },)),
                          
                            )) ],
                      ),
                    ))
            : Dialog(
                backgroundColor: const Color(0xffb414141),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                    width: 400,
                    height: 230,
                    padding: EdgeInsets.all(16),
                    child: Column(
                        //mainAxisSize: MainAxisSize.min,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No Data here yet..',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              height: 150,
                              width: 150,
                              child: Image(
                                image:
                                    AssetImage("assets/images/dialogicon.png"),
                              ),
                            ),
                          )
                        ]))));
  }

  calcultevideoCode(var videoLink) {
    var parts = videoLink.split('/');
    var videoCode = parts[3].trim();
    return videoCode;
  }
}
