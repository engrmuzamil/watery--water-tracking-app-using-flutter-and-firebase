import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormField extends StatelessWidget {
  final Widget child;
  CustomFormField({this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 60,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.only(top: 6),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.centerLeft,
              child: child),
        ),
      ),
    );
  }
}
