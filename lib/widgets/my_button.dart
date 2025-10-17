import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final bool hasShadow;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
    this.hasShadow = true,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  final bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 56,
        decoration: BoxDecoration(
          color: _isPressed
              ? widget.backgroundColor.withOpacity(0.5)
              : widget.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: widget.hasShadow && !_isPressed
              ? [
                  BoxShadow(
                    color: widget.backgroundColor.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
