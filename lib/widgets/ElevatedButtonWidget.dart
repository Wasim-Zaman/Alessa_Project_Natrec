import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElevatedButtonWidget extends StatefulWidget {
  String title;
  double? width;
  double? height;
  Function onPressed;
  double? fontSize;
  Color? color;
  Color? textColor;

  ElevatedButtonWidget({
    super.key,
    required this.title,
    this.width,
    this.height,
    required this.onPressed,
    this.fontSize,
    this.color,
    this.textColor,
  });

  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width * 0.9,
      height: widget.height ?? MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.color ?? Colors.deepPurple,
        ),
        borderRadius: BorderRadius.circular(10.0),
        color: widget.color ?? Colors.white,
      ),
      child: InkWell(
        onTap: () => widget.onPressed(),
        child: Center(
          child: FittedBox(
            child: Text(
              widget.title,
              style: TextStyle(
                color: widget.textColor ?? Colors.blue[900],
                fontSize: widget.fontSize ?? 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
