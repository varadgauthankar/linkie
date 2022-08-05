import 'package:flutter/material.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  final bool darkColor;
  final double? height;
  final double? width;
  const MyCircularProgressIndicator(
      {Key? key, this.darkColor = false, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 14,
      width: width ?? 14,
      child: CircularProgressIndicator(
        color: darkColor
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
