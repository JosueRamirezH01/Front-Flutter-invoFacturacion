import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos LayoutBuilder para adaptarnos a los tamaños disponibles
    return LayoutBuilder(
      builder: (context, constraints) {
        // Obtenemos el ancho de la pantalla
        double screenWidth = constraints.maxWidth;

        // Móvil: Pantalla pequeña (menos de 600px)
        // Tableta: Pantalla mediana (600px - 1200px)
        // Web: Pantalla grande (más de 1200px)
        if (screenWidth < 600) {
          // Diseño para móvil
          return Scaffold(
            appBar: AppBar(title: const Text("Móvil")),
            body: Center(child: Text("Vista para móvil")),
          );
        } else if (screenWidth < 1200) {
          // Diseño para tableta
          return Scaffold(
            appBar: AppBar(title: const Text("Tableta")),
            body: Center(child: Text("Vista para tableta")),
          );
        } else {
          // Diseño para web
          return Scaffold(
            appBar: AppBar(title: const Text("Web")),
            body: Center(child: Text("Vista para web")),
          );
        }
      },
    );
  }
}
