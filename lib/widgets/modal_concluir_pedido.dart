import 'package:deliverymanager/constantes/cores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalConcluirPedido extends StatefulWidget {
  final Function(String) onOpcaoSelecionada;

  const ModalConcluirPedido({
    super.key,
    required this.onOpcaoSelecionada
  });

  @override
  State<ModalConcluirPedido> createState() => _ModalConcluirPedidoState();
}

class _ModalConcluirPedidoState extends State<ModalConcluirPedido> {
  late String opcaoSelecionada;

  @override
  void initState() {
    super.initState();
    opcaoSelecionada = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      content: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RadioListTile(
              title: Text(
                'ENTREGUE',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeColor: corBotao,
              value: 'ENTREGUE',
              groupValue: opcaoSelecionada,
              onChanged: (value) {
                setState(() {
                  opcaoSelecionada = value!;
                });
              },
            ),
            RadioListTile(
              title: Text(
                'ENDEREÇO NÃO LOCALIZADO',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeColor: corBotao,
              value: 'ENDERECO_NAO_LOCALIZADO',
              groupValue: opcaoSelecionada,
              onChanged: (value) {
                setState(() {
                  opcaoSelecionada = value!;
                });
              },
            ),
            RadioListTile(
              title: Text(
                'RECUSOU A RECEBER',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeColor: corBotao,
              value: 'RECUSOU_RECEBER',
              groupValue: opcaoSelecionada,
              onChanged: (value) {
                setState(() {
                  opcaoSelecionada = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onOpcaoSelecionada(opcaoSelecionada);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: corBotao,
                      ),
                      child: Text(
                        'CONFIRMAR',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        'FECHAR',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            
          ],
        ),
      ),
    );
  }
}
