import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xff17181c),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Privacy Policy",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 120, 10, 10),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Text(
              'We protect your information using commercially reasonable technical and administrative security measures to reduce the risks of loss, misuse, unauthorized access, disclosure and alteration. Although we take measures to secure your information, we do not promise, and you should not expect, that your personal information, or searches, or other information will always remain secure. We cannot guarantee the security of our information storage, nor can we guarantee that the information you supply will not be intercepted while being transmitted to and from us over the Internet including, without limitation, email and text transmissions. In the event that any information under our control is compromised as a result of a breach of security, we will take reasonable steps to investigate the situation and where appropriate, notify those individuals whose information may have been compromised and take other steps, in accordance with any applicable laws and regulations.',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 25,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'AdventPro',
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
