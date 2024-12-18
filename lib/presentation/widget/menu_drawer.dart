import 'package:flutter/material.dart';
import 'package:invefacturacion/utils/drawer.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class WidgetMenu extends StatelessWidget {
  const WidgetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerState = Provider.of<DrawerState>(context);
    final ScrollController scrollController = ScrollController(); // Controlador del Scroll

    Widget buildMenuItem(IconData icon, String title, int index, String route) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        child: Container(
          // Ajustar ancho para dejar espacio a la barra deslizante
          margin: const EdgeInsets.only(right: 16.0),
          decoration: BoxDecoration(
            color: drawerState.selectOption == index
                ? Colors.blue.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(icon, color: Colors.blue),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.blue),
            onTap: () {
              drawerState.updateSelectOption(index);
              Navigator.pushNamed(context, route);
            },
          ),
        ),
      );
    }

    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Nombre del Usuario'),
            accountEmail: Text('usuario@ejemplo.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/img/perfil.png'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Scrollbar(
              controller: scrollController, // Asociar el controlador
              thumbVisibility: true,
              thickness: 8.0,
              radius: const Radius.circular(10),
              child: ListView(
                controller: scrollController, // Usar el mismo controlador
                padding: EdgeInsets.zero,
                children: [
                  buildMenuItem(Icons.dashboard, 'Dashboard', 0, 'dashboard'),
                  buildMenuItem(Icons.person, 'Perfil', 1, 'perfil'),
                  buildMenuItem(Icons.shopping_cart, 'Ventas', 2, 'venta'),
                  buildMenuItem(LucideIcons.users, 'Clientes', 3, 'cliente'),
                  buildMenuItem(LucideIcons.box, 'Productos', 4, 'inventario'),
                  buildMenuItem(Icons.assessment, 'Compras', 5, 'compra'),
                  buildMenuItem(Icons.paid, 'Gastos', 6, 'gasto'),
                  buildMenuItem(Icons.point_of_sale, 'Caja', 7, 'caja'),
                  buildMenuItem(Icons.inventory, 'Reportes', 8, 'inventario'),
                  buildMenuItem(Icons.settings, 'Configuración', 9, 'configuracion'),
                  buildMenuItem(Icons.help, 'Ayuda', 10, 'nueva_venta'),
                  // Agregar más elementos si es necesario para que la lista sea más larga
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Implementar lógica de cierre de sesión
            },
          ),
        ],
      ),
    );
  }
}
