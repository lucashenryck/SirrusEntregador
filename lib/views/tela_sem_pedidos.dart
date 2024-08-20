import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaSemPedidos extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const TelaSemPedidos({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/deliveryman.png',
                  width: 500,
                ),
                Text(
                  "Entregas finalizadas.",
                  style: GoogleFonts.dmSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Bom trabalho!",
                  style: GoogleFonts.dmSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
