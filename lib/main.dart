import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_street_vendor/ui/pages/buyers/main_menu.dart';
import 'package:my_street_vendor/ui/pages/general/splash_screen.dart';
import 'package:my_street_vendor/ui/pages/vendors/Recoder.dart';
import 'package:my_street_vendor/ui/pages/vendors/vendor_menu.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase/supabase.dart';

import 'ui/pages/general/login.dart';
import 'ui/pages/vendors/simple_recorder.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

 // final client = SupabaseClient('https://atjikuixrjhpeggdhbnm.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzMzkwNTM1NywiZXhwIjoxOTQ5NDgxMzU3fQ.ma2rjfQFG-0_DpNNj75MHkKqBwDg3-0VofTi713Uj6I');

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
            home: LoginPage(),
          );
        }
    );
  }
}
