import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  final TextEditingController controller;
  final IconData prefixIconData;
  final String hint;
  final bool isObsqure;
  final bool readOnly;
  final Function()? onTap;
  final String Function(String? v)? validate;
  const AuthInput(
      {super.key,
      this.validate,
      this.onTap,
      this.readOnly = false,
      required this.isObsqure,
      required this.controller,
      required this.prefixIconData,
      required this.hint});

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: TextFormField(
          readOnly: widget.readOnly,
          onTap: widget.onTap ?? () {},
          validator: widget.validate ??
              (String? v) {
                if (v!.isEmpty) {
                  return "This field is required.";
                }
              },
          obscureText: widget.isObsqure,
          style: const TextStyle(
            fontSize: 15.0,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: widget.hint,
            hintStyle: const TextStyle(
              fontSize: 15.0,
              // color: Colors.black,
            ),
            prefixIcon: Icon(
              widget.prefixIconData,
              // color: Colors.black,
            ),
          ),
          maxLines: 1,
          controller: widget.controller,
        ),
      ),
    );
  }
}
