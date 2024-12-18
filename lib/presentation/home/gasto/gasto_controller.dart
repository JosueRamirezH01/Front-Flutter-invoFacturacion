
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:invefacturacion/presentation/components/button.dart';
import 'package:invefacturacion/presentation/components/textFormField.dart';

import '../../../data/model/compra.dart';
import '../../../data/model/gasto.dart';

class GastosController {

  late BuildContext context;
  late Function refresh;
  DateTime? _startDate;
  DateTime? _endDate;
  final _formKeyGasto = GlobalKey<FormState>();
  String? tipoPago = 'Efectivo';
  String? comprobante;
  DateTime selectedDate = DateTime.now();
  List<Gastos> listGastos = [
    Gastos(
      descripcion: "Compra de suministros de oficina",
      cuenta: "Oficina",
      monto: 150.75,
      fecha: DateTime(2024, 1, 15),
      usuario: "usuario1",
    ),
    Gastos(
      descripcion: "Pago de servicio de internet",
      cuenta: "Servicios",
      monto: 50.00,
      fecha: DateTime(2024, 1, 20),
      usuario: "usuario2",
    ),
    Gastos(
      descripcion: "Compra de materiales de limpieza",
      cuenta: "Limpieza",
      monto: 75.90,
      fecha: DateTime(2024, 2, 1),
      usuario: "usuario3",
    ),
    Gastos(
      descripcion: "Compra de mobiliario de oficina",
      cuenta: "Oficina",
      monto: 500.00,
      fecha: DateTime(2024, 2, 10),
      usuario: "usuario4",
    ),
    Gastos(
      descripcion: "Renovación de suscripción al software",
      cuenta: "Tecnología",
      monto: 300.00,
      fecha: DateTime(2024, 3, 5),
      usuario: "usuario1",
    ),
    Gastos(
      descripcion: "Compra de equipo de computación",
      cuenta: "Tecnología",
      monto: 1200.50,
      fecha: DateTime(2024, 3, 15),
      usuario: "usuario5",
    ),
    Gastos(
      descripcion: "Pago de servicio de electricidad",
      cuenta: "Servicios",
      monto: 200.00,
      fecha: DateTime(2024, 4, 10),
      usuario: "usuario2",
    ),
    Gastos(
      descripcion: "Compra de insumos de cafetería",
      cuenta: "Cafetería",
      monto: 100.00,
      fecha: DateTime(2024, 4, 20),
      usuario: "usuario6",
    ),
    Gastos(
      descripcion: "Mantenimiento de equipos",
      cuenta: "Mantenimiento",
      monto: 400.00,
      fecha: DateTime(2024, 5, 5),
      usuario: "usuario7",
    ),
    Gastos(
      descripcion: "Compra de papelería",
      cuenta: "Oficina",
      monto: 50.30,
      fecha: DateTime(2024, 5, 15),
      usuario: "usuario1",
    ),
  ];
  final TextEditingController searchController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController montoController = TextEditingController();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController empresaController = TextEditingController();
  final TextEditingController compranteController = TextEditingController();
  final TextEditingController dniController = TextEditingController();

  final _controller = ValueNotifier<bool>(false);
  bool initial = false;
  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
  }
  void filterByDateRange(DateTime? startDate, DateTime? endDate) {
    _startDate = startDate;
    _endDate = endDate;
    refresh(); // Refresca la interfaz después de aplicar el filtro.
  }

  List<Gastos> get filteredGasto {
    return listGastos.where((item) {
      final searchMatches = item.descripcion.toString().contains(searchController.text.toLowerCase());
      final dateMatches = _isWithinDateRange(item.fecha!);  // Aquí se utiliza el método _isWithinDateRange
      return searchMatches && dateMatches;
    }).toList();
  }

  bool _isWithinDateRange(DateTime fecha) {
    if (_startDate != null && fecha.isBefore(_startDate!)) {
      return false;
    }
    if (_endDate != null && fecha.isAfter(_endDate!)) {
      return false;
    }
    return true;
  }

  void addGasto(BuildContext context, bool edit) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (BuildContext context) {

    return GestureDetector(
         onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.82,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
             ),
            child: SingleChildScrollView(
               child: Form(
                key: _formKeyGasto,
                child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                              edit ? 'Editar Compra' : 'Agregar Nueva Compra',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: AdvancedSwitch(
                                  width: 48,
                                  height: 24,
                                  inactiveColor: Colors.red,
                                  initialValue: initial,
                                  onChanged: (value) {
                                    setModalState(() {
                                      initial = value; // Actualiza el valor de `initial` basado en el switch
                                    });
                                  },
                                ),
                              ),
                              const Spacer(),
                 Align(
                   alignment: Alignment.bottomRight,
                   child: AnimatedDefaultTextStyle(
                     duration: const Duration(milliseconds: 300),
                     style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.bold,
                       color: initial ? Colors.green : Colors.red,
                     ),
                     child: Text(initial ? 'Con comprobante' : 'Sin comprobante'),
                   ),
                 ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          CustomTextFormField(controller: descripcionController, labelText: 'Descripcion',height: 49, filled: true,fillColor: Colors.white,),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                          value: tipoPago,
                          decoration: InputDecoration(
                              labelText: 'Método de Pago',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              fillColor: Colors.white,
                              filled: true
                          ),
                          items: <String>['Efectivo', 'BCP', 'Tarjeta de Crédito', 'Yape', 'Plin']
                              .map((String method) {
                            return DropdownMenuItem<String>(
                              value: method,
                              child: Text(method),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setModalState(() {
                                tipoPago = newValue;
                              });
                            }

                          },
                        ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () async {
                                    final DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate, // Fecha inicial
                                      firstDate: DateTime(2000), // Fecha mínima
                                      lastDate: DateTime.now(), // Fecha máxima: hoy
                                    );
                                    if (pickedDate != null && pickedDate != selectedDate) {
                                      setModalState(() {
                                        selectedDate = pickedDate;
                                      });
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                        labelText: 'Fecha',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                        filled: true,
                                        fillColor: Colors.white
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(flex: 1,child: CustomTextFormField(controller: montoController, labelText: 'Monto',height: 49,filled: true,fillColor: Colors.white,keyboardType: TextInputType.number,))

                            ],
                          ),
                          const SizedBox(height: 16),
                          if(initial)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Comprobante',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              CustomTextFormField(controller: rucController, labelText: 'RUC', filled: true, fillColor: Colors.white, height: 49, keyboardType: TextInputType.number),
                              const SizedBox(height: 10),
                              CustomTextFormField(controller: empresaController, labelText: 'Nombre empresa', filled: true, fillColor: Colors.white, height: 49,keyboardType: TextInputType.number),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: comprobante,
                                decoration: InputDecoration(
                                  labelText: 'Comprobante',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                items: <String>['Boleta', 'Factura']
                                    .map((String method) => DropdownMenuItem<String>(
                                  value: method,
                                  child: Text(method),
                                ))
                                    .toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setModalState(() {
                                      comprobante = newValue;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(controller: dniController, labelText: 'N° Documento', filled: true, fillColor: Colors.white, height: 49,keyboardType: TextInputType.number),

                            ],
                          ),
                          const SizedBox(height: 16),
                          CustomButton(text: 'Guardar', onPressed:
                          (){})

                      ]
                      )
                  )
                )
              );
            }
          )
        )
      );
    }
    );
  }
}