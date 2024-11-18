import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:flutter/material.dart';

const paises = const [
  Pais(
    id: 'Estados Unidos',
    titulo: 'Estados Unidos',
    cor: Colors.purple,
  ),
  Pais(
    id: 'Canada',
    titulo: 'Canada',
    cor: Colors.red,
  ),
  Pais(
    id: 'Suiça',
    titulo: 'Suiça',
    cor: Colors.orange,
  ),
  Pais(
    id: 'Chile',
    titulo: 'Chile',
    cor: Colors.amber,
  ),
  Pais(
    id: 'Espanha',
    titulo: 'Espanha',
    cor: Colors.amber,
  ),
  Pais(
    id: 'Peru',
    titulo: 'Peru',
    cor: Colors.lightBlue,
  ),
  Pais(
    id: 'Brasil',
    titulo: 'Brasil',
    cor: Colors.lightGreen,
  ),
  Pais(
    id: 'Egito',
    titulo: 'Egito',
    cor: Colors.teal,
  ),
];

var lugares = [
  Lugar(
    id: 'p1',
    titulo: 'Praia',
    paises: ['Egito', 'Espanha', 'c9', 'Brasil'],
    avaliacao: 4.8,
    custoMedio: 20,
    recomendacoes: [
      '1. Leve protetor solar',
      '2. Se hidrate',
      '3. Não jogue lixo na praia',
      '4. Tome água de coco'
    ],
    imagemUrl:
        'https://s2.glbimg.com/Qgl26Ze8x7iJ1HoFwwRkwfjgGrM=/smart/e.glbimg.com/og/ed/f/original/2020/11/05/brasil-tem-duas-praias-entre-as-cinco-melhores-do-mundo.jpg',
  ),
  Lugar(
    id: 'p2',
    titulo: 'Montanha',
    paises: ['Estados Unidos', 'Canada', 'Chile', 'Suiça'],
    avaliacao: 4.2,
    custoMedio: 50,
    recomendacoes: [
      '1. Leve tenis para hiking',
      '2. Levar kit de primeiros socorros',
      '3. Roupa para frio'
    ],
    imagemUrl:
        'https://images.memphistours.com/large/60e4be05c4ef4373c71802b0dd3f9e62.jpg',
  ),
  Lugar(
    id: 'p3',
    titulo: 'Deserto',
    paises: ['c10', 'Chile'],
    avaliacao: 4.1,
    custoMedio: 20,
    recomendacoes: [
      '1. Leve protetor solar',
      '2. Leva uma reserva de água',
      '3. roupas de lã'
    ],
    imagemUrl:
        'https://s4.static.brasilescola.uol.com.br/be/2021/11/deserto.jpg',
  ),
  Lugar(
    id: 'p4',
    titulo: 'Monumentos Antigos',
    paises: ['c10', 'Espanha', 'Peru'],
    avaliacao: 4.7,
    custoMedio: 45,
    recomendacoes: [
      '1. Tenis leve para caminhada',
      '2. Procure um guia',
      '3. Contribua para preservação'
    ],
    imagemUrl:
        'https://img.freepik.com/fotos-gratis/tiro-de-angulo-baixo-dos-antigos-pilares-de-pedra-grega-com-um-ceu-azul-claro_181624-2890.jpg',
  ),
  Lugar(
    id: 'p5',
    titulo: 'Monumentos Modernos',
    paises: ['Estados Unidos'],
    avaliacao: 4.2,
    custoMedio: 30,
    recomendacoes: [
      '1. Tenis leve para caminhada',
      '2. Passeios em grupo',
    ],
    imagemUrl:
        'https://www.infoescola.com/wp-content/uploads/2009/03/estatua-da-liberdade.jpg',
  ),
  Lugar(
    id: 'p6',
    titulo: 'Maravilhas da Natureza',
    paises: ['Canada', 'Egito', 'Brasil'],
    avaliacao: 4.4,
    custoMedio: 40,
    recomendacoes: [
      '1. Tenis leve para caminhada',
      '2. Passeios em grupo e com guia',
      '3. Contribua para preservação'
    ],
    imagemUrl:
        'https://img.freepik.com/fotos-gratis/cachoeira-do-parque-nacional-do-iguacu-cercada-por-florestas-cobertas-pela-nevoa-sob-um-ceu-nublado_181624-14415.jpg',
  ),
];
