import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaDetalhesPedido extends StatelessWidget {
  final String htmlDoPedido;
  const TelaDetalhesPedido({
    super.key, 
    required this.htmlDoPedido
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Detalhes",
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: HtmlWidget(
            htmlDoPedido,
          ),
        )
      ),
    );
  }
}
