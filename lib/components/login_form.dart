// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';

import '../core/models/login_form_data.dart';

class LoginForm extends StatefulWidget {
  // const LoginForm({super.key});
  final void Function(LoginFormData) onSubmit;

  const LoginForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginFormData = LoginFormData();

  // Método para lidar com a foto
  void _handleImagePick(File image) {
    _loginFormData.image = image;
  }

  // Método para mostrar mensagem de erro nos campos de input
  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    // Verificando se é um formulário válido
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_loginFormData.image == null) {
      return _showError('Imagem não selecionada');
    }

    widget.onSubmit(_loginFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color.fromRGBO(142, 30, 3, 1), width: 1.5),
              ),
              child: TextFormField(
                key: ValueKey('email'),
                initialValue: _loginFormData.email,
                onChanged: (email) => _loginFormData.email = email,
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.contains('@')) {
                    return 'O e-mail informado é inválido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  hintText: 'E-mail',
                ),
              ),
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color.fromRGBO(142, 30, 3, 1), width: 1.5),
              ),
              child: TextFormField(
                key: ValueKey('password'),
                initialValue: _loginFormData.password,
                onChanged: (password) => _loginFormData.password = password,
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.length < 6) {
                    return 'A senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  hintText: 'Senha',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(5),
                backgroundColor: WidgetStatePropertyAll<Color>(
                    const Color.fromRGBO(142, 30, 3, 1)),
              ),
              child: Text(
                'Log in',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ), // senha
            // TextButton(), //esqueceu senha
            // SizedBox(),
            // // Criar nova conta
            // ElevatedButton(onPressed: onPressed, child: child)
          ],
        ),
      ),
    );
  }
}
