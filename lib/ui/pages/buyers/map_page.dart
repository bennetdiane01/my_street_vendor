import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:my_street_vendor/controller/map_controller.dart';
import 'package:my_street_vendor/models/mapModel.dart';
import 'package:my_street_vendor/ui/pages/general/music_app.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'dart:ui' as ui;
import 'package:sizer/sizer.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final mapController = Get.put(MapController());

  Coffee? elementArray;

  bool _showBottomSheet = false;

  GoogleMapController? _controller;

  List<Marker> allMarkers = [];

  PageController? _pageController;

  int? prevPage;

  bool playing = false; // at the begining we are not playing any song
  IconData playBtn = Icons.play_circle_outline; // the main state of the play button icon

  //Now let's start by creating our music player
  //first let's declare some object
  AudioPlayer? _player;
  AudioCache? cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _showBottomSheet; // To set the bottom sheet invisible
    coffeeShops.forEach((element) async {
      final Uint8List markerIcon = await getBytesFromAsset('assets/images/vendor.png', 100);

      allMarkers.add(
          Marker(
          markerId: MarkerId(element.shopName!),
          onTap: () {
            //_pageController!.animateToPage(page, duration: duration, curve: curve);
            moveCamera1(element.locationCoords);
            elementArray = element;
            setState(() {
              _showBottomSheet = true;
            });
            //_onScroll();
          },
          icon: BitmapDescriptor.fromBytes(markerIcon),
          draggable: false,
          infoWindow:
          InfoWindow(title: element.shopName, snippet: element.address),
          position: element.locationCoords!));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);

    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    //now let's handle the audioplayer time

    //this function will allow you to get the music duration
    _player!.onDurationChanged.listen((event) {
      setState(() {
        musicLength = event;
      });
    });
    /*_player!.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };*/

    //this function will allow us to move the cursor of the slider while we are playing the song
    _player!.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  void _onScroll() {
    if (_pageController!.page!.toInt() != prevPage) {
      print(_pageController!.page);
      prevPage = _pageController!.page!.toInt();
      //Navigator.push(context, MaterialPageRoute(builder: (context) => MusicApp()));
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController!,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController!.position.haveDimensions) {
          value = (_pageController!.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 1.w,
                      vertical: 1.w,
                    ),
                    //height: 30.h,
                    //width: 80.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: colorRed,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                      //height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white ),
                        child: Row(children: [
                          Container(
                              height: 100.h,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          coffeeShops[index].thumbNail!),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coffeeShops[index].shopName!,
                                  style: const TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  coffeeShops[index].address!,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    coffeeShops[index].description!,
                                    style: const TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello Dear,', style: black18MediumTextStyle,),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: whiteColor,
        ),
        body: Stack(
          //fit: StackFit.expand,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: const CameraPosition(
                    target: LatLng(40.7128, -74.0060), zoom: 14.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
                mapType: MapType.normal,
              ),
            ),
            _showBottomSheet == false ? Text('') : Positioned(
              bottom: 0.h,
              child: Container(
                height: 100.h,
                width: 100.w,
                child: DraggableScrollableSheet(
                  initialChildSize: 0.3,
                    maxChildSize: 0.4,
                    builder: (context, controller){
                    mapController.isSaved.value =
                        mapController.savedVendor.contains(elementArray);
                      return Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30)
                          )
                        ),
                        child: ListView(
                          children: [
                            Text(
                              elementArray!.shopName!,
                              style: black16SemiBoldTextStyle,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 3.h,),
                            Row(
                              children: [
                                InkWell(
                                    child: Icon(playBtn, color: blackColor, size: 30,),
                                  onTap: (){
                                    if (!playing) {
                                      //now let's play the song
                                      cache!.play("audios/test.mp3");
                                      setState(() {
                                        playBtn = Icons.pause;
                                        playing = true;
                                      });
                                    } else {
                                      _player!.pause();
                                      setState(() {
                                        playBtn = Icons.play_arrow;
                                        playing = false;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(width: 3.w,),
                                //Icon(Icons.pause_circle_filled, color: blackColor, size: 30,),
                                Container(
                                  //width: 2.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      slider(),
                                      Text(
                                        "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 3.w,),
                              ],
                            ),
                            SizedBox(height: 3.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      lottie.Lottie.asset('assets/lottie/hello.json'),
                                      Text('Hi!', style: black16SemiBoldTextStyle.copyWith(color: whiteColor),)
                                    ],
                                  ),
                                ),


                                InkWell(
                                  onTap: (){
                                    if(mapController.isSaved.value) {
                                      mapController.savedVendor
                                          .remove(elementArray!);
                                      mapController.isSaved.value = false;
                                      debugPrint('removed');

                                    }else {
                                      mapController.savedVendor.add(
                                          elementArray!);
                                      mapController.isSaved.value =true;

                                      debugPrint('saved');


                                        }
                                      },

                                  child: Container(
                                    width: 40.w,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(5))
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                         Obx(()=>Icon(Icons.favorite,
                                             color:mapController.isSaved.value ? Colors.red: Colors.white)),



                                        Text('Favorite', style: black16SemiBoldTextStyle.copyWith(color: whiteColor),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      );
                    },
                ),
              ),

            ),
            /*Positioned(
              bottom: 0.h,
              child: Container(
                height: 20.h,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: coffeeShops.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _coffeeShopList(index);
                  },
                ),
              ),
            )*/
          ],
        ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: coffeeShops[_pageController!.page!.toInt()].locationCoords!,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
  moveCamera1(target) {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: target,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  //Slider for audio
  Widget slider() {
    return Container(
      width: 55.w,
      child: Slider.adaptive(
          activeColor: Colors.blue[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          },
        onChangeEnd: (value) {
            print(value);
            if (position.inSeconds == value){
              playBtn = Icons.play_circle_outline;
              //print('finished');
            }
        },
      ),
    );
  }
  //let's create the seek function that will allow us to go to a certain position of the music
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player!.seek(newPos);
  }

}
