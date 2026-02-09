import 'package:flutter/material.dart';
import 'package:core/core.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double radius;
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight;
  final bool asyncCall;
  final Color background;
  final IconData icon;
  final Color iconColor;

  const CustomButtonWithIcon({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
    this.radius = 8.0,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.asyncCall = false,
    this.textSize = 16.0,
    this.background = colorPrimary,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: asyncCall ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      child:
          asyncCall
              ? Center(child: CircularProgressIndicator(color: textColor))
              : Row(
                children: [
                  Icon(icon, color: iconColor),
                  SizedBox(width: 4.0,),
                  Text(text, style: TextStyle(color: textColor, fontWeight: fontWeight, fontSize: textSize)),
                  SizedBox(width: 4.0,),
                ],
              ),
    );
  }
}
