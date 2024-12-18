import 'package:flutter/material.dart';
import 'package:invefacturacion/presentation/components/textFormField.dart';

class CajaController {
  late BuildContext context;
  late Function refresh;
  final TextEditingController _montoController = TextEditingController();
  // Estado para determinar si la caja está activada
  bool cajaActivada = false;
  double montoInicial = 0.0;
  DateTime? fechaApertura; // Fecha y hora de apertura de caja
  double totalVentas = 0.0;
  double totalCobros = 0.0;

  final List<Map<String, dynamic>> ventas = [
    {'metodo': 'Efectivo', 'monto': 120.0},
    {'metodo': 'Yape', 'monto': 80.0},
    {'metodo': 'Plin', 'monto': 50.0},
  ];
  final List<Map<String, dynamic>> cobros = [
    {'metodo': 'Efectivo', 'monto': 200.0},
    {'metodo': 'Transferencia', 'monto': 150.0},
  ];
  final List<Map<String, dynamic>> historialMovimientos = [
    {
      'apertura': '01/12/2024 08:00:00',
      'cierre': '01/12/2024 18:00:00',
      'active': true
    },
    {
      'apertura': '02/12/2024 09:00:00',
      'cierre': '02/12/2024 17:00:00',
      'active': false
    },
    {
      'apertura': '03/12/2024 07:30:00',
      'cierre': '03/12/2024 16:30:00',
      'active': false
    },
    {
      'apertura': '04/12/2024 08:15:00',
      'cierre': '04/12/2024 18:30:00',
      'active': false
    },
    {
      'apertura': '05/12/2024 09:00:00',
      'cierre': '05/12/2024 17:30:00',
      'active': false
    },
    {
      'apertura': '06/12/2024 08:00:00',
      'cierre': '06/12/2024 19:00:00',
      'active': false
    },
    {
      'apertura': '07/12/2024 09:10:00',
      'cierre': '07/12/2024 17:50:00',
      'active': false
    },
    {
      'apertura': '08/12/2024 08:30:00',
      'cierre': '08/12/2024 18:00:00',
      'active': false
    },
    {
      'apertura': '09/12/2024 09:05:00',
      'cierre': '09/12/2024 18:10:00',
      'active': false
    },
    {
      'apertura': '10/12/2024 08:00:00',
      'cierre': '10/12/2024 17:45:00',
      'active': false
    },
  ];

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }

  double calcularTotal(List<Map<String, dynamic>> lista) {
    return lista.fold(0.0, (sum, item) => sum + (item['monto'] ?? 0.0));
  }

  double calcularTotalGeneral() {
    return calcularTotal(ventas) + calcularTotal(cobros);
  }

  Map<String, double> calcularTotalesPorMetodo() {
    Map<String, double> totales = {};

    // Sumar montos de ventas
    for (var venta in ventas) {
      totales[venta['metodo']] = (totales[venta['metodo']] ?? 0) + venta['monto'];
    }

    // Sumar montos de cobros
    for (var cobro in cobros) {
      totales[cobro['metodo']] = (totales[cobro['metodo']] ?? 0) + cobro['monto'];
    }

    return totales;
  }
  void activarCaja(double monto) {
    cajaActivada = true;
    montoInicial = monto;
    fechaApertura = DateTime.now(); // Registrar fecha y hora de apertura
    totalVentas = 0.0;
    totalCobros = 0.0;
    refresh();
  }

  void desactivarCaja() {
    cajaActivada = false;
    montoInicial = 0.0;
    refresh();
  }


  void abrirCajaDialogo() {
    _montoController.text = '0.0'; // Asignar valor inicial al controlador

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Abrir Caja'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ingrese el monto inicial para abrir la caja:'),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: _montoController,
                  labelText: 'Monto inicial',
                  height: 48,
                  filled: true,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final monto = double.tryParse(_montoController.text);
                if (monto != null && monto >= 0) {
                  activarCaja(monto);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ingrese un monto válido')),
                  );
                }
              },
              child: const Text('Abrir'),
            ),
          ],
        );
      },
    );
  }



}

