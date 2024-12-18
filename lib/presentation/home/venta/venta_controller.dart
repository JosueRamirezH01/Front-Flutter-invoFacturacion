import 'package:flutter/material.dart';
class VentaController {

  late BuildContext context;
  late Function refresh;

  final ventas = [
    {
      'id': 'V001',
      'cliente': 'Juan Pérez',
      'total': 1500.00,
      'fecha': '2023-12-01',
      'doc': 'Factura',
      'usuario': 'Ana Gómez',
      'pagado': true,
    },
    {
      'id': 'V002',
      'cliente': 'María López',
      'total': 800.50,
      'fecha': '2023-12-02',
      'doc': 'Boleta',
      'usuario': 'Carlos Ruiz',
      'pagado': false,
    },
  ];

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
  }
}