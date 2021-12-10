import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';

/// *  textInputType - The type of information for which to optimize the text input control.
/// *  hintText - Text that suggests what sort of input the field accepts.
/// *  prefixIcon - Pass Icon if required
/// *  defaultText - If there is predefined value is there for a text field
/// *  focusNode - Currently focus
/// *  obscureText - Is Password field?
/// *  controller - Text controller
/// *  functionValidate - Validation function(currently I have used to check empty field)
/// *  parametersValidate - Value to validate
/// *  actionKeyboard - Keyboard action eg. next, done, search, etc
/// *  onSubmitField - Done click action
/// *  onFieldTap - On focus on TextField
class TextFormFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  final bool? obscureText;
  final TextEditingController? controller;
  final Function? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final Function? onSubmitField;
  final Function? onFieldTap;
  final Color? txtColor;
  final int? maxLine;
  final bool? enable;
  //final Function? onChangeed;
  final LengthLimitingTextInputFormatter? inputLength;
  final FilteringTextInputFormatter? filteringTextInputFormatter;



  const TextFormFieldWidget(
      {@required this.hintText,
        this.focusNode,
        this.textInputType,
        this.defaultText,
        this.obscureText = false,
        this.controller,
        this.functionValidate,
        this.parametersValidate,
        this.actionKeyboard = TextInputAction.next,
        this.onSubmitField,
        this.onFieldTap,
        this.prefixIcon,
        this.txtColor,
        this.maxLine = 1,
        this.enable = true,
        //this.onChangeed,
        this.inputLength,
        this.filteringTextInputFormatter,
      });

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: primaryColor,
      ),
      child: Container(
        //height: 300,
        decoration: BoxDecoration(
          //color: Color(0xff2D2D2D),
            borderRadius: BorderRadius.circular(5),
            //border: Border.all(color: primaryColor)
        ),
        child: TextFormField(
          cursorColor: primaryColor,
          //onChanged: widget.onChangeed!(),
          obscureText: widget.obscureText!,
          keyboardType: widget.textInputType,
          textInputAction: widget.actionKeyboard,
          focusNode: widget.focusNode,
          maxLines: widget.maxLine,
          enabled: widget.enable,
          style: TextStyle(
            color: secondaryColor,
            fontSize: 16.0,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          inputFormatters: [
            //LengthLimitingTextInputFormatter(3),
            widget.inputLength!,
            //widget.filteringTextInputFormatter,
          ],
          initialValue: widget.defaultText,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            fillColor: contentColor,
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(5)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(5)

            ),
            hintStyle: TextStyle(
              color: primaryColor,
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            contentPadding: EdgeInsets.only(
                top: 25, bottom: bottomPaddingToError, left: 25.0, right: 8.0),
            isDense: true,
            errorStyle: TextStyle(
              color: colorRed,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorRed),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorRed),
            ),
          ),
          controller: widget.controller,
          validator: (value) {
            if (widget.functionValidate != null) {
              String resultValidate =
              widget.functionValidate!(value, widget.parametersValidate);
              if (resultValidate != null) {
                return resultValidate;
              }
            }
            return null;
          },
          onFieldSubmitted: (value) {
            if (widget.onSubmitField != null) widget.onSubmitField!();
          },
          onTap: () {
            if (widget.onFieldTap != null) widget.onFieldTap!();
          },
        ),
      ),
    );
  }
}

String? commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}