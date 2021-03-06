import 'package:flutter/material.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';

/// * This is a sample button I have created for my view. You can modify your button and make a consistent UI.
/// onClick - Button click
/// text - Button text
/// textColor - Button textColor
/// color - Button Background color
/// splashColor - Color displayed when the button is touched
/// borderRadius - Button border radius
/// minWidth - Minimum width of a button
/// height - Button height
/// borderSideColor - Border Color
/// style - Button textstyle
/// leadingIcon - If you want to display an icon before button text
/// trailingIcon - If you want to display an icon after button text
ButtonTheme raisedButton(
    {VoidCallback ? onClick,
      String? text,
      Color? textColor,
      Color? color,
      Color? splashColor,
      double? borderRadius,
      double? minWidth,
      double? height,
      Color? borderSideColor,
      TextStyle? style,
      Widget? leadingIcon,
      Widget? trailingIcon}) {
  return ButtonTheme(
    minWidth: minWidth!,
    height: height!/1.2,
    child: RaisedButton(
        splashColor: Colors.grey!.withOpacity(0.5) ?? colorBlack,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25),
            side: BorderSide(color: borderSideColor ?? color!)),
        textColor: Colors.white,
        color: color,
        elevation: 0.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // This is must when you are using Row widget inside Raised Button
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLeadingIcon(leadingIcon!),
            Text(
              text ?? '',
              style: TextStyle(
                color: textColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              ),
            ),
            _buildTrailingIcon(trailingIcon!),
          ],
        ),
        onPressed: () {
          return onClick!();
        }),
  );
}

Widget _buildLeadingIcon(Widget leadingIcon) {
  if (leadingIcon != null) {
    return Row(
      children: <Widget>[leadingIcon, SizedBox(width: 10)],
    );
  }
  return Container();
}

Widget _buildTrailingIcon(Widget trailingIcon) {
  if (trailingIcon != null) {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        trailingIcon,
      ],
    );
  }
  return Container();
}