import 'package:flutter/material.dart';
import 'package:ownervet/utils/const_color.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final double height;
  final double? buttonWidth, textFontSize;
  final Widget? child;
  final Color buttonColor;
  final bool addBorder;
  final Color? textColor;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    this.title,
    this.height = 52,
    this.child,
    this.buttonColor = AppColors.kPrimaryColor,
    this.buttonWidth,
    this.textFontSize,
    this.addBorder = false,
    this.textColor,
  })  : assert(
          title == null || child == null,
          'Cannot provide both a title and a child\n'
          'To provide both, use "child: Text(title)".',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onPressed,


      style: ButtonStyle(

        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16.0)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          return buttonColor;
        }),

        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          return buttonColor;
        }),

        //For text color,
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        //For border
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return BorderSide(
                color: buttonColor,
                width: 2,
              );
            else
              return BorderSide(color: buttonColor, width: 2);
          },
        ),
      ),
      child:
          Text(
            title!,
            style: TextStyle(
              color: textColor,
              fontSize: 17,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700,
            ),
          ),
    );
  }
}
