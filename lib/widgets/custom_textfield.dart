import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool isObsecure;
  final String hintText;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function onChanged;
  final Function onSubmitted;

  CustomTextField(
      {this.isObsecure, this.hintText, this.focusNode, this.textInputAction, this.onChanged, this.onSubmitted,});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      obscureText: isObsecure,
      obscuringCharacter: "֍",
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(fontSize: 24, color: Colors.grey.shade400),
      ),
      style: TextStyle(
          fontSize: 20,
          color: Colors.grey.shade700,
          decoration: TextDecoration.none),
      textInputAction: textInputAction,
      focusNode: focusNode ?? FocusNode(),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
