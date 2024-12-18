

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invefacturacion/data/model/cliente.dart';
import 'package:invefacturacion/data/model/producto_compra.dart';
import 'package:invefacturacion/presentation/components/textFormField.dart';
import 'package:invefacturacion/presentation/home/producto/producto_controller.dart';
import 'package:invefacturacion/presentation/widget/CustomMessage.dart';

import '../../../data/model/almacen.dart';
import '../../../data/model/compra.dart';
import '../../../data/model/pago.dart';
import '../../../data/model/producto.dart';

class CompraController {

  late BuildContext context;
  late Function refresh;
  List<Compra> listaCompras = [
    Compra(
      numeroCompra: 1,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor A',
      total: 1500.75,
      fecha: DateTime(2023, 1, 10),
      usuario: 'Usuario1',
    ),
    Compra(
      numeroCompra: 2,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor B',
      total: 200.00,
      fecha: DateTime(2023, 2, 14),
      usuario: 'Usuario2',
    ),
    Compra(
      numeroCompra: 3,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor C',
      total: 750.25,
      fecha: DateTime(2023, 3, 3),
      usuario: 'Usuario3',
    ),
    Compra(
      numeroCompra: 4,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor D',
      total: 1200.00,
      fecha: DateTime(2023, 4, 5),
      usuario: 'Usuario4',
    ),
    Compra(
      numeroCompra: 5,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor E',
      total: 620.10,
      fecha: DateTime(2023, 5, 8),
      usuario: 'Usuario1',
    ),
    Compra(
      numeroCompra: 6,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor F',
      total: 330.75,
      fecha: DateTime(2023, 6, 20),
      usuario: 'Usuario2',
    ),
    Compra(
      numeroCompra: 7,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor G',
      total: 450.60,
      fecha: DateTime(2023, 7, 10),
      usuario: 'Usuario3',
    ),
    Compra(
      numeroCompra: 8,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor H',
      total: 975.00,
      fecha: DateTime(2023, 8, 17),
      usuario: 'Usuario4',
    ),
    Compra(
      numeroCompra: 9,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor I',
      total: 1020.45,
      fecha: DateTime(2023, 9, 30),
      usuario: 'Usuario1',
    ),
    Compra(
      numeroCompra: 10,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor J',
      total: 280.20,
      fecha: DateTime(2023, 10, 8),
      usuario: 'Usuario2',
    ),
    Compra(
      numeroCompra: 11,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor K',
      total: 1870.30,
      fecha: DateTime(2023, 11, 19),
      usuario: 'Usuario3',
    ),
    Compra(
      numeroCompra: 12,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor L',
      total: 530.00,
      fecha: DateTime(2023, 12, 24),
      usuario: 'Usuario4',
    ),
    Compra(
      numeroCompra: 13,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor M',
      total: 690.55,
      fecha: DateTime(2024, 1, 2),
      usuario: 'Usuario1',
    ),
    Compra(
      numeroCompra: 14,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor N',
      total: 210.75,
      fecha: DateTime(2024, 2, 12),
      usuario: 'Usuario2',
    ),
    Compra(
      numeroCompra: 15,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor O',
      total: 1530.00,
      fecha: DateTime(2024, 3, 10),
      usuario: 'Usuario3',
    ),
    Compra(
      numeroCompra: 16,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor P',
      total: 320.45,
      fecha: DateTime(2024, 4, 5),
      usuario: 'Usuario4',
    ),
    Compra(
      numeroCompra: 17,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor Q',
      total: 760.30,
      fecha: DateTime(2024, 5, 14),
      usuario: 'Usuario1',
    ),
    Compra(
      numeroCompra: 18,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor R',
      total: 440.00,
      fecha: DateTime(2024, 6, 8),
      usuario: 'Usuario2',
    ),
    Compra(
      numeroCompra: 19,
      tipoDocumento: 'Factura',
      proveedor: 'Proveedor S',
      total: 890.20,
      fecha: DateTime(2024, 7, 3),
      usuario: 'Usuario3',
    ),
    Compra(
      numeroCompra: 20,
      tipoDocumento: 'Boleta',
      proveedor: 'Proveedor T',
      total: 1195.75,
      fecha: DateTime(2024, 8, 22),
      usuario: 'Usuario4',
    ),
  ];
  List<Cliente> proveedores = [
    Cliente(
      nombreRazonSocial: 'Proveedor 1 S.A.',
      documento: 'RUC 12345678901',
      tipoCliente: 'Proveedor',
      direccion: 'Av. Proveedores 123, Lima',
      telefono: '+51 987 654 321',
    ),
    Cliente(
      nombreRazonSocial: 'Proveedor 2 S.A.C.',
      documento: 'RUC 98765432109',
      tipoCliente: 'Proveedor',
      direccion: 'Calle Industria 456, Lima',
      telefono: '+51 912 345 678',
    ),
    Cliente(
      nombreRazonSocial: 'Proveedores Unidos S.A.',
      documento: 'RUC 13579246801',
      tipoCliente: 'Proveedor',
      direccion: 'Av. Comercio 789, Lima',
      telefono: '+51 964 738 572',
    ),
    Cliente(
      nombreRazonSocial: 'Distribuidora XYZ S.A.',
      documento: 'RUC 24680135709',
      tipoCliente: 'Proveedor',
      direccion: 'Calle Distribuidores 321, Lima',
      telefono: '+51 955 662 134',
    ),
    Cliente(
      nombreRazonSocial: 'Proveedor Global S.A.C.',
      documento: 'RUC 36925814706',
      tipoCliente: 'Proveedor',
      direccion: 'Av. Global 159, Lima',
      telefono: '+51 986 474 923',
    ),
  ];
  List<Almacen> listaAlmacenes = [
    Almacen(
      numero: 1,
      tipo: 'Entrada',
      fecha: DateTime(2023, 1, 5),
      usuario: 'Usuario1',
      origen: 'Compra',
    ),
    Almacen(
      numero: 2,
      tipo: 'Salida',
      fecha: DateTime(2023, 2, 12),
      usuario: 'Usuario2',
      origen: 'Compra',
    ),
    Almacen(
      numero: 3,
      tipo: 'Entrada',
      fecha: DateTime(2023, 3, 18),
      usuario: 'Usuario3',
      origen: 'Compra',
    ),
    Almacen(
      numero: 4,
      tipo: 'Salida',
      fecha: DateTime(2023, 4, 25),
      usuario: 'Usuario4',
      origen: 'Compra',
    ),
    Almacen(
      numero: 5,
      tipo: 'Entrada',
      fecha: DateTime(2023, 5, 10),
      usuario: 'Usuario5',
      origen: 'Compra',
    ),
    Almacen(
      numero: 6,
      tipo: 'Salida',
      fecha: DateTime(2023, 6, 15),
      usuario: 'Usuario6',
      origen: 'Venta',
    ),
    Almacen(
      numero: 7,
      tipo: 'Entrada',
      fecha: DateTime(2023, 7, 5),
      usuario: 'Usuario7',
      origen: 'Venta',
    ),
    Almacen(
      numero: 8,
      tipo: 'Salida',
      fecha: DateTime(2023, 8, 20),
      usuario: 'Usuario8',
      origen: 'Venta',
    ),
    Almacen(
      numero: 9,
      tipo: 'Entrada',
      fecha: DateTime(2023, 9, 30),
      usuario: 'Usuario9',
      origen: 'Venta',
    ),
    Almacen(
      numero: 10,
      tipo: 'Salida',
      fecha: DateTime(2023, 10, 8),
      usuario: 'Usuario10',
      origen: 'Venta',
    ),
    Almacen(
      numero: 11,
      tipo: 'Entrada',
      fecha: DateTime(2023, 11, 19),
      usuario: 'Usuario1',
      origen: 'Venta',
    ),
    Almacen(
      numero: 12,
      tipo: 'Salida',
      fecha: DateTime(2023, 12, 24),
      usuario: 'Usuario2',
      origen: 'Venta',
    ),
    Almacen(
      numero: 13,
      tipo: 'Entrada',
      fecha: DateTime(2024, 1, 2),
      usuario: 'Usuario3',
      origen: 'Venta',
    ),
    Almacen(
      numero: 14,
      tipo: 'Salida',
      fecha: DateTime(2024, 2, 12),
      usuario: 'Usuario4',
      origen: 'Venta',
    ),
    Almacen(
      numero: 15,
      tipo: 'Entrada',
      fecha: DateTime(2024, 3, 10),
      usuario: 'Usuario5',
      origen: 'Venta',
    ),
    Almacen(
      numero: 16,
      tipo: 'Salida',
      fecha: DateTime(2024, 4, 5),
      usuario: 'Usuario6',
      origen: 'Compra',
    ),
    Almacen(
      numero: 17,
      tipo: 'Entrada',
      fecha: DateTime(2024, 5, 14),
      usuario: 'Usuario7',
      origen: 'Venta',
    ),
    Almacen(
      numero: 18,
      tipo: 'Salida',
      fecha: DateTime(2024, 6, 8),
      usuario: 'Usuario8',
      origen: 'Compra',
    ),
    Almacen(
      numero: 19,
      tipo: 'Entrada',
      fecha: DateTime(2024, 7, 3),
      usuario: 'Usuario9',
      origen: 'Compra',
    ),
    Almacen(
      numero: 20,
      tipo: 'Salida',
      fecha: DateTime(2024, 8, 22),
      usuario: 'Usuario10',
      origen: 'Venta',
    ),
  ];
  bool showMessage = false; // Variable para controlar la visibilidad del mensaje

  final List<Producto> producto = [
    Producto(id: 1, name: 'Laptop', category: 'Electrónicos', quantity: 50, price: 1200.00),
    Producto(id: 2, name: 'Camiseta', category: 'Ropa', quantity: 100, price: 25.99),
    Producto(id: 3, name: 'Arroz', category: 'Alimentos', quantity: 200, price: 5.50),
    Producto(id: 4, name: 'Silla', category: 'Hogar', quantity: 30, price: 89.99),
    Producto(id: 5, name: 'Teléfono móvil', category: 'Electrónicos', quantity: 75, price: 799.00),
    Producto(id: 6, name: 'Zapatos', category: 'Ropa', quantity: 60, price: 49.99),
    Producto(id: 7, name: 'Televisor', category: 'Electrónicos', quantity: 25, price: 450.00),
    Producto(id: 8, name: 'Pantalones', category: 'Ropa', quantity: 80, price: 39.99),
    Producto(id: 9, name: 'Pan', category: 'Alimentos', quantity: 150, price: 1.20),
    Producto(id: 10, name: 'Mesa', category: 'Hogar', quantity: 40, price: 199.99),
    Producto(id: 11, name: 'Cámara', category: 'Electrónicos', quantity: 20, price: 599.00),
    Producto(id: 12, name: 'Chaqueta', category: 'Ropa', quantity: 35, price: 79.99),
    Producto(id: 13, name: 'Pastas', category: 'Alimentos', quantity: 300, price: 3.50),
    Producto(id: 14, name: 'Sofá', category: 'Hogar', quantity: 15, price: 899.00),
    Producto(id: 15, name: 'Monitor', category: 'Electrónicos', quantity: 50, price: 299.99),
    Producto(id: 16, name: 'Cinturón', category: 'Ropa', quantity: 70, price: 19.99),
    Producto(id: 17, name: 'Aceite de oliva', category: 'Alimentos', quantity: 80, price: 6.75),
    Producto(id: 18, name: 'Estante', category: 'Hogar', quantity: 25, price: 129.99),
    Producto(id: 19, name: 'Auriculares', category: 'Electrónicos', quantity: 100, price: 89.99),
    Producto(id: 20, name: 'Vestido', category: 'Ropa', quantity: 45, price: 59.99),
    Producto(id: 21, name: 'Cereal', category: 'Alimentos', quantity: 200, price: 4.00),
  ];
  Producto? selectedProduct;
  final TextEditingController searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  final _formKeyCompra = GlobalKey<FormState>();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  TextEditingController autocompleteControllerProducto = TextEditingController();
  TextEditingController autocompleteControllerProveedor = TextEditingController();
  final TextEditingController totalController = TextEditingController(text: '0.0');

  ///----- ALMACEN
  final TextEditingController cantidadProductoAlmacen = TextEditingController();
  final TextEditingController numeroGuiaAlmacen = TextEditingController();

  final TextEditingController nombreProductoAlmacen = TextEditingController();
  final TextEditingController puntoLlegadaAlmacen = TextEditingController();
  final TextEditingController puntoPartidaAlmacen = TextEditingController();
  final TextEditingController placaAlmacen = TextEditingController();
  final TextEditingController marcaAlmacen = TextEditingController();

  late SingleSelectController<Producto?> nombreProductoAlmacenSingle = SingleSelectController<Producto?>(null);
  late double? precioProductoAlmacen;
  late int? idProductoAlmacen;
  late int? idRemitenteAlmacen;
  String? guiaAlmacen;
  String selectedPaymentMethod = 'Efectivo';
  final ProductoController _controller =ProductoController();
  double totalCompra = 0.0;
  DateTime selectedDateCompra = DateTime.now();
  DateTime selectedDatePago = DateTime.now();
  DateTime selectedDateAlmacen = DateTime.now();
  late List<Pago> pagos = [Pago(tipoPago: 'Efectivo', fecha: DateTime.now(), total: 0.0)];
  final List<ProductoCompra> compras = []; // Lista global para almacenar las compras
  final List<Producto> productoAlmacen = [];
  String? entradaSalida = 'Entrada';
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

  }


  List<Compra> get filteredCompra {
    return listaCompras.where((item) {
      final searchMatches = item.numeroCompra.toString().contains(searchController.text.toLowerCase());
      final dateMatches = _isWithinDateRange(item.fecha!);  // Aquí se utiliza el método _isWithinDateRange
      return searchMatches && dateMatches;
    }).toList();
  }
  List<Almacen> get filteredInventory{
    return listaAlmacenes.where((item) {
      final searchMatches = item.numero.toString().contains(searchController.text.toLowerCase());
      final dateMatches = _isWithinDateRange(item.fecha!);  // Aquí se utiliza el método _isWithinDateRange
      return searchMatches && dateMatches;
    }).toList();
  }

  void filterByDateRange(DateTime? startDate, DateTime? endDate) {
    _startDate = startDate;
    _endDate = endDate;
    refresh(); // Refresca la interfaz después de aplicar el filtro.
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




  void addCompra(BuildContext context, bool edit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        Cliente? selectedCliente;
        String igvOption = 'Con IGV'; // Valor por defecto para IGV

        // Función para validar y habilitar o deshabilitar el botón

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
                      key: _formKeyCompra,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            edit ? 'Editar Compra' : 'Agregar Nueva Compra',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          // Autocomplete para buscar o seleccionar producto
                          Autocomplete<Producto>(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<Producto>.empty();
                              }
                              final matches =producto.where((producto) =>
                                  producto.name!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                              return matches.isEmpty ? [Producto(id: -1, name: '')] : matches;
                            },
                            onSelected: (Producto selection) {
                              if (selection.id == -1) {
                                // Llama al método para agregar un nuevo producto cuando se selecciona el botón
                                _controller.addProduct(context, false, '').then((_) {
                                  setModalState(() {
                                    autocompleteControllerProducto.clear();  // Limpia el campo después de agregar el producto
                                  });
                                });
                              } else {
                                // Selecciona el producto normal
                                setModalState(() {
                                  selectedProduct = selection;
                                  autocompleteControllerProducto.text = selection.name!;
                                  productNameController.text = selection.id!.toString();
                                });
                              }
                            },
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController textEditingController,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted) {
                              autocompleteControllerProducto = textEditingController;
                              return TextFormField(
                                controller: autocompleteControllerProducto,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  labelText: 'Buscar o seleccionar producto',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: const Icon(Icons.search),
                                  fillColor: Colors.white,
                                  filled: true
                                ),

                              );
                            },
                            optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<Producto> onSelected, Iterable<Producto> options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4.0,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 200),
                                    child: options.isEmpty || (options.length == 1 && options.first.id == -1)
                                        ? ListTile(
                                      title: TextButton(
                                        onPressed: () async {
                                          FocusScope.of(context).unfocus();
                                          await _controller.addProduct(context, false, autocompleteControllerProducto.text);
                                        },
                                        child: Text(
                                          'Agregar nuevo producto',
                                          style: TextStyle(color: Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    )
                                        : ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: options.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final Producto option = options.elementAt(index);
                                        return ListTile(
                                          title: Text(option.name!),
                                          onTap: () {
                                            onSelected(option);
                                            setModalState((){
                                              priceController.text = option.price!.toStringAsFixed(2);
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: quantityController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Cantidad',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                    fillColor: Colors.white,
                                    filled: true
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese cantidad';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Precio',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                    fillColor: Colors.white,
                                    filled: true
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese precio';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                flex: 1,
                                child: DropdownButtonFormField<String>(
                                  value: igvOption, // Valor por defecto "Con IGV"
                                  decoration: const InputDecoration(
                                    labelText: 'IGV',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                    fillColor: Colors.white,
                                    filled: true
                                  ),
                                  items: <String>['Con IGV', 'Sin IGV'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setModalState(() {
                                      igvOption = newValue ?? 'Con IGV';
                                    });
                                  },
                                  validator: (value) {
                                    // Este campo no afectará la validación del botón
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.red)
                                    ),
                                    onPressed: () {
                                      if (_formKeyCompra.currentState!.validate()) {
                                        setModalState(() {
                                          int? cantidad = int.tryParse(quantityController.text);
                                          double? precio = double.tryParse(priceController.text);
                                          double subtotal = (precio! * cantidad!);
                                          totalCompra = totalCompra + subtotal;
                                          pagos[0].total = pagos[0].total! + subtotal;
                                          compras.add(
                                            ProductoCompra(
                                              idProducto: int.tryParse(productNameController.text),
                                              nombre: autocompleteControllerProducto.text,
                                              cantidad: cantidad,
                                              precio:  subtotal,
                                              igv: igvOption
                                            )
                                          );

                                          autocompleteControllerProducto.clear();
                                          quantityController.clear();
                                          priceController.clear();
                                          selectedProduct = null;
                                        });
                                      }
                                    },
                                    child: const Text('+', style: TextStyle(color: Colors.white, fontSize: 20)),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () async {
                                    final DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDateCompra, // Fecha inicial
                                      firstDate: DateTime(2000), // Fecha mínima
                                      lastDate: DateTime.now(), // Fecha máxima: hoy
                                    );
                                    if (pickedDate != null && pickedDate != selectedDateCompra) {
                                      setModalState(() {
                                        selectedDateCompra = pickedDate;
                                      });
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de Compra',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                      fillColor: Colors.white,
                                      filled: true
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${selectedDateCompra.day}/${selectedDateCompra.month}/${selectedDateCompra.year}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          if (compras.isNotEmpty)
                            Container(  // El contenedor que tiene un tamaño fijo
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              constraints: const BoxConstraints(
                                maxHeight: 300, // Puedes ajustar el maxHeight al tamaño que desees para el contenedor
                              ),
                              child: SingleChildScrollView(  // El SingleChildScrollView permitirá el desplazamiento solo dentro de este contenedor
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Productos Agregados',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1.2,
                                    ),
                                    const SizedBox(height: 8.0),
                                    // Aquí sigue la lista de compras
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(), // Impide que el ListView se desplace por sí mismo
                                      itemCount: compras.length,
                                      itemBuilder: (context, index) {
                                        final compra = compras[index];
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          elevation: 4,
                                          child: ListTile(
                                            leading: const Icon(Icons.shopping_cart, color: Colors.green, size: 30),
                                            title: Text(
                                              '${compra.nombre}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Cantidad: ${compra.cantidad}',
                                                    style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
                                                  ),
                                                  Text(
                                                    'Precio: ${compra.precio!.toStringAsFixed(2)}',
                                                    style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min, // Asegura que no ocupe más espacio del necesario
                                              children: [
                                                Chip(
                                                  label: Text(
                                                    compra.igv!,
                                                    style: TextStyle(
                                                      color: compra.igv! == 'Con IGV' ? Colors.green : Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  backgroundColor: compra.igv! == 'Con IGV' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.delete, color: Colors.red),
                                                  onPressed: () {
                                                    // Acción para eliminar el producto de la lista
                                                    double? total = compra.precio;
                                                    setModalState(() {
                                                      totalCompra = totalCompra - total!;
                                                      pagos[0].total = (pagos[0].total! - total < 0) ? 0.0 : pagos[0].total! - total;
                                                      compras.removeAt(index);
                                                      if (compras.isEmpty) {
                                                        // Restablecer los métodos de pago dejando solo el primero por defecto
                                                        pagos = [
                                                          Pago(
                                                            tipoPago: 'Efectivo',
                                                            fecha: DateTime.now(),
                                                            total: 0.0,
                                                          )
                                                        ];
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(flex: 2,child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                              const Spacer(),
                              Expanded(flex: 1,child: Text(totalCompra.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              // Generar un formulario para cada método de pago en la lista `pagos`
                              ...pagos.map((pago) {
                                int index = pagos.indexOf(pago);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      // Dropdown para método de pago
                                      DropdownButtonFormField<String>(
                                        value: pago.tipoPago,
                                        decoration: InputDecoration(
                                          labelText: 'Método de Pago ${index + 1}',
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        items: <String>['Efectivo', 'BCP', 'Tarjeta de Crédito', 'Yape', 'Plin']
                                            .map((String method) {
                                          return DropdownMenuItem<String>(
                                            value: method,
                                            child: Text(method),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setModalState(() {
                                            pago.tipoPago = newValue!;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 16.0),

                                      // Selector de fecha
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () async {
                                                final DateTime? pickedDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: pago.fecha,
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime.now(),
                                                );
                                                if (pickedDate != null) {
                                                  setModalState(() {
                                                    pago.fecha = pickedDate;
                                                  });
                                                }
                                              },
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  labelText: 'Fecha de Pago ${index + 1}',
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                ),
                                                child: Text(
                                                  "${pago.fecha?.day}/${pago.fecha?.month}/${pago.fecha?.year}",
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),

                                          // Campo para total
                                          Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              controller: TextEditingController(text: pago.total!.toStringAsFixed(2)),
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText: 'Total Pago ${index + 1}',
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                              onChanged: (value) {
                                                setModalState(() {
                                                  double? nuevoTotal = double.tryParse(value) ?? 0.0;

                                                  pago.total = nuevoTotal;
                                                });
                                              },
                                            ),
                                          ),
                                          if (index > 0)
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              onPressed: () {
                                                setModalState(() {
                                                  pagos.removeAt(index);
                                                });
                                              },
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),

                              // Botón para agregar un nuevo método de pago
                              Align(
                                alignment: Alignment.topLeft,
                                child: TextButton(
                                  onPressed: () {
                                    setModalState(() {
                                      // Calcular el total acumulado de todos los pagos
                                      double totalPagos = pagos.fold(0.0, (sum, pago) => sum + (pago.total ?? 0.0));

                                      // Validar si se puede agregar un nuevo pago
                                      if (totalPagos >= totalCompra) {
                                        // Mostrar mensaje indicando que no se puede agregar más pagos
                                        showMessage = true;
                                      } else {
                                        // Calcular la diferencia restante
                                        double diferencia = totalCompra - totalPagos;

                                        // Agregar un nuevo método de pago con la diferencia como total inicial
                                        pagos.add(Pago(
                                          tipoPago: 'Efectivo',
                                          fecha: DateTime.now(),
                                          total: diferencia,
                                        ));

                                        // Ocultar mensaje si todo es correcto
                                        showMessage = false;
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "Agregar más pagos",
                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                            ],
                          ),

                          if (showMessage)
                            const CustomMessage(
                              message: 'Para agregar más métodos de pago, el total del primer método de pago tiene que ser menor del total.',
                              isPositive: false, // Indicar si es un mensaje negativo o positivo
                            ),
                          CustomDropdown<Cliente>.search(
                            hintText: 'seleccionar proveedor',
                            items: proveedores,
                            excludeSelected: false,
                            decoration: CustomDropdownDecoration(closedBorder: Border.all(color: Colors.black),hintStyle: const TextStyle(color: Colors.black)),
                            onChanged: (Cliente? value) {
                              if (value != null) {
                                print('Selected product ID: ${value.documento}');
                                // Aquí puedes usar el ID o cualquier otra propiedad del producto
                              }
                            },
                          ),
                          /*Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'cliente');
                              },
                              child: const Text(
                                "Registrar nuevo proveedor",
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),*/
                          const SizedBox(height: 16.0),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.red)
                              ),
                              onPressed: () {
                                print('--------------------------------------');
                                    for (var element in compras) {
                                      print('PRODUCTO DE compra $element');
                                    }

                                // Asegúrate de que la lista `pagos` tenga elementos antes de imprimir
                                if (pagos.isNotEmpty) {
                                  for (var pago in pagos) {
                                    print('Método de Pago: ${pago.tipoPago}');
                                    print('Fecha de Pago: ${pago.fecha}');
                                    print('Total: ${pago.total}');
                                  }
                                } else {
                                  print('No hay pagos registrados.');
                                }
                              },
                              child: const Text('GUARDAR', style: TextStyle(color: Colors.white, fontSize: 16)),


                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void addAlmacen(BuildContext context, bool edit) {
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
                      key: _formKeyCompra,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            edit ? 'Editar Ajuste' : 'Ajuste Nuevo',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          CustomDropdown<Producto>.search(
                            hintText: 'seleccionar producto',
                            items: producto,
                            controller: nombreProductoAlmacenSingle,
                            decoration: CustomDropdownDecoration(closedBorder: Border.all(color: Colors.black),hintStyle: const TextStyle(color: Colors.black)),
                            excludeSelected: false,
                            onChanged: (Producto? value) {
                              if (value != null) {
                                nombreProductoAlmacen.text = value.name!;
                                precioProductoAlmacen = value.price;
                                idProductoAlmacen = value.id;
                                print('Selected product ID: ${value.id}');
                                // Aquí puedes usar el ID o cualquier otra propiedad del producto
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: CustomTextFormField(controller: cantidadProductoAlmacen, keyboardType: TextInputType.number, labelText: 'Cantidad', height: 48, filled: true, fillColor: Colors.white,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese el total';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 80,
                                child: ElevatedButton(
                                    onPressed: (){
                                      setModalState(() {
                                        productoAlmacen.add(
                                            Producto(
                                                name: nombreProductoAlmacen.text,
                                                price: precioProductoAlmacen,
                                                quantity: int.parse(cantidadProductoAlmacen.text),
                                                id: idProductoAlmacen
                                            )
                                        );
                                        nombreProductoAlmacenSingle.clear();
                                        nombreProductoAlmacen.clear();
                                        cantidadProductoAlmacen.clear();
                                      });

                                    },
                                    style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.red)
                                ),child: const Text('+', style: TextStyle(color: Colors.white, fontSize: 20)),
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          if (productoAlmacen.isNotEmpty)
                            Container(  // El contenedor que tiene un tamaño fijo
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              constraints: const BoxConstraints(
                                maxHeight: 300, // Puedes ajustar el maxHeight al tamaño que desees para el contenedor
                              ),
                              child: SingleChildScrollView(  // El SingleChildScrollView permitirá el desplazamiento solo dentro de este contenedor
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Productos Agregados',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1.2,
                                    ),
                                    const SizedBox(height: 8.0),
                                    // Aquí sigue la lista de compras
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(), // Impide que el ListView se desplace por sí mismo
                                      itemCount: productoAlmacen.length,
                                      itemBuilder: (context, index) {
                                        final listAlmacen = productoAlmacen[index];
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          elevation: 4,
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Cod. : ${listAlmacen.id}',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Cant. : ${listAlmacen.quantity}',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Nombre: ${listAlmacen.name}',
                                                    style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
                                                  ),
                                                  Text(
                                                    'Precio: ${listAlmacen.price}',
                                                    style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const Divider(),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: DropdownButtonFormField<String>(
                                  value: entradaSalida, // Valor por defecto "Con IGV"
                                  decoration: const InputDecoration(
                                    labelText: 'Entrada/Salida',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                    fillColor: Colors.white,
                                    filled: true
                                  ),
                                  items: <String>['Entrada', 'Salida'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setModalState(() {
                                      entradaSalida = newValue ?? 'Entrada';
                                    });
                                  },
                                  validator: (value) {
                                    // Este campo no afectará la validación del botón
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () async {
                                    final DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDateAlmacen, // Fecha inicial
                                      firstDate: DateTime(2000), // Fecha mínima
                                      lastDate: DateTime.now(), // Fecha máxima: hoy
                                    );
                                    if (pickedDate != null && pickedDate != selectedDateAlmacen) {
                                      setModalState(() {
                                        selectedDateAlmacen = pickedDate;
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
                                        "${selectedDateAlmacen.day}/${selectedDateAlmacen.month}/${selectedDateAlmacen.year}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('GUIA',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomTextFormField(controller: numeroGuiaAlmacen,keyboardType: TextInputType.text,labelText: 'Numero',filled: true,fillColor: Colors.white, height: 44,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese el numero';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: guiaAlmacen,
                            decoration: const InputDecoration(
                              labelText: 'Tipo de guia',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                              filled: true,
                              fillColor: Colors.white
                            ),
                            items: <String>[
                              'Guia remision remitente',
                              'Guia remision transportista',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setModalState(() {
                                guiaAlmacen = newValue;
                              });
                            },
                            validator: (value) {
                              return null; // Este campo no afectará la validación del botón
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomDropdown<Cliente>.search(
                            hintText: 'Seleccionar remitente',
                            items: proveedores,
                            decoration: CustomDropdownDecoration(closedBorder: Border.all(color: Colors.black),hintStyle: const TextStyle(color: Colors.black)),
                            excludeSelected: false,
                            onChanged: (Cliente? value) {
                              if (value != null) {
                                idRemitenteAlmacen = value.id;
                                print('Selected product ID: ${value.id}');
                                // Aquí puedes usar el ID o cualquier otra propiedad del producto
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(controller: puntoPartidaAlmacen, keyboardType: TextInputType.text, labelText: 'Punto de Partida', filled: true, fillColor: Colors.white,height: 48,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese el total';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(controller: puntoLlegadaAlmacen, keyboardType: TextInputType.number, labelText: 'Punto de Llegada', height: 48, fillColor: Colors.white, filled: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese el total';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Datos transporte',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomTextFormField(controller: placaAlmacen, keyboardType: TextInputType.number, filled: true, fillColor: Colors.white, height: 48, labelText: 'Placa',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese el total';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: CustomTextFormField(controller: marcaAlmacen, keyboardType: TextInputType.number, labelText: 'Marca', height: 48, filled: true, fillColor: Colors.white,
                                  validator: (value) {
                                  if (value == null || value.isEmpty) {
                                      return 'Ingrese el total';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.red)
                              ),
                              onPressed: () {
                                /*print('--------------------------------------');
                                for (var element in compras) {
                                  print('PRODUCTO DE compra $element');
                                }
                                for (var element in pagos) {
                                  print('PRODUCTO DE PAGO ${element.tipoPago}');
                                  print('PRODUCTO DE PAGO ${element.fecha}');
                                  print('PRODUCTO DE PAGO ${element.total}');
                                }
*/
                              },
                              child: const Text('GUARDAR', style: TextStyle(color: Colors.white, fontSize: 16)),


                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

}

