import 'package:flutter/material.dart';

enum CampoDeTextoType {
  numeric,
  text,
}

class CampoDeTexto extends StatelessWidget {
  final TextEditingController controller;
  final CampoDeTextoType tipo;

  const CampoDeTexto({
    super.key,
    required this.controller,
    required this.tipo
  });

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType;
    switch (tipo) {
      case CampoDeTextoType.numeric:
        keyboardType = TextInputType.number;
        break;
      case CampoDeTextoType.text:
        keyboardType = TextInputType.text;
        break;
    }
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.white,
        filled: true
      ),
    );
  }
}