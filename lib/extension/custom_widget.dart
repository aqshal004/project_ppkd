import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key, this.isPassword = false, this.controller, this.validator, required this.hintText});

  final String hintText;
  final bool isPassword;
  // final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? _obscurePassword : false,
      decoration: InputDecoration(
        // fillColor: Colors.red,
        // filled: true,
        // labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade300),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
      ),
      style: TextStyle(fontSize: 16),
    );
  }
}