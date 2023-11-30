import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  const TextWidget({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 20,
        color: color ?? Colors.blue[900]!,
        fontWeight: FontWeight.bold,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
