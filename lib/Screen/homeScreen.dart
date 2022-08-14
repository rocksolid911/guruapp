import "package:flutter/material.dart";
import 'package:guruapp/Screen/loginScreen.dart';
import 'package:guruapp/Screen/signupScreen.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
 backgroundColor:  Color(0xff17181c),


  body: Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
       

        child: SingleChildScrollView(
          
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height ,
           // alignment: Alignment.bottomCenter,
            child: Container(
              padding:EdgeInsets.symmetric(horizontal:24),
              child:Container(
                width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal:10.0,vertical: 120.0),
                              child: Column(
                    
                    children: [

                      Image.asset('assets/images/gurujilogo.png',width: 150,height: 150,),
                       SizedBox(height: 20,),
                      Text("Create a free account",style:TextStyle(color:Colors.white)),
                      SizedBox(height:20),
                       new GestureDetector(
                         onTap: (){
                           Navigator.push(
                          context,
                             MaterialPageRoute(builder: (context) => SignupScreen()),
                            );
                         },
                              child: Container(
                              alignment: Alignment.center,
                              width:200,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                gradient: LinearGradient(
                           colors: [
                             const Color(0xffe03e4d),
                             const Color(0xffd1225a),
                             const Color(0xffe87233),
                           ]
                         ), 
                
                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text("Create an account", style:mediumTextStyle(),),
                            ),
                        ),
                        SizedBox(height:20),
                        
                        new GestureDetector(
                            onTap: (){
                           Navigator.push(
                          context,
                             MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                         },
                            child: Container(
                               
                            alignment: Alignment.center,
                            width: 200,
                          
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            decoration: BoxDecoration(
                              
                              color: Color(0xff040706),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text("Login", style:TextStyle(color: Colors.white),),
                          ),
                        ),
                  ],),
              )
            ),

          )
        ),
      
      ),
      );
  }
}

