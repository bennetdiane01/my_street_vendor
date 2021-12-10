import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_street_vendor/ui/pages/buyers/main_menu.dart';
import 'package:my_street_vendor/ui/pages/general/splash_screen.dart';
import 'package:my_street_vendor/ui/pages/vendors/vendor_menu.dart';
import 'package:sizer/sizer.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, screenType){
          return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: VendorMenu(),
          );
        }
    );
  }
}
