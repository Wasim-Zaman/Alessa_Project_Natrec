import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? height;
  final String? hintText;
  final String? labelText;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final Color? color;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final bool? autofocus;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;

  const TextFormFieldWidget({
    super.key,
    this.width,
    this.height,
    this.hintText,
    this.labelText,
    required this.controller,
    this.readOnly,
    this.validator,
    this.color,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.autofocus,
    this.focusNode,
    this.suffixIcon,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? Colors.white,
      ),
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: height ?? 50,
      child: TextFormField(
        maxLength: null,
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        readOnly: readOnly ?? false,
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: const EdgeInsets.only(
            top: 15,
            left: 10,
          ),
          hintText: hintText ?? "",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        textInputAction: textInputAction,
        enableSuggestions: true,
        validator: validator,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
