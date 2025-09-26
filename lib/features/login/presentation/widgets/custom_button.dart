import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final TextStyle textStyle;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.blue,
    this.borderRadius = 8.0,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(label, style: textStyle),
    );
  }
}
