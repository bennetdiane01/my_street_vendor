import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

import 'package:map_launcher/map_launcher.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:url_launcher/url_launcher.dart';

class VendorRequest extends StatefulWidget {
  const VendorRequest({Key? key}) : super(key: key);

  @override
  _VendorRequestState createState() => _VendorRequestState();
}


class _VendorRequestState extends State<VendorRequest> {
  _launchURL() async {
    const url = 'https://flutterdevs.com/';
    await launch(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  final String _url = 'https://flutter.dev';
  //void _launchURL() async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  openMapsSheet(context) async {
    try {
      final coords = Coords(37.759392, -122.5107336);
      final title = "Ocean Beach";
      final availableMaps = await MapLauncher.installedMaps;
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: Icon(Feather.map_pin,
                          size: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
        appBar: AppBar(
          title: const Text('Requests'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        child: ListView(
          children: [
            _requestCard()
          ],
        ),
      )
    );
  }

  //for request card
  Widget _requestCard(){
    return Card(
      color: colorWhite,
      margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      child: Container(
        padding: EdgeInsets.all(2.h),
        child: Row(
          children: [
            Container(
              height: 7.h,
              width: 7.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                    image: AssetImage('assets/images/vendor.png'),
                  )
              ),
            ),
            SizedBox(width: 5.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Daina Betty', style: black18MediumTextStyle,),
                SizedBox(height: 1.h,),
                Text('24 km', style: black12RegularTextStyle,),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Feather.map),
                      //child: Text('Direction'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
                        onPrimary: Colors.white,
                        shape: StadiumBorder()
                      ),
                      onPressed: () {
                        print('Pressed');
                        openMapsSheet(context);
                      },
                      label: Text('Direction'),
                    ),
                    SizedBox(width: 1.h,),

                    ElevatedButton.icon(
                      icon: Icon(Feather.phone_call),
                      //child: Text('Direction'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                        onPrimary: Colors.blue,
                        side: BorderSide(color: Colors.blue),
                        shape: StadiumBorder()
                      ),
                      onPressed: () {
                        print('Pressedbb');
                        _launchURL;
                      },
                      label: Text('Call'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
