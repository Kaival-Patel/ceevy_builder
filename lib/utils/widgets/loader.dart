import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  double size;
  Color? color;
  Loader({required this.size, this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CupertinoActivityIndicator(
        color: color,
      ),
    );
  }
}
