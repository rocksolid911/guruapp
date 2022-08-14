import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guruapp/widgets/widget.dart';

class MyPlan extends StatefulWidget {
  final List myplan;

  const MyPlan({Key key, this.myplan}) : super(key: key);

  @override
  _MyPlanState createState() => _MyPlanState();
}

class _MyPlanState extends State<MyPlan> {
  List abc;

  @override
  Widget build(BuildContext context) {
    abc = widget.myplan;
    return Scaffold(
      backgroundColor: Color(0xff17181c),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "My Plans",
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
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 100),
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: abc.length,
            // physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => Container(
              alignment: Alignment.center,
              width: 300,
              height: 100,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xffe03e4d),
                    const Color(0xffd1225a),
                    const Color(0xffe87233),
                  ]),
                  borderRadius: BorderRadius.circular(15)),
              child: new GestureDetector(
                onTap: () {
                  setState(() {
                    // _id = index;
                    // //subjectid
                    // subjectid = subjectdata[index]["id"].toString();
                    // subjectname = subjectdata[index]["subject_name"];
                    // print(subjectid);
                    // getSubjectName();

                    check().then((intenet) {
                      if (intenet != null && intenet) {
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

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectTeacherScreen(teacheruser: null,)));
                  });

                  // _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("You clicked item number $_id")));
                },
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xffe03e4d),
                        const Color(0xffd1225a),
                        const Color(0xffe87233),
                      ]),
                      borderRadius: BorderRadius.circular(15)),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      "subjectdata[index][subject_name]",
                      style: mediumTextStyle(),
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
}
