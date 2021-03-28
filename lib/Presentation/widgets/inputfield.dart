import "package:flutter/material.dart";

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isObscure;
  final String errorText;
  final Function onChange;
  final TextEditingController controller;
  InputField({
    @required this.label,
    @required this.hint,
    @required this.onChange,
    @required this.controller,
    this.isObscure,
    this.errorText,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChange,
        textDirection: TextDirection.rtl,
        obscureText: isObscure ?? false,
        decoration: new InputDecoration(
          errorText: errorText != "" ? errorText : null,
          labelText: label,
          hintStyle: new TextStyle(color: Colors.grey[800]),
          hintText: hint,
        ),
      ),
    );
  }
}
