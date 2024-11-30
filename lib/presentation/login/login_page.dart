import 'package:flutter/material.dart';
import 'package:invefacturacion/presentation/components/textFormField.dart';
import 'package:invefacturacion/presentation/login/login_controller.dart';

import '../components/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _precioController = TextEditingController();
  bool _obscureText = true;
  final LoginController _con = LoginController();
  @override
  void dispose() {
    _precioController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 48),
                          _Logo(),
                          const SizedBox(height: 48),
                          Text(
                            'Sistema de Inventario y Facturación',
                            style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 48),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  controller: _usernameController,
                                  labelText: 'Nombre de usuario',
                                  prefixIcon: Icons.person,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese su correo electrónico';
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                    return 'Por favor ingrese un correo electrónico válido';
                                  }
                                  return null;
                                },
                                ),
                                const SizedBox(height: 16),
                                CustomTextFormField(
                                  controller: _passwordController,
                                  labelText: 'Contraseña',
                                  prefixIcon: Icons.lock,
                                  suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
                                  obscureText: _obscureText,
                                  onToggleVisibility: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese su contraseña';
                                  }
                                  if (value.length < 6) {
                                    return 'La contraseña debe tener al menos 6 caracteres';
                                  }
                                  return null;
                                },
                                ),
                                const SizedBox(height: 24),
                                CustomButton(onPressed: (){
                                  if (_formKey.currentState!.validate()) {
                                    _con.login(context);
                                  }
                                }, text: 'Ingresar',color: Colors.black12, height: 50,width: 200),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.inventory_2,
        size: 80,
        color: Colors.blueGrey[700],
      ),
    );
  }
}

/*lass _ForgotPasswordLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navegar a la pantalla de recuperación de contraseña
      },
      child: Text(
        '¿Olvidó su contraseña?',
        style: TextStyle(color: Colors.blueGrey[600]),
      ),
    );
  }
}*/