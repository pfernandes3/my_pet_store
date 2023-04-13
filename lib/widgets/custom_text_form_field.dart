import 'package:flutter/material.dart';

class Custom_Form_Field extends StatelessWidget {
  const Custom_Form_Field(
      {super.key, this.label, this.icon, });
  
  final label;
  final icon;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(label: label, prefixIcon: icon),
    
    );
  }
}
