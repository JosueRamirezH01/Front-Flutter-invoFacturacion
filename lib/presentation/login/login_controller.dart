
import 'package:flutter/material.dart';

class LoginController {
  late BuildContext context;
  late Function refresh;
  final _formKey = GlobalKey<FormState>();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }

  void login(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Iniciando sesión...')),
    );
    // Aquí iría la lógica de autenticación
  }


}