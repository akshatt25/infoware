import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infoware/constants/global_variables.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;

  final String hintText;
  final int maxLines;
  final bool hidden;

  const CustomTextField(
      {required this.controller,
      super.key,
      required this.hintText,
      this.hidden = false,
      this.maxLines = 1});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: TextFormField(
        keyboardType: widget.hintText == 'Phone'
            ? TextInputType.number
            : TextInputType.text,
        controller: widget.controller,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.inter(
            textStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(width: 1.5, color: GlobalVariables.voilet),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.black26),
          ),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter you ${widget.hintText}';
          }
          if (widget.hintText == 'Phone' && val.length < 10) {
            return 'Enter a 10 digit phone number';
          }
          if (widget.hintText == 'Email' && isEmailValid(val) == false) {
            return 'Enter a valid Email';
          }

          return null;
        },
      ),
    );
  }

  bool isEmailValid(String email) {
    String emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$'; // Regular expression for email validation
    RegExp regExp = RegExp(emailRegex);

    return regExp.hasMatch(email);
  }
}
