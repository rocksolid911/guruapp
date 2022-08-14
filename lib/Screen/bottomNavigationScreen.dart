import 'package:flutter/material.dart';
import 'package:guruapp/Screen/profile.dart';
import 'package:guruapp/Screen/selectTopicScreen.dart';

class NavigationScreen extends StatefulWidget {
  final String teacherID;
  final String classID;
  final String subjectID;
  final String subjectName;
  final useriD;
  final List data;
  final bool isLock;

  const NavigationScreen(
      {Key key,
      @required this.teacherID,
      this.classID,
      this.subjectID,
      this.subjectName,
      this.useriD,
      this.isLock,
      this.data})
      : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  var teacherList;
  var userinfo;
  String classid;
  String subjectid;
  int _currentIndex = 0;
  String subject;
  var subjectname;
  bool isLock;

  @override
  void initState() {
    // getSubjectName();
    super.initState();
  }

  // getSubjectName() async {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //      subject = prefs.getString('subjectname');
  //   }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    teacherList = widget.teacherID;
    userinfo = widget.useriD;
    print(userinfo);
    classid = widget.classID;
    print(classid);
    subjectid = widget.subjectID;
    print(subjectid);
    subjectname = widget.subjectName;
    print(subjectname);
    isLock = widget.isLock;

    final List<Widget> _children = [
      SelectTopicScreen(
        data: widget.data,
        namesubject: subjectname,
        isLock: widget.isLock,
      ),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Color(0xff17181c),
      body: _children[_currentIndex], // new
      bottomNavigationBar: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0)),
        child: Container(
          child: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            selectedLabelStyle: TextStyle(fontSize: 22),
            selectedItemColor: Colors.red,
          ),
/*          child: GradientBottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColorStart: const Color(0xffe87233),
            backgroundColorEnd: const Color(0xffd1225a),
            onTap: onTabTapped,
            // new
            currentIndex: _currentIndex,
            // new
            items: [
              new BottomNavigationBarItem(
                tooltip: "Home",
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                // ignore: deprecated_member_use
                label: 'Home',
              ),
              new BottomNavigationBarItem(
                  tooltip: "Profile",
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  // ignore: deprecated_member_use
                  label: 'Profile')
            ],
          ),*/
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
