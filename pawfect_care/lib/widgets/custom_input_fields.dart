import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function()? onSuffixTap;
  final TextEditingController? controller;

  const CustomInputField({
    Key? key,
    required this.hint,
    required this.icon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onSuffixTap,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: inputGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon != null
            ? GestureDetector(onTap: onSuffixTap, child: suffixIcon)
            : null,
      ),
    );
  }
}
