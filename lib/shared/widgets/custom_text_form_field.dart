import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/appcolors.dart';
import '../../configs/constants.dart';

class MyRawsurTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final IconData? suffixIcon;
  final Widget? prefixIcon;
  // final Color? fillColor;
  final void Function()? onPressed;
  final void Function()? onChanged;
  final bool? enabled;
  final bool? obscureText;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final Color? color;

  const MyRawsurTextFormField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.keyboardType,
      this.validator,
      this.suffixIcon,
      this.prefixIcon,
      // this.fillColor,
      this.onPressed,
      this.enabled = true,
      this.obscureText = false,
      this.focusNode,
      this.autovalidateMode,
      this.inputFormatters,
      this.maxLines,
      this.onChanged,
      this.color})
      : super(key: key);

  @override
  _MyRawsurTextFormFieldState createState() => _MyRawsurTextFormFieldState();
}

class _MyRawsurTextFormFieldState extends State<MyRawsurTextFormField> {
  @override
  Widget build(BuildContext context) {
    void _changed(String value) {
      if (widget.onChanged != null) {
        widget.onChanged!();
      }
    }

    return TextFormField(
      onChanged: _changed,
      maxLines: widget.maxLines ?? 1,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      obscureText: widget.obscureText!,
      style: TextStyle(color: widget.color ?? AppColors.BLUE),
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.color ?? AppColors.BLUE),
          borderRadius: appRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.color ?? AppColors.BLUE),
          borderRadius: appRadius,
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: widget.color ?? AppColors.BLUE,
          fontSize: MediaQuery.of(context).size.width * .03,
          fontWeight: FontWeight.w700,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        // fillColor: widget.fillColor,
        // filled: false,
        border: OutlineInputBorder(borderRadius: appRadius),
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: Icon(widget.suffixIcon,
                    color: widget.color ?? AppColors.BLUE),
                onPressed: widget.onPressed,
              )
            : null,
        prefixIcon: widget.prefixIcon != null
            ? Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: appRadius),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ), // Utilisez le même rayon de bordure que celui de votre BoxDecoration
                  child: widget.prefixIcon, // Votre contenu à arrondir
                ),
              )
            : null,
      ),
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      autovalidateMode:
          widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
    );
  }
}
