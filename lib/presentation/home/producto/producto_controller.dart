
import 'package:flutter/material.dart';
import 'package:invefacturacion/data/model/producto.dart';
import 'package:invefacturacion/presentation/components/button.dart';
import 'package:invefacturacion/presentation/components/textFormField.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProductoController {
  late BuildContext context;
  late Function refresh;
  final TextEditingController nombreCategoria = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountSolesController = TextEditingController();
  final TextEditingController discountPercentageController = TextEditingController();

  List<Map<String, dynamic>> categoriesWithDetails = [
    {'name': 'Electrónicos', 'code': '000', 'enabled': false},
    {'name': 'Tortas', 'code': '01', 'enabled': false},
    {'name': 'Cascos', 'code': '02', 'enabled': false},
    {'name': 'Poleras', 'code': '03', 'enabled': false},
    {'name': 'Uniformes', 'code': '04', 'enabled': false},
    // Add more categories as needed
  ];

  String selectedTax = '18';
  List<String> _taxes = ['0', '5', '10', '15', '18', '21'];



  final _formKeyProducto = GlobalKey<FormState>();
  final _formKeyCategoria = GlobalKey<FormState>();

  List<String> categories = ['Todos', 'Electrónicos', 'Ropa', 'Alimentos', 'Hogar'];
  bool isPercentageDiscount = false;


  final List<Producto> _producto = [
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

   String selectedCategory = 'Todos';

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }

  void registrarCategoria(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Agregando')),
    );
    // Aquí iría la lógica de autenticación
  }

  void registrarProducto(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Agregando')),
    );
    // Aquí iría la lógica de autenticación
  }

  Future<void> addProduct(BuildContext context,bool edit , String? nombre) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {

        String? selectedCategory;

        if (nombre != null && nombre.isNotEmpty) {
          productNameController.text = nombre;
        }

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState){
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKeyProducto,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          edit ? 'Editar Producto':'Agregar Nuevo Producto',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        CustomTextFormField(
                          controller: productNameController ,
                          labelText: 'Nombre del producto',
                          keyboardType: TextInputType.name,
                          prefixIcon: LucideIcons.box,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el nombre del producto';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Categoría',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            prefixIcon: Icon(LucideIcons.tag),
                          ),
                          items: categories
                              .where((category) => category != 'Todos')
                              .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                              .toList(),
                          onChanged: (value) {
                            selectedCategory = value;
                          },
                          value: selectedCategory,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor seleccione una categoría';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        CustomTextFormField(
                          controller: quantityController,
                          labelText: 'Cantidad',
                          keyboardType: TextInputType.number,
                          prefixIcon: LucideIcons.hash,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese la cantidad';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        CustomTextFormField(
                          controller: priceController,
                          labelText: 'Precio',
                          keyboardType: TextInputType.number,
                          prefixIcon: LucideIcons.dollarSign,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el precio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: selectedTax,
                          decoration: InputDecoration(
                            labelText: 'Impuesto',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            prefixIcon: Icon(LucideIcons.percent),
                          ),
                          items: _taxes.map((tax) => DropdownMenuItem(
                            value: tax,
                            child: Text(tax),
                          )).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              selectedTax = value;
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor seleccione un impuesto';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(isPercentageDiscount ? 'Descuento en porcentaje' : 'Descuento en soles'),
                            Switch(
                              value: isPercentageDiscount,
                              onChanged: (value) {
                                setModalState(() {
                                  isPercentageDiscount = value; // Cambia el estado del switch
                                });
                              },
                            ),
                          ],
                        ),
                        // Campo para descuento en porcentaje
                        if (isPercentageDiscount) ...[
                          CustomTextFormField(
                            controller: discountPercentageController,
                            labelText: 'Descuento (%)',
                            keyboardType: TextInputType.number,
                            prefixIcon: LucideIcons.percent,
                          ),
                        ] else ...[
                          // Campo para descuento en soles
                          CustomTextFormField(
                            controller: discountSolesController,
                            labelText: 'Descuento (S/. )',
                            keyboardType: TextInputType.number,
                            prefixIcon: LucideIcons.dollarSign,
                          ),
                        ],
                        SizedBox(height: 16),
                        CustomButton(
                          text: 'Guardar',
                          onPressed: () {
                            if (_formKeyProducto.currentState!.validate()) {
                              registrarProducto(context);
                              Navigator.of(context).pop();
                              quantityController.clear();
                              priceController.clear();
                              productNameController.clear();
                            }
                          },
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void addCategory(BuildContext context,bool editCategoria) {
    showDialog(
      context: context,
      barrierDismissible: true,  // Allows tapping outside to close the dialog
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0), // Adjusts position
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKeyCategoria,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        editCategoria ? 'Editar Categoria':'Agregar Nueva Categoría',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        controller: nombreCategoria,
                        labelText: 'Nombre',
                        prefixIcon: LucideIcons.tag,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el nombre de la categoria';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Closes the dialog
                            },
                            child: Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKeyCategoria.currentState!.validate()) {
                                registrarCategoria(context);
                                Navigator.of(context).pop();
                                nombreCategoria.clear();
                              }
                            },
                            child: Text('Agregar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Producto> get filteredInventory {
    return _producto.where((item) {
      final nameMatches = item.name?.toLowerCase().contains(searchController.text.toLowerCase());
      final categoryMatches = selectedCategory == 'Todos' || item.category == selectedCategory;
      return nameMatches! && categoryMatches;
    }).toList();
  }
}