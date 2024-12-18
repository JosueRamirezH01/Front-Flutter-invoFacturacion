import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:invefacturacion/presentation/components/textFormField.dart';
import 'package:invefacturacion/presentation/home/venta/nueva_venta/nueva_venta_controller.dart';
import '../../../../data/model/cliente.dart';
import '../../../../data/model/producto.dart';

class NuevaVentaPage extends StatefulWidget {
  const NuevaVentaPage({super.key});

  @override
  State<NuevaVentaPage> createState() => _NuevaVentaPageState();
}

class _NuevaVentaPageState extends State<NuevaVentaPage> {
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final List<Producto> _productosSeleccionados = [];
  String? _selectedDocumento;
  DateTime _selectedDate = DateTime.now();
  final NuevaVentaController _con = NuevaVentaController();
  late double total = 0.0;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nueva Venta'),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropdown<Producto>.search(
                  hintText: 'Seleccionar producto',
                  items: _con.producto,
                  controller: _con.nombreProductoAlmacenSingle,
                  decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(color: Colors.black),
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                  excludeSelected: false,
                  onChanged: (Producto? value) {
                    if (value != null) {
                      _precioController.text = value.price!.toStringAsFixed(2);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _cantidadController,
                        labelText: 'Cantidad',
                        fillColor: Colors.white,
                        filled: true,
                        height: 48,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomTextFormField(
                        controller: _precioController,
                        labelText: 'Precio',
                        filled: true,
                        fillColor: Colors.white,
                        height: 48,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _agregarProducto,
                  child: const Text('Agregar Producto'),
                ),
                const Divider(),
                if (_productosSeleccionados.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      itemCount: _productosSeleccionados.length,
                      itemBuilder: (context, index) {
                        final compra = _productosSeleccionados[index];
                        final cantidadController = TextEditingController(
                          text: compra.quantity.toString(),
                        );

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 4,
                          child: ListTile(
                            leading: const Icon(Icons.shopping_cart, color: Colors.green, size: 30),
                            title: Text(
                              compra.name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Cantidad:',
                                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      width: 50,
                                      child: TextField(
                                        controller: cantidadController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          final nuevaCantidad = int.tryParse(value) ?? 0;

                                          if (nuevaCantidad > 0) {
                                            setState(() {
                                              _productosSeleccionados[index] = Producto(
                                                id: compra.id,
                                                name: compra.name,
                                                category: compra.category,
                                                quantity: nuevaCantidad,
                                                price: (compra.price! / compra.quantity!) * nuevaCantidad,
                                              );
                                              total = _productosSeleccionados.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));

                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Precio Total: ${compra.price?.toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _productosSeleccionados.removeAt(index);
                                  total = total - (compra.price ?? 0.0);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                const Divider(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(flex: 2,child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                    const Spacer(),
                    Expanded(flex: 1,child: Text(total.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))
                  ],
                ),
                const SizedBox(height: 10),
                CustomDropdown<Cliente>.search(
                  hintText: 'Seleccionar cliente',
                  items: _con.proveedores,
                  controller: _con.nombreClienteSingle,
                  decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(color: Colors.black),
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                  excludeSelected: false,
                  onChanged: (Cliente? value) {
                    if (value != null) {
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedDocumento,
                  items: const [
                    DropdownMenuItem(value: 'Factura', child: Text('Factura')),
                    DropdownMenuItem(value: 'Boleta', child: Text('Boleta')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Documento',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedDocumento = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Fecha de Venta',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    child: Text(
                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _guardarVenta,
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _agregarProducto() {
    if (_cantidadController.text.isEmpty || _precioController.text.isEmpty) {
      _showSnackbar('Por favor, complete todos los campos');
      return;
    }

    final cantidad = int.tryParse(_cantidadController.text) ?? 0;
    final precio = double.tryParse(_precioController.text) ?? 0.0;
    final totalPrecio = precio * cantidad;
    if (cantidad > 0 && precio > 0) {
      final Producto? productoSeleccionado = _con.nombreProductoAlmacenSingle.value;

      if (productoSeleccionado != null) {
        setState(() {
          _productosSeleccionados.add(Producto(
            price: totalPrecio,
            name: productoSeleccionado.name,
            quantity: cantidad,
          ));
          total = totalPrecio + total;
        });
        FocusScope.of(context).unfocus();
        _con.nombreProductoAlmacenSingle.clear();
        _cantidadController.clear();
        _precioController.clear();
      } else {
        _showSnackbar('Seleccione un producto válido');
      }
    } else {
      _showSnackbar('Ingrese valores válidos');
    }
  }

  void _guardarVenta() {
    if (_validateForm()) {
      Navigator.of(context).pop({
        'id': 'V${DateTime.now().millisecondsSinceEpoch}',
        'cliente': _clienteController.text,
        'total': double.tryParse(_totalController.text) ?? 0.0,
        'fecha': _selectedDate.toIso8601String().split('T')[0],
        'doc': _selectedDocumento,
        'usuario': 'Usuario Actual',
        'pagado': false,
      });
    }
  }

  bool _validateForm() {
    if (_clienteController.text.isEmpty ||
        _totalController.text.isEmpty ||
        _selectedDocumento == null) {
      _showSnackbar('Por favor complete todos los campos');
      return false;
    }
    return true;
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void refresh() {
    setState(() {});
  }
}