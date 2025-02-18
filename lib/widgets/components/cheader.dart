import 'package:flutter/material.dart';
import 'package:dld/widgets/components/text/ctext.dart';

class CHeader extends StatelessWidget {
  final String title;

  const CHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CText(
      title,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }
}
