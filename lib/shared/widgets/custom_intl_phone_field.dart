import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../constants/appcolors.dart';
import '../constants/style.dart';

class CustomIntlPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String? initialCountryCode;
  final String labelText;
  final String searchLabelText;
  final String? invalidNumberMessage;
  final String? Function(PhoneNumber?)? validator;
  final void Function(Country)? onCountryChanged;

  const CustomIntlPhoneField({
    Key? key,
    required this.controller,
    this.initialCountryCode,
    required this.labelText,
    required this.searchLabelText,
    this.invalidNumberMessage,
    this.validator,
    this.onCountryChanged,
    required Color color,
  }) : super(key: key);

  @override
  _CustomIntlPhoneFieldState createState() => _CustomIntlPhoneFieldState();
}

class _CustomIntlPhoneFieldState extends State<CustomIntlPhoneField> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.controller,
      style: TextStyle(color: AppColors.MAIN_COLOR),
      initialCountryCode: widget.initialCountryCode ?? 'CG',
      decoration: InputDecoration(
        labelText: widget.labelText,
        counterText: '',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.MAIN_COLOR),
          borderRadius: appRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.DARK_GREEN),
          borderRadius: appRadius,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        labelStyle: TextStyle(color: AppColors.MAIN_COLOR),
        border: OutlineInputBorder(borderRadius: appRadius),
      ),
      pickerDialogStyle: PickerDialogStyle(
        countryCodeStyle: TextStyle(
          color: AppColors.MAIN_COLOR,
        ),
        countryNameStyle: TextStyle(
          color: AppColors.MAIN_COLOR,
        ),
        searchFieldInputDecoration: InputDecoration(
          labelText: widget.searchLabelText,
          icon: Icon(Icons.search),
        ),
      ),
      invalidNumberMessage: widget.invalidNumberMessage,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onCountryChanged: widget.onCountryChanged,
      validator: widget.validator,
    );
  }
}
