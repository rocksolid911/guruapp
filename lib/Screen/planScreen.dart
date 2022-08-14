//import 'dart:convert';

import 'dart:convert';
import 'package:guruapp/Screen/mainScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guruapp/widgets/widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class PlanScreen extends StatefulWidget {
  final List planuser;

  const PlanScreen({
    Key key,
    @required this.planuser,
  }) : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Razorpay razorpay;
  String amountname;
  String planid;
  var razororderid;

  String paymentid;
  String orderid;
  String signature;
  String razorOrderid;
  String accessToken;
  String username;
  String useremail;
  String userphone;
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
  var token;

  createOrderRazorApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access');
    print(accessToken);
    Map<String, dynamic> bodys = {'plan_id': planid};
    String encodedBody =
        bodys.keys.map((key) => "$key=${bodys[key]}").join("&");
    var bodyEncoded = json.encode(bodys);
    print(bodyEncoded);

    var response = await http.post(
        Uri.parse('http://myguruji.org/insight/tutorials-dev/public/api/torder'),
        body: encodedBody,
        headers: {
          "Authorization": "Bearer " + accessToken,
          "charset": "utf-8",
          "Content-Type": "application/x-www-form-urlencoded"
        });
    print(response);

    int statusCode = response.statusCode;
    print(statusCode);
    print(response.body);
    Map mapRes = json.decode(response.body);
    final data = mapRes['data'] as Map;
    // ignore: unused_local_variable
    for (final name in data.keys) {
      razororderid = data["razor_order_id"];
      print(razororderid);
    }
    if (statusCode == 200) {
      openCheckout();
    } else {
      Fluttertoast.showToast(
          msg: "Please try after some time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    super.initState();

    getuserdata();

   
  }

  getuserdata() async{
    var prefs = await SharedPreferences.getInstance();
    username = prefs.getString('name');
    useremail = prefs.getString('email');
    userphone = prefs.getString('phone');
    getData();
  }

  getData() async{
    var preferences = await SharedPreferences.getInstance();
    var body = preferences.getString("data");
    var hdj = jsonDecode(body);
    print(hdj);
    Map mapRes = json.decode(hdj);
    final data = mapRes['data'] as Map;
    // ignore: unused_local_variable
    for (final name in data.keys) {
      userinfo = data["user_info"];
      userclasses = data["classes"];
      usersubjects = data["subjects"];
      print(userclasses);

      userid = userinfo;
      userClassData = userclasses;
      userSubjectData = usersubjects;
    }
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_Whvej7XOtpLDDb',
      // 'key_secret':'HL3AnjnYZP2u8SU3owF3kkM9',
      'amount': num.parse(amountname) * 100,
      'order_id': razororderid,
      'name': 'My Guruji',
      'prefill': {'contact': userphone, 'email': useremail},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentid = response.paymentId;
    orderid = response.orderId;
    signature = response.signature;
    razorOrderid = razororderid;

    check().then((intenet) {
      if (intenet != null && intenet) {
        getSuccessPaymentApi();
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
  }

  getSuccessPaymentApi() async {
    Map<String, dynamic> bodys = {
      'razorpay_payment_id': paymentid,
      'razorpay_order_id': razorOrderid,
      'razorpay_signature': signature,
      'order_id': orderid
    };
    String encodedBody =
        bodys.keys.map((key) => "$key=${bodys[key]}").join("&");
    var bodyEncoded = json.encode(bodys);
    print(bodyEncoded);
    var response = await http.post(
        Uri.parse(
            'http://myguruji.org/insight/tutorials-dev/api/order/verify-payment'),
        body: encodedBody,
        headers: {
          "Authorization": "Bearer " + accessToken,
          "charset": "utf-8",
          "Content-Type": "application/x-www-form-urlencoded"
        });
    print(response);

    int statusCode = response.statusCode;
    print(statusCode);
    print(response.body);

    if (statusCode == 200) {
      Fluttertoast.showToast(msg: "PAYMENT SUCCESS ");
      Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreen(classdata: userClassData,subjectdata: userSubjectData,
                userID: userid,)));
    } else {
      Fluttertoast.showToast(msg: "Please Try After Some Time: ");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    List planList = widget.planuser;
    return Scaffold(
      backgroundColor: Color(0xff17181c),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Plans",
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
      body: Dialog(
        elevation:  5,
        backgroundColor: const Color(0xffb414141),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          
        ),
        child: Container(
          width: 400,
          height: 350,
  //         decoration: new BoxDecoration(
  //   boxShadow: [
  //     BoxShadow(
  //       color: const Color(0xffb414141),
  //       blurRadius: 2.0, // soften the shadow
  //      // spreadRadius: 0.0, //extend the shadow
        
  //     )
  //   ],
  // ),
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: planList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Center(
              child: Column(children: [
                Container(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/gurujilogo.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    planList[index]["subject_name"],
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'AdventPro',
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    "Rs. " + planList[index]["amount"],
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'AdventPro',
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    planid = planList[index]["id"].toString();

                    amountname = planList[index]["amount"];
                    check().then((intenet) {
                      if (intenet != null && intenet) {
                        createOrderRazorApi();
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
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xffe03e4d),
                          const Color(0xffd1225a),
                          const Color(0xffe87233),
                        ]),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "Unlock",
                        style: mediumTextStyle(),
                      ),
                    ),
                  ),
                )
              ]),
            ),

            // itemBuilder: (BuildContext context, int index) => Container(
            //   height: 150,
            //       color: Color(0xff17181c),
            //       width: MediaQuery.of(context).size.width,
            //       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            //       child: Row(
            //         children: [
            //           Expanded(
            //             flex: 4,
            //             child: Card(
            //               color: Color(0xff040706),
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(20.0)),
            //               child: Container(
            //                   padding: EdgeInsets.symmetric(horizontal: 10.0),
            //                   child: Row(children: [
            //                     Container(
            //                       width: 65.0,
            //                       height: 65.0,
            //                       child: CircleAvatar(
            //                           radius: 60,
            //                           backgroundColor: Colors.purple,
            //                           child: CircleAvatar(
            //                             radius: 40,
            //                             backgroundColor: Colors.black,
            //                             backgroundImage: AssetImage(
            //                                 'assets/images/gurujilogo.png'),
            //                           )),
            //                     ),
            //                     Container(
            //                         width: 100,
            //                         padding: EdgeInsets.symmetric(
            //                             horizontal: 5.0, vertical: 5.0),
            //                         child: Text(
            //                           planList[index]["subject_name"],
            //                           // topic.name,
            //                           //maxLines: 2,
            //                           //overflow: TextOverflow.ellipsis,
            //                           style: mediumTextStyle(),
            //                         )),
            //                     Expanded(
            //                            child: Container(
            //                           //width: 80,
            //                           padding: EdgeInsets.symmetric(
            //                               horizontal: 15.0, vertical: 5.0),
            //                           child: Text(
            //                             "(" + planList[index]["amount"] + ")",
            //                             // topic.name,
            //                             //maxLines: 2,
            //                             //overflow: TextOverflow.ellipsis,
            //                             style: mediumTextStyle(),
            //                           )),
            //                     ),
            //                   ])),
            //             ),
            //           ),
            //           Expanded(
            //               flex: 1,
            //               child: Card(
            //                   color: Color(0xff040706),
            //                   shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(20.0)),
            //                   child: GestureDetector(
            //                     onTap: () {
            //                       planid = planList[index]["id"].toString();

            //                       amountname = planList[index]["amount"];
            //                       check().then((intenet) {
            //                             if (intenet != null && intenet) {
            //                                createOrderRazorApi();
            //                             } else {
            //                               Fluttertoast.showToast(
            //                                   msg:
            //                                   "Please check the Internet Connection",
            //                                   toastLength: Toast.LENGTH_SHORT,
            //                                   gravity: ToastGravity.BOTTOM,
            //                                   timeInSecForIosWeb: 1,
            //                                   backgroundColor: Colors.pink,
            //                                   textColor: Colors.white,
            //                                   fontSize: 16.0);
            //                             }
            //                           });

            //                     },
            //                     child: Container(
            //                         height: 65,
            //                         child: Icon(Icons.lock, color: Colors.white)

            //                         // child: IconButton(
            //                         //   color: Colors.grey,
            //                         //    icon:Icon(Icons.lock),
            //                         //    onPressed: () {
            //                         //     planid=planList[index]["id"];
            //                         //     amountname=planList[index]["amount"];
            //                         //     createOrderRazorApi();

            //                         //    },
            //                         // ),
            //                         ),
            //                   )))
            //         ],
            //       ),
            //     )
          ),
        ),
      ),
    );
  }
}
