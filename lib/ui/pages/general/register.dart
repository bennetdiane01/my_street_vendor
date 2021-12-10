import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_street_vendor/ui/pages/general/login.dart';
import 'package:my_street_vendor/ui/pages/buyers/main_menu.dart';
import 'package:my_street_vendor/ui/pages/buyers/map_page.dart';
import 'package:my_street_vendor/ui/pages/general/register_page_2.dart';
import 'package:my_street_vendor/ui/pages/general/splash_screen.dart';
import 'package:my_street_vendor/ui/pages/vendors/vendor_menu.dart';
import 'package:my_street_vendor/ui/shared/textfield.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressNoController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  //TextEditingController idTypeController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
   String? country;
   String? state;
   String? city;
   String? account_type;
   String? phoneNumber;
  final _formKey = GlobalKey<FormState>(); // for form state key

  //upload id card
  //user type

  _checkPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString('phone');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkPhoneNumber(); // to call this method on laod
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Lottie.asset('assets/lottie/logo_amination.json', repeat: false, height: 15.h),
              heightSpace,
              Text('Registration Page', textAlign: TextAlign.center, style: black18MediumTextStyle,),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              _txtFullname(),
              heightSpace,
              heightSpace,
              Column(
                children: [
                  /*DropdownSearch<String>(
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
                  heightSpace,*/
                  _txtAddress(),
                  heightSpace,
                  heightSpace,
                  _txtCountry(),
/*
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
*/
                  heightSpace,
                  heightSpace,
                  _txtState(),

/*
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
*/
                  heightSpace,
                  heightSpace,
                  _txtCity(),

/*
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
*/
                  heightSpace,
                  heightSpace,
                  DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: ["Vendor", "Buyer"],
                    //label: "Menu mode",
                    hint: "Select Account Type",
                    //popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: (data) {
                      print(data);
                      setState(() {
                        account_type = data;
                      });
                    },
                    //selectedItem: "Brazil",
                  ),
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
              heightSpace,
              heightSpace,
              _btnLogin(),
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
        ),
      ),
    );
  }

  //phone
  Widget _txtFullname() {
    return TextFormFieldWidget(
      hintText: "Enter Full Name",
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: fullnameController,
      onSubmitField: () {},
      parametersValidate: "Please Enter Full Name.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(200),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }
  //phone
  Widget _txtCountry() {
    return TextFormFieldWidget(
      hintText: "Enter Country e.g India",
      obscureText: false,
      textInputType: TextInputType.text,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: countryController,
      onSubmitField: () {},
      parametersValidate: "Please Enter Country.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(100),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }
  //phone
  Widget _txtState() {
    return TextFormFieldWidget(
      hintText: "Enter State",
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: stateController,
      onSubmitField: () {},
      parametersValidate: "Please Enter State.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(100),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }
  //phone
  Widget _txtCity() {
    return TextFormFieldWidget(
      hintText: "Enter City e.g Los Angeles",
      obscureText: false,
      textInputType: TextInputType.text,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: cityController,
      onSubmitField: () {},
      parametersValidate: "Please Enter City.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(100),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }

  // Phone
  Widget _txtPhone() {
    return TextFormFieldWidget(
      hintText: "Enter Phone Number",
      obscureText: false,
      textInputType: TextInputType.phone,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: phoneController,
      onSubmitField: () {},
      parametersValidate: "Please an phone number.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(11),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }

  //Password
  Widget _txtPassword() {
    return TextFormFieldWidget(
      hintText: "Enter Password",
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: passwordController,
      onSubmitField: () {},
      parametersValidate: "Please an password.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(150),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
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
      controller: idNumberController,
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
      controller: addressNoController,
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
        register();
        //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage2()));

      },
      child: Container(
        width: 90.w,
        height: 60,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text('Start Registration', style: white20SemiBoldTextStyle,)),
      ),
    );
  }

  // registration page
  register() async {
    print(phoneNumber);
    // Validate returns true if the form is valid, or false otherwise.
    if (!_formKey.currentState!.validate() || account_type == null || account_type == "") {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Check all input fields!'),
          backgroundColor: colorRed,),
      );
    }
   var response = await client.from('userDetails').update(
      {
        'full_name': fullnameController.text,
        'address': addressNoController.text,
        'country': countryController.text,
        'state': stateController.text,
        'city': cityController.text,
        'account_type': account_type,
        'is_verify': 1,
      },
    ).eq('phone', phoneNumber ).execute();
    print(response.toJson());
    if(response.status! > 210){
       return _errorDialog("Error", 'An error occured!');
    }
    _errorDialog("Successful", 'You data as been saved!');
    return Get.offAll(() => VendorMenu());
    /*if(account_type == "Vendor"){
      return Get.offAll(() => VendorMenu());
    } else if(account_type == "Buyer"){
      return Get.offAll(() => MainMenu());
    }*/
  }



  //Error dialog
  _errorDialog(title, content){
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: title,
          contentText: content,
          onPositiveClick: () {
            Navigator.of(context).pop();
          },
          /*onNegativeClick: () {
            Navigator.of(context).pop();
          },*/
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
}
