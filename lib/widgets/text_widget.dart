import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.textLabel,
  });

  final String textLabel;

  @override
  Widget build(BuildContext context) {
    return Text(
      textLabel,
      style: const TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
    );
  }
}
