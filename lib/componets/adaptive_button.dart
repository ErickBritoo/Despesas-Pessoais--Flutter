import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  // ignore: prefer_const_constructors_in_immutables
  AdaptiveButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? CupertinoButton(
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(label),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              textStyle: TextStyle(
                color: Theme.of(context).textTheme.labelLarge!.color,
                fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
              ),
            ),
            onPressed: onPressed,
            child: Text(label),
          );
  }
}
