import 'package:flutter/material.dart';
import 'package:invefacturacion/presentation/home/caja/caja_page.dart';
import 'package:invefacturacion/presentation/home/cliente/cliente_page.dart';
import 'package:invefacturacion/presentation/home/compra/compra_page.dart';
import 'package:invefacturacion/presentation/home/dashboard.dart';
import 'package:invefacturacion/presentation/home/gasto/gasto_page.dart';
import 'package:invefacturacion/presentation/home/perfil/perfil_page.dart';
import 'package:invefacturacion/presentation/home/producto/productos_page.dart';
import 'package:invefacturacion/presentation/login/login_page.dart';
import 'package:invefacturacion/utils/drawer.dart';
import 'package:provider/provider.dart';

import 'presentation/home/configuracion/configuracion_page.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrawerState(),
      child: MaterialApp(
        title: 'Flutter Demo',
       debugShowCheckedModeBanner: false,
          initialRoute: 'dashboard',
          routes: {
            'login': (_) => LoginPage(),
            'dashboard': (_) => Dashboard(),
            'inventario':(_) => ProductoPage(),
            'cliente':(_) => ClientePage(),
            'perfil':(_) => PerfilPage(),
            'compra':(_) => CompraPage(),
            'gasto':(_) => GastosPage(),
            'configuracion':(_) => ResponsiveLayout(),
            'caja':(_)=> CajaPage()
          }
      ),
    );
  }
}




