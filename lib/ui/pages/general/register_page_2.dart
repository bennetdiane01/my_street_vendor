import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:my_street_vendor/ui/shared/textfield.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:sizer/sizer.dart';

import '../buyers/main_menu.dart';
class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({Key? key}) : super(key: key);

  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressNoController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  //TextEditingController idTypeController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  //upload id card
  //user type
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["National ID", "Passport"],
            //label: "Menu mode",
            hint: "Select ID Type",
            //popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            //selectedItem: "Brazil",
          ),
          heightSpace,
          heightSpace,
          _txtIDnumber(),
          heightSpace,
          heightSpace,
          Text('Upload your ID photo below', style: black16SemiBoldTextStyle, textAlign: TextAlign.center,),
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DottedBorder(
                color: Colors.indigo,
                dashPattern: [8, 4],
                strokeWidth: 2,
                child: Container(
                  height: 150,
                  width: 35.w,
                  color: Colors.green.withAlpha(20),
                  child: ListView(
                    children: [
                      Lottie.asset('assets/lottie/upload.json'),
                      Text('Front Page', textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              DottedBorder(
                color: Colors.indigo,
                dashPattern: [8, 4],
                strokeWidth: 2,
                child: Container(
                  height: 150,
                  width: 35.w,
                  color: Colors.green.withAlpha(20),
                  child: ListView(
                    children: [
                      Lottie.asset('assets/lottie/upload.json'),
                      Text('Back Page', textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
            ],
          ),
          heightSpace,
          heightSpace,
          _txtAddress(),
          heightSpace,
          heightSpace,
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["India", "USA"],
            //label: "Menu mode",
            hint: "Select Country",
            //popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            //selectedItem: "Brazil",
          ),
          heightSpace,
          heightSpace,
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["India", "USA"],
            //label: "Menu mode",
            hint: "Select State",
            //popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            //selectedItem: "Brazil",
          ),
          heightSpace,
          heightSpace,
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["India", "USA"],
            //label: "Menu mode",
            hint: "Select City",
            //popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            //selectedItem: "Brazil",
          ),
          heightSpace,
          heightSpace,
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["Vendor", "Buyer"],
            //label: "Menu mode",
            hint: "Select Account Type",
            //popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            //selectedItem: "Brazil",
          ),
          heightSpace,
          heightSpace,
          _btnLogin(),
          heightSpace,
          heightSpace,
          heightSpace,
          /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                    child: Text("Already have an account? Login", style: black16MediumTextStyle,)
                ),
              ],
            )*/
        ],
      ),
    );
  }

  //ID number
  Widget _txtIDnumber() {
    return TextFormFieldWidget(
      hintText: "Enter Identity Number",
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: fullnameController,
      onSubmitField: () {},
      parametersValidate: "Please an identity number.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(11),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }

  //Address
  Widget _txtAddress() {
    return TextFormFieldWidget(
      hintText: "Enter Shop Number or Address",
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: fullnameController,
      onSubmitField: () {},
      parametersValidate: "Please an Shop Number or Address.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(350),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }

  // for btn login
  Widget _btnLogin(){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));

      },
      child: Container(
        width: 90.w,
        height: 60,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text("I'm done, take me in", style: white20SemiBoldTextStyle,)),
      ),
    );
  }

  /*Widget _idType(){
    return DropdownSearch<String>(
        mode: Mode.MENU,
        showSelectedItem: true,
        items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
        label: "Menu mode",
        hint: "country in menu mode",
        popupItemDisabled: (String s) => s.startsWith('I'),
        onChanged: print,
        selectedItem: "Brazil",
    );
  }*/
}
