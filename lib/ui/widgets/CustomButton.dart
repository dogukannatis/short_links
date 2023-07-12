import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final Color? splashColor;
  final Color? textColor;
  final Function()? onPressed;
  final Widget child;
  final bool secondary;
  final double? height;
  final double? width;
  final ShapeBorder? shape;

  const CustomButton({Key? key,
    this.color,
    this.textColor = Colors.white,
    this.splashColor,
    this.onPressed,
    required this.child,
    this.secondary = false,
    this.height,
    this.width,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      minWidth: width ?? MediaQuery.of(context).size.width-50,
      height: height ?? 50,
      color: secondary ? Theme.of(context).colorScheme.secondary : color ?? Theme.of(context).primaryColor,
      splashColor: secondary ? Theme.of(context).colorScheme.secondary.withOpacity(0.7) : splashColor ?? Theme.of(context).primaryColor.withOpacity(0.7),
      elevation: 0,
      highlightElevation: 3,
      disabledColor: Colors.grey,
      textColor: textColor,
      shape: shape ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // <-- Radius
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
