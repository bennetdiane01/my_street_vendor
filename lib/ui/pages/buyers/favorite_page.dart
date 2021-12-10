import 'package:flutter/material.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart' as lottie;
class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Vendors'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        child: ListView(
          children: [
            _vendorList(),
            _vendorList(),
            _vendorList(),
            _vendorList(),
            _vendorList(),
            _vendorList(),
            _vendorList(),
            _vendorList(),
            _vendorList(),
          ],
        ),
      ),
      );
  }

  Widget _vendorList() {
    return Card(
      color: colorWhite,
      margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      child: Container(
        padding: EdgeInsets.all(2.h),
        child: Row(
          children: [
            Container(
              height: 8.h,
              width: 8.h,
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
                Text('Daina Stores', style: black18MediumTextStyle,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.circle, color: Colors.red, size: 10,),
                    SizedBox(width: 10,),
                    Text('Offline')
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              width: 25.w,
              height: 50,
              decoration: BoxDecoration(
                  color: lightlGreen,
                  borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  lottie.Lottie.asset('assets/lottie/hello.json'),
                  Text('Hi!', style: black16SemiBoldTextStyle,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
