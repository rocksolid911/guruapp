import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoPlayerScreen extends StatefulWidget {
  final String videoname;
  static String videoCodeId;

  const YouTubeVideoPlayerScreen({
    Key key,
    this.videoname,
  }) : super(key: key);

  @override
  _YouTubeVideoPlayerScreenState createState() =>
      _YouTubeVideoPlayerScreenState();
}

class _YouTubeVideoPlayerScreenState extends State<YouTubeVideoPlayerScreen> {
 
  YoutubePlayerController _controller;

 @override
  void initState() {
SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoname,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          
          
        )
        
    );


    super.initState();
  }

  @override
dispose(){
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
    //var newcode = widget.videoname;
    
    // YoutubePlayerController(
    //     initialVideoId: newcode,
    //     flags: YoutubePlayerFlags(
    //       autoPlay: true,
    //       mute: false,
    //     ));

  

    return Scaffold(
      
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   // leading: new GestureDetector(
      //   //   onTap: () {
      //   //     Navigator.pop(context);
      //   //   },
      //   //   child: Container(
      //   //     margin: EdgeInsets.symmetric(horizontal: 10.0),
      //   //     child: Row(children: [
      //   //       new Image.asset("assets/images/back.png",
      //   //           fit: BoxFit.cover,
      //   //           height: 20.00,
      //   //           color: Colors.grey,
      //   //           width: 20.00),
      //   //     ]),
      //   //   ),
      //   // ),
      // ),
      // body: Center(
      //         child: SafeArea(
      //           child: SingleChildScrollView(
      //             child: Container(
      //               width: MediaQuery.of(context).size.width,
      //           child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //           // Text('you have pushed the button this many times:',),
      //           YoutubePlayer(
                  
      //         controller: _controller,
      //         showVideoProgressIndicator: true,
      //         progressIndicatorColor: Colors.blueAccent,
      //           )
      //           ],
      //         )),
      //     ),
      //   ),
      // ),

      body: OrientationBuilder(builder: 
       (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return Scaffold(
      body: youtubeHierarchy(),
          );
        } else {
          return Scaffold(
            primary: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        primary: false,
      // title: Text("widget.title"),
      ),
      body: youtubeHierarchy(),
            );
          }
        }),
            );
          }
          
              youtubeHierarchy() {
  return Container(
    width: MediaQuery.of(context).size.width,
  child: Align(
    alignment: Alignment.center,
    child: FittedBox(
      fit: BoxFit.fill,
      child: YoutubePlayer(
                
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
              ),
    ),
  ),
  );
 } }



