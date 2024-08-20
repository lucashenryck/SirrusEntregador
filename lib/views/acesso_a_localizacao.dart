import 'package:deliverymanager/constantes/cores.dart';
import 'package:deliverymanager/helpers/localizacao.dart';
import 'package:deliverymanager/views/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcessoDeLocalizacao extends StatefulWidget {
  const AcessoDeLocalizacao({super.key});

  @override
  State<AcessoDeLocalizacao> createState() => _AcessoDeLocalizacaoState();
}

class _AcessoDeLocalizacaoState extends State<AcessoDeLocalizacao> {
  String mensagem = '';
  bool showIcon = false;

  @override
  void initState() {
    super.initState();
  }

  void permitirAcesso() async {
    setState(() {
      mensagem = 'Obtendo localização...';
    });

    try {
      await buscarLocalizacaoAtual();
      if (!mounted) return;

      setState(() {
        mensagem = '';
        showIcon = true;
      });

      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Login(),
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
    } catch (e) {
      if (!mounted) return;
      setState(() {
        mensagem = e.toString();
      });
    }
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
                // Logo Sirrus Delivery
                Image.asset(
                  'images/logo-sirrus-delivery.png',
                  width: 350,
                ),

                const SizedBox(height: 15),

                const Icon(
                  Icons.location_on,
                  size: 60,
                  color: Colors.white,
                ),

                const SizedBox(height: 15),

                Text(
                  "Para o uso do aplicativo, é necessário que você permita o acesso à localização do seu dispositivo!",
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                    letterSpacing: -0.5
                  ),
                  textAlign: TextAlign.justify,
                ),

                const SizedBox(height: 25),

                // Botão de permitir acesso à localização
                ElevatedButton(
                  onPressed: permitirAcesso,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(corBotao),
                    padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 15, horizontal: 50)),
                  ),
                  child: Text(
                    'Permitir',
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 50, // Adjust height as needed
                  child: Center(
                    child: Text(
                      mensagem,
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                Visibility(
                  visible: showIcon,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: const Icon(
                    Icons.check_circle,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
