import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:my_street_vendor/ui/shared/textfield.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:sizer/sizer.dart';

class UpdateProfileScreen extends StatelessWidget {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressNoController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              const Gap(30),
              Text('Update your profile',
                textAlign: TextAlign.center,
                style: black18MediumTextStyle,),
              const Gap(30),
              _txtFullname(),
              const Gap(20),
              _txtAddress(),
              const Gap(20),
              _txtCountry(),
              const Gap(20),
              _txtState(),
              const Gap(20),
              _txtCity(),
              const Gap(40),





            ],
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

  Widget _btnUpdate(){
    return InkWell(
      onTap: (){

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

}
