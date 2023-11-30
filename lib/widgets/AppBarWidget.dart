import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatefulWidget {
  VoidCallback? onPressed;
  final String title;
  final bool? autoImplyLeading;
  List<Widget>? actions;
  AppBarWidget({
    super.key,
    this.onPressed,
    required this.title,
    this.actions = const [],
    this.autoImplyLeading,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      automaticallyImplyLeading: widget.autoImplyLeading ?? true,

      // change the back button color

      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.orange,
        statusBarIconBrightness: Brightness.light,
      ),
      leading: GestureDetector(
        onTap: widget.onPressed,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      actions: widget.actions,
    );
  }
}
