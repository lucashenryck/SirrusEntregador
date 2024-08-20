import 'package:deliverymanager/api/sirrus_api.dart';
import 'package:deliverymanager/controllers/login_controller.dart';
import 'package:deliverymanager/views/autenticar_login.dart';
import 'package:deliverymanager/widgets/botao_de_acesso.dart';
import 'package:deliverymanager/widgets/campo_de_texto.dart';
import 'package:flutter/material.dart';
import 'package:deliverymanager/constantes/cores.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  late final LoginController loginController;
  bool estaAutenticando = false;

  @override
  void initState() {
    super.initState();
    loginController = LoginController(SirrusApi());
  }

  Future<void> autenticar() async {

    if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Por favor, digite seu e-mail!',
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

    final response = await loginController.logar(email.text);

    if (!mounted) return;

    if (response.success) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => AutenticarLogin(email: email.text),
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
            response.message,
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
            response.message,
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

                //Label do input de e-mail
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Digite seu e-mail",
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //Input de e-mail
                CampoDeTexto(controller: email,tipo: CampoDeTextoType.text),

                const SizedBox(height: 25),
                
                //Botão de autenticação
                BotaoDeAcesso(
                  onTap: autenticar, 
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