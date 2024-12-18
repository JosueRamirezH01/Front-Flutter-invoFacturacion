
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/cliente.dart';
import '../../../../data/model/producto.dart';

class NuevaVentaController {
  late BuildContext context;
  late Function refresh;
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
  late SingleSelectController<Producto?> nombreProductoAlmacenSingle = SingleSelectController<Producto?>(null);
  late SingleSelectController<Cliente?> nombreClienteSingle = SingleSelectController<Cliente?>(null);

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

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }
}