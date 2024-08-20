import 'package:deliverymanager/constantes/cores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoDoPedido extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const BotaoDoPedido({
    super.key,
    required this.onTap,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: corBotao,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}