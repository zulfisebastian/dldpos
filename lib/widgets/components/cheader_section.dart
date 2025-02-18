import 'package:flutter/material.dart';

class CHeaderSection extends StatelessWidget {
  final Widget title;
  final Widget action;

  const CHeaderSection({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title,
        action,
      ],
    );
  }
}
