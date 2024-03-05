import 'package:flutter/material.dart';

class Servico {
  final String titulo, descricao, loja;
  final List<String> imagens;
  final List<Color> cores;
  final double avaliacao;
  final bool favorito, popular;

  Servico({
    required this.imagens,
    required this.cores,
    this.avaliacao = 0.0,
    this.favorito = false,
    this.popular = false,
    required this.titulo,
    required this.descricao,
    required this.loja,
  });
}

List<Servico> cardServicos = [
  Servico(
    imagens: ["assets/exemplo.png"],
    cores: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    titulo: "Corte",
    loja: "Barbearia Progresso",
    descricao: "Cortes diversificados",
    avaliacao: 4.8,
    favorito: true,
    popular: true,
  ),
];
