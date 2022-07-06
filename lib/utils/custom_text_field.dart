import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/validator.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? labelText, hintText;
  final String? initialValue, prefixText, suffixText;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType keyboardType;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final ValueChanged<String?>? onChanged, onSaved;
  final int? maxLength, maxLines;
  final int minLines;
  final bool readOnly, addHint, enabled;
  final bool? isDense;
  final Function()? onTap;
  final InputBorder? border;
  final AutovalidateMode autovalidateMode;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? prefixIconPadding;
  final Color? fillColor;
  final bool obscureText;
  final bool inputFormmat;

  const CustomTextFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator = Validators.validateEmpty,
    this.onChanged,
    this.onSaved,
    this.maxLength,
    this.maxLines,
    this.minLines = 1,
    this.initialValue,
    this.readOnly = false,
    this.onTap,
    this.border,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.addHint = false,
    this.suffixIconConstraints,
    this.prefixText,
    this.suffixText,
    this.isDense,
    this.prefixIconPadding,
    this.fillColor,
    this.inputFormmat=false,
    this.obscureText=false,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      initialValue: initialValue,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      onSaved: onSaved,
      enabled: enabled,
      obscureText:obscureText ,

      inputFormatters: inputFormmat?  [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
    ]:null,
      style:  TextStyle(
          fontSize: 17,
          fontFamily: "Quicksand",
          fontWeight: FontWeight.w500,
          color: AppColors.text_color),
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: fillColor != null,
        isDense: isDense,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        contentPadding: EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 1,color: AppColors.green),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 1,color: AppColors.green),
        ),
        // alignLabelWithHint: maxLines == null,
        labelText: addHint
            ? null
            : ((controller?.text != null || !readOnly) ? labelText : null),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black),
        labelStyle:TextStyle(fontSize: 15,fontFamily: "Quicksand",fontWeight: FontWeight.w500,color: AppColors.text_color),
        errorStyle: TextStyle(fontSize: 10,fontFamily: "Quicksand",fontWeight: FontWeight.w500,color: AppColors.green),

        prefixIcon: prefixIcon == null ? null : Padding(padding: prefixIconPadding ?? EdgeInsets.only(left: 15,right: 15), child: prefixIcon,),
        prefixText: prefixText,
        suffixText: suffixText,

        suffixIcon: suffixIcon == null ? null : Padding(padding: prefixIconPadding ?? EdgeInsets.only(left: 15,right: 15), child: suffixIcon,),

      ),
    );
  }
}
