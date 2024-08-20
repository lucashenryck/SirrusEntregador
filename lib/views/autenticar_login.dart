import 'package:deliverymanager/api/sirrus_api.dart';
import 'package:deliverymanager/controllers/autenticar_login.dart';
import 'package:deliverymanager/views/listagem_de_pedidos.dart';
import 'package:deliverymanager/widgets/botao_de_acesso.dart';
import 'package:deliverymanager/widgets/campo_de_texto.dart';
import 'package:flutter/material.dart';
import 'package:deliverymanager/constantes/cores.dart';
import 'package:google_fonts/google_fonts.dart';

class AutenticarLogin extends StatefulWidget {
  final String email;
  const AutenticarLogin({
    super.key,
    required this.email
  });

  @override
  State<AutenticarLogin> createState() => _AutenticarLoginState();
}

class _AutenticarLoginState extends State<AutenticarLogin> {
  final codigo = TextEditingController();
  late final AutenticarLoginController autenticarLoginController;
  bool estaAutenticando = false;

  @override
  void initState() {
    super.initState();
    autenticarLoginController = AutenticarLoginController(SirrusApi());
  }

  Future<void> validar() async {

    if (codigo.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Por favor, digite o código!',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: corBotao,
        ),
      );
      return;
    }

    setState(() {
      estaAutenticando = true;
    });
    final response = await autenticarLoginController.autenticarLogin(widget.email, codigo.text);

    if (!mounted) return;

    if (response.success) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ListagemDePedidos(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Olá novamente, ${response.entregador!.nome}!',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: corBotao,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.message!,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: corBotao,
        ),
      );
    }

    setState(() {
      estaAutenticando = false; // Reativa o botão
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSirrusLogo,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo Sirrus Delivery
                Image.asset(
                  'images/logo-sirrus-delivery.png',
                  width: 350,
                ),
                
                //Título
                Text(
                  "Sirrus Entregador",
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                const SizedBox(height: 60),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Digite o código",
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //Input de e-mail
                CampoDeTexto(controller: codigo, tipo: CampoDeTextoType.numeric),

                const SizedBox(height: 15),
                
                //Botão de autenticação
                BotaoDeAcesso(
                  onTap: validar, 
                  text: 'Continuar', 
                  estaAutenticando: estaAutenticando,
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}