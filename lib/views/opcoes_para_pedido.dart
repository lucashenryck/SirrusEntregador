import 'package:deliverymanager/api/sirrus_api.dart';
import 'package:deliverymanager/constantes/cores.dart';
import 'package:deliverymanager/controllers/atualizar_status_do_pedido_controller.dart';
import 'package:deliverymanager/entidades/pedido.dart';
import 'package:deliverymanager/helpers/localizacao.dart';
import 'package:deliverymanager/helpers/token.dart';
import 'package:deliverymanager/views/detalhes_do_pedido.dart';
import 'package:deliverymanager/views/listagem_de_pedidos.dart';
import 'package:deliverymanager/widgets/botao_do_pedido.dart';
import 'package:deliverymanager/widgets/modal_concluir_pedido.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OpcoesParaPedido extends StatefulWidget {
  final Pedido pedido;
  const OpcoesParaPedido({
    super.key,
    required this.pedido
  });

  @override
  State<OpcoesParaPedido> createState() => _OpcoesParaPedidoState();
}

class _OpcoesParaPedidoState extends State<OpcoesParaPedido> {
  String? opcaoSelecionada;
  final AtualizarStatusDoPedidoController atualizarStatusDoPedidoController = AtualizarStatusDoPedidoController(SirrusApi());

  void exibirOpcoes() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalConcluirPedido(
          onOpcaoSelecionada: (opcao) {
            setState(() {
              opcaoSelecionada = opcao;
            });
            atualizarStatusDoPedido();
          },
        );
      },
    );
  }

  void atualizarStatusDoPedido() async {
    if (opcaoSelecionada != null) {
      try {
        final token = await getToken();
        final response = await atualizarStatusDoPedidoController.atualizarStatusDoPedido(token, widget.pedido.id, opcaoSelecionada!);

        if (!mounted) return;

        if (response.success) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Pedido Nº ${widget.pedido.numero} concluído com sucesso!',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: corBotao,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ListagemDePedidos()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar status: $e')),
        );
      }
    }
  }

  void abrirGoogleMaps() async {
    try {
      Position posicao = await buscarLocalizacaoAtual();
      double origemLat = posicao.latitude;
      double origemLng = posicao.longitude;
      double destinoLat = widget.pedido.cliente.coordenadas.lat;
      double destinoLng = widget.pedido.cliente.coordenadas.lng;

      final Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/dir/?api=1'
        '&origin=$origemLat,$origemLng'
        '&destination=$destinoLat,$destinoLng'
        '&travelmode=motorcycle');

      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl);
      } else {
        throw 'Could not launch $googleMapsUrl';
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng position = LatLng(widget.pedido.cliente.coordenadas.lat, widget.pedido.cliente.coordenadas.lng);
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('cliente_marker'),
        position: position,
      ),
    };

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Pedido #${widget.pedido.numero}",
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(
                Icons.person_pin,
                color: corBotao,
                size: 40,
              ),
              title: Text(
                widget.pedido.cliente.nome,
                style: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ),
              subtitle: Text(
                widget.pedido.cliente.endereco,
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          SizedBox(
            width: 325,
            height: 200,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.pedido.cliente.coordenadas.lat, widget.pedido.cliente.coordenadas.lng),
                zoom: 18,
              ),
              markers: markers
            ),
          ),
          const SizedBox(height: 15),
          BotaoDoPedido(onTap: abrirGoogleMaps, text: 'ABRIR GPS'),
          BotaoDoPedido(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaDetalhesPedido(htmlDoPedido: widget.pedido.html),
                ),
              );
            }, 
            text: 'DETALHES DO PEDIDO'
          ),
          BotaoDoPedido(onTap: exibirOpcoes, text: 'CONCLUIR PEDIDO'),
        ],
      ),
    );
  }
}