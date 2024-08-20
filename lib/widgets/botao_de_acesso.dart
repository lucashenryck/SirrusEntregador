import 'package:deliverymanager/constantes/cores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoDeAcesso extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool estaAutenticando;

  const BotaoDeAcesso({
    super.key,
    required this.onTap,
    required this.text,
    this.estaAutenticando = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: estaAutenticando ? null : onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(corBotao),
        padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 15, horizontal: 50)),
      ),
      child: SizedBox(
        width: 125,
        height: 30,
        child: Center(
          child: estaAutenticando 
              ? const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                ) 
              : Text(
                  text,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
