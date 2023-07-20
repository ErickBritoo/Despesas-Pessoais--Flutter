import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdadptiveTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  TextInputType? keyboardType = TextInputType.text;
  final Function() onSubmited;

  AdadptiveTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.onSubmited,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              controller: controller,
              onSubmitted: (_) => onSubmited(),
              placeholder: label,
              keyboardType: keyboardType,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: (_) => onSubmited,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
