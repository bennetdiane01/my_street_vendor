import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_street_vendor/controller/update_profile_controller.dart';
import 'package:my_street_vendor/controller/vendor_online.dart';
import 'package:my_street_vendor/ui/shared/textfield.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:sizer/sizer.dart';

class UpdateProfileScreen extends StatelessWidget {


  final vendorUpdateController = Get.put(UpdateProfileController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                const Gap(30),
                Row(
                  children: [
                    IconButton(onPressed: (){},
                        icon: const Icon(Icons.arrow_back_ios)),
                    const Gap(50),
                    Text('Update your profile',
                      textAlign: TextAlign.center,
                      style: black18MediumTextStyle,),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      const Gap(30),
                      _txtFullname(),
                      const Gap(20),
                      _txtAddress(),
                      const Gap(20),
                      _txtEmail(),
                      const Gap(20),
                      _txtState(),
                      const Gap(20),
                      _txtCity(),
                      const Gap(20),
                      _txtCountry(),
                      const Gap(40),
                      _btnUpdate(),





                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _txtFullname() {
    return TextFormFieldWidget(
      hintText: "Enter Full Name",
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: vendorUpdateController.fullnameController,
      onSubmitField: () {},
      parametersValidate: "Please Enter Full Name.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(200),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }
  //phone
  Widget _txtEmail() {
    return TextFormFieldWidget(
      hintText: "Email Address",
      obscureText: false,
      textInputType: TextInputType.text,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: vendorUpdateController.emailController,
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
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: vendorUpdateController.stateController,
      onSubmitField: () {},
      parametersValidate: "Please Enter State.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(100),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }

  Widget _txtCountry() {
    return TextFormFieldWidget(
      hintText: "Enter Country",
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: vendorUpdateController.countryController,
      onSubmitField: () {},
      parametersValidate: "Please Enter Country.",
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
      controller: vendorUpdateController.cityController,
      onSubmitField: () {},
      parametersValidate: "Please Enter City.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(100),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }

  Widget _txtAddress() {
    return TextFormFieldWidget(
      hintText: "Enter Shop Number or Address",
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: vendorUpdateController.addressNoController,
      onSubmitField: () {},
      parametersValidate: "Please an Shop Number or Address.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(350),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }

  Widget _btnUpdate(){
    return InkWell(
      onTap: (){

        if (_formKey.currentState!.validate()) {
          vendorUpdateController.updateProfile();

        }

        //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage2()));

      },
      child: Container(
        width: 90.w,
        height: 60,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text('Update Profile', style: white20SemiBoldTextStyle,)),
      ),
    );
  }

}
