import 'package:deliverymanager/api/sirrus_api.dart';
import 'package:deliverymanager/constantes/cores.dart';
import 'package:deliverymanager/controllers/listagem_de_pedidos_controller.dart';
import 'package:deliverymanager/entidades/pedido.dart';
import 'package:deliverymanager/helpers/token.dart';
import 'package:deliverymanager/views/acesso_a_localizacao.dart';
import 'package:deliverymanager/views/opcoes_para_pedido.dart';
import 'package:deliverymanager/views/tela_sem_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:deliverymanager/views/erro.dart';

class ListagemDePedidos extends StatefulWidget {
  const ListagemDePedidos({super.key});

  @override
  State<ListagemDePedidos> createState() => _ListagemDePedidosState();
}

class _ListagemDePedidosState extends State<ListagemDePedidos> {
  late final ListagemDePedidosController listagemDePedidosController;

  @override
  void initState() {
    super.initState();
    listagemDePedidosController = ListagemDePedidosController(SirrusApi());
    listagemDePedidosController.carregarPedidos();
  }

  @override
  void dispose() {
    listagemDePedidosController.dispose();
    super.dispose();
  }

  Future<void> logout() async {
    await removeToken();
    if(!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AcessoDeLocalizacao()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        shadowColor: Colors.black,
        centerTitle: true,
        title: ValueListenableBuilder<int>(
          valueListenable: listagemDePedidosController.quantidadeDePedidos,
          builder: (context, quantidade, child) {
            return Text(
              "Minhas entregas ($quantidade)",
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: logout, 
            icon: const Icon(
              Icons.logout,
              size: 25,
              color: Colors.red,
            )
          ),
        ],
      ),
      body: StreamBuilder<List<Pedido>?>(
        stream: listagemDePedidosController.pedidosStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Erro(onRefresh: listagemDePedidosController.carregarPedidos);
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return TelaSemPedidos(onRefresh: listagemDePedidosController.carregarPedidos);
          } else if(snapshot.data == null){
            return ValueListenableBuilder<String?>(
              valueListenable: listagemDePedidosController.messagemDeErro,
              builder: (context, mensagemDeErro, child) {
                return Center(child: Text(mensagemDeErro ?? 'Erro desconhecido'));
              },
            );
          }
           else {
            return RefreshIndicator(
              onRefresh: () async => await listagemDePedidosController.carregarPedidos(),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final pedido = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OpcoesParaPedido(pedido: pedido),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Iconsax.shopping_bag5,
                          size: 30,
                          color: corBotao,
                        ),
                        title: Text(
                          'Pedido #${pedido.numero}',
                          style: GoogleFonts.dmSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          pedido.cliente.endereco,
                          style: GoogleFonts.dmSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}