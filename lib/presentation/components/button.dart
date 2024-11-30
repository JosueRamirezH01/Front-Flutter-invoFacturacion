import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color? textColor;
  final double borderRadius;
  final IconData? icon;
  final double? width;
  final double height;
  final double elevation;
  final bool? isEnabled;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor,
    this.borderRadius = 8.0,
    this.icon,
    this.width,
    this.height = 50.0,
    this.elevation = 2.0,
    this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Se asigna un valor predeterminado de true a isEnabled si es null
    final bool buttonEnabled = isEnabled ?? true;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: buttonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(0.3);
              }
              return null;
            },
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor ?? Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
