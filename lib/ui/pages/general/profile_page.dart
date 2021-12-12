import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

import 'package:lottie/lottie.dart' as lottie;
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:sizer/sizer.dart';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = new Color.fromRGBO(0, 117, 194, opacity);

    double size = rect.width / 2;
    double area = size * size;
    double radius = sqrt(area * value / 4);

    final Paint paint = new Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //start animation
    _animationController = new AnimationController(
      vsync: this,
    );
    _startAnimation();

  }
  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void _startAnimation() {
    //_animationController!.stop();
    //_animationController!.reset();
    _animationController!.repeat(
      period: Duration(seconds: 1),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Profile'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        //elevation: 0.0,
      ),
      body: Container(
        height: 100.h,
        child: ListView(
          children: [
            Column(
              children: [
                CustomPaint(
                  painter: SpritePainter(_animationController!),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    alignment: Alignment.center,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: lottie.Lottie.asset('assets/lottie/humans.json'),
                    )
                    //color: colorRed,
                  ),
                ),
                Text('Boss Daina', style: black18MediumTextStyle,),
              ],
            ),
            _displayUserDetails(),
            //Text('Boss Daina', style: black18MediumTextStyle,),
          ],
        ),
      ),
/*
      floatingActionButton: FloatingActionButton(
        onPressed: _startAnimation,
        child: Icon(Icons.play_arrow),
      ),
*/
    );
  }
  
  ///for displaying user details
  Widget _displayUserDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Feather.mail),
                SizedBox(width: 10.w,),
                Container(
                  width: 50.w,
                    child: Text('dianeeamil@email.com', style: black16RegularTextStyle,)),
                //const Icon(Feather.arrow_right_circle)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Feather.phone),
                SizedBox(width: 10.w,),
                Container(
                  width: 50.w,
                    child: Text('154255454544', style: black16RegularTextStyle,)),
                //const Icon(Feather.arrow_right_circle)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Feather.map_pin),
                SizedBox(width: 10.w,),
                Container(
                  width: 50.w,
                    child: Text('Block 24, Diana Avenue, New York, United State', style: black16RegularTextStyle,)),
                //const Icon(Feather.arrow_right_circle)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Feather.bookmark),
                SizedBox(width: 10.w,),
                Container(
                  width: 50.w,
                    child: Text('Verified', style: black16RegularTextStyle,)),
                //const Icon(Feather.arrow_right_circle)
              ],
            ),
          ),
          SizedBox(height: 5.h,),
          _btnUpdate(),
        ],
      ),
    );
  }

  //update profile
  Widget _btnUpdate(){
    return InkWell(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));

      },
      child: Container(
        width: 60.w,
        height: 60,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text("Update profile", style: white20SemiBoldTextStyle,)),
      ),
    );
  }

}
