import 'package:flutter/material.dart';

class MessageDownload {
  static void showConfirmationDialog({
    required BuildContext context,
    required String action,
    var itemName,
    bool isDownload = false,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(action),
          content: isDownload
              ? Text('¿Estás seguro de que quieres descargar todos los productos en Excel?')
              : Text('¿Estás seguro de que quieres $action el producto "$itemName"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo sin acción
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo y ejecutar la acción
                onConfirm();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
