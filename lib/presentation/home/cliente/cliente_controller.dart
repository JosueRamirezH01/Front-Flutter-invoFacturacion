
import 'package:flutter/material.dart';
import 'package:invefacturacion/presentation/components/button.dart';
import 'package:invefacturacion/presentation/components/textFormField.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../data/model/cliente.dart';

class ClienteController {
  late BuildContext context;
  late Function refresh;
  final _formKey = GlobalKey<FormState>();
  String _tipoDocumento = 'DNI';
  String _tipoCliente = 'Cliente';
  bool mostrarConfigAvanzadas = false;
  String? _genero;

  final nombreController = TextEditingController();
  final documentoController = TextEditingController();
  final direccionController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }
  final List<Cliente> data = [
    Cliente(
      nombreRazonSocial: "Empresa A S.A.",
      documento: "20123456789",
      tipoCliente: "Jurídico",
      direccion: "Av. Principal 123",
      telefono: "01-1234567",
    ),
    Cliente(
      nombreRazonSocial: "Distribuidora B S.A.C.",
      documento: "20187654321",
      tipoCliente: "Jurídico",
      direccion: "Jr. Comercio 456",
      telefono: "01-8765432",
    ),
    Cliente(
      nombreRazonSocial: "Servicios Integrales C",
      documento: "20345678912",
      tipoCliente: "Jurídico",
      direccion: "Av. Industrial 789",
      telefono: "01-2345678",
    ),
    Cliente(
      nombreRazonSocial: "Consultora D S.R.L.",
      documento: "20456789023",
      tipoCliente: "Jurídico",
      direccion: "Jr. Las Rosas 101",
      telefono: "01-9876543",
    ),
    Cliente(
      nombreRazonSocial: "Transporte E S.A.",
      documento: "20567890134",
      tipoCliente: "Jurídico",
      direccion: "Av. Panamericana 202",
      telefono: "01-5678901",
    ),
    Cliente(
      nombreRazonSocial: "Comercializadora F",
      documento: "20678901245",
      tipoCliente: "Jurídico",
      direccion: "Calle Central 303",
      telefono: "01-6789012",
    ),
    Cliente(
      nombreRazonSocial: "Constructora G S.A.C.",
      documento: "20789012356",
      tipoCliente: "Jurídico",
      direccion: "Av. Obra 404",
      telefono: "01-7890123",
    ),
    Cliente(
      nombreRazonSocial: "Industria H S.A.",
      documento: "20890123467",
      tipoCliente: "Jurídico",
      direccion: "Calle Industria 505",
      telefono: "01-8901234",
    ),
    Cliente(
      nombreRazonSocial: "Tecnología I S.A.",
      documento: "20901234578",
      tipoCliente: "Jurídico",
      direccion: "Jr. Desarrollo 606",
      telefono: "01-9012345",
    ),
    Cliente(
      nombreRazonSocial: "Agropecuaria J S.A.C.",
      documento: "21012345689",
      tipoCliente: "Jurídico",
      direccion: "Av. Campo 707",
      telefono: "01-0123456",
    ),
    Cliente(
      nombreRazonSocial: "Consultoría K S.A.",
      documento: "21123456790",
      tipoCliente: "Jurídico",
      direccion: "Jr. Estrategia 808",
      telefono: "01-1234567",
    ),
    Cliente(
      nombreRazonSocial: "Inversiones L S.R.L.",
      documento: "21234567801",
      tipoCliente: "Jurídico",
      direccion: "Av. Finanza 909",
      telefono: "01-2345678",
    ),
    Cliente(
      nombreRazonSocial: "Educación M",
      documento: "21345678912",
      tipoCliente: "Jurídico",
      direccion: "Jr. Conocimiento 1010",
      telefono: "01-3456789",
    ),
    Cliente(
      nombreRazonSocial: "Hospital N S.A.",
      documento: "21456789023",
      tipoCliente: "Jurídico",
      direccion: "Av. Salud 1111",
      telefono: "01-4567890",
    ),
    Cliente(
      nombreRazonSocial: "Consultora O S.A.C.",
      documento: "21567890134",
      tipoCliente: "Jurídico",
      direccion: "Jr. Empresa 1212",
      telefono: "01-5678901",
    ),
    Cliente(
      nombreRazonSocial: "Alimentos P S.A.",
      documento: "21678901245",
      tipoCliente: "Jurídico",
      direccion: "Av. Alimentos 1313",
      telefono: "01-6789012",
    ),
  ];

  void mostrarFormularioRegistro(BuildContext context, bool editar) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
              ),
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7, // Altura fija para el modal
                  child: ListView(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        editar ? 'Editar Cliente/Proveedor' : 'Registrar Cliente/Proveedor',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _tipoDocumento,
                        decoration: InputDecoration(
                          labelText: 'Tipo de Documento',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        items: ['DNI', 'RUC', 'Sin Documento']
                            .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        )).toList(),
                        onChanged: (value) {
                          setModalState(() {
                            _tipoDocumento = value!;
                          });
                        },
                      ),
                      if (_tipoDocumento != 'Sin Documento') ...[
                        SizedBox(height: 12),
                        CustomTextFormField(controller: documentoController, labelText: 'Número de Documento', prefixIcon: LucideIcons.creditCard,keyboardType: TextInputType.number,validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el número de documento';
                          }
                          if (_tipoDocumento == 'DNI' && value.length != 8) {
                            return 'El DNI debe tener 8 dígitos';
                          }
                          if (_tipoDocumento == 'RUC' && value.length != 11) {
                            return 'El RUC debe tener 11 dígitos';
                          }
                          return null;
                        },),
                      ],
                      SizedBox(height: 12),
                      CustomTextFormField(
                        controller: nombreController,
                        labelText: 'Nombre/Razón Social',
                        prefixIcon: LucideIcons.users,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el nombre o razón social';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      CustomTextFormField(controller: direccionController, labelText: 'Dirección', prefixIcon: Icons.location_city_outlined,validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese la dirección';
                        }
                        return null;
                      },),
                      SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _tipoCliente,
                        decoration: InputDecoration(
                          labelText: 'Tipo',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        items: ['Cliente', 'Proveedor', 'Cliente y Proveedor']
                            .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        )).toList(),
                        onChanged: (value) {
                          setModalState(() {
                            _tipoCliente = value!;
                          });
                        },
                      ),
                      SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            mostrarConfigAvanzadas = !mostrarConfigAvanzadas;
                          });
                        },
                        child: Text(
                          mostrarConfigAvanzadas
                              ? 'Ocultar configuraciones avanzadas'
                              : 'Mostrar configuraciones avanzadas',
                        ),
                      ),
                      if (mostrarConfigAvanzadas) ...[
                        DropdownButtonFormField<String>(
                          value: _genero,
                          decoration: InputDecoration(
                            labelText: 'Género',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          items: [null, 'Masculino', 'Femenino', 'Otro']
                              .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label ?? 'Seleccione'),
                          )).toList(),
                          onChanged: (value) {
                            setModalState(() {
                              _genero = value;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        CustomTextFormField(controller: correoController, labelText: 'Correo Electrónico', prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress,),
                        SizedBox(height: 12),
                        CustomTextFormField(controller: telefonoController, labelText: 'Teléfono', prefixIcon: Icons.phone_android_outlined,keyboardType: TextInputType.phone),
                        SizedBox(height: 16),
                      ],

                      CustomButton(text: 'Guardar', onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          // Lógica de guardado
                          Navigator.pop(context);
                        }
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _editarCliente(Cliente cliente) {
    // Aquí iría la lógica para editar el cliente
    print('Editando cliente: ${cliente.nombreRazonSocial}');
  }

  void _eliminarCliente(Cliente cliente) {
      data.remove(cliente);
    refresh();
  }

}