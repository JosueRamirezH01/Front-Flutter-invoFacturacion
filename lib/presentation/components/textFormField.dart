import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final double? width;
  final double? height;
  final bool? filled; // Nuevo parámetro
  final Color? fillColor;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onToggleVisibility,
    this.validator,
    this.fillColor,
    this.filled,
    this.keyboardType = TextInputType.text,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.blueGrey[600])
              : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(
              obscureText ? suffixIcon : suffixIcon,
              color: Colors.blueGrey[600],
            ),
            onPressed: onToggleVisibility,
          )
              : null,
          filled: filled,
          fillColor: fillColor,
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
        validator: validator,
      ),
    );
  }
}
