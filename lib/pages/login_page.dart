// ignore_for_file: prefer_const_constructors, control_flow_in_finally

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/login_form.dart';
import '../core/models/login_form_data.dart';
import '../core/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(LoginFormData loginFormData) async {
    try {
      if(!mounted) return;
      setState(() => _isLoading = false);

      await AuthService().login(loginFormData.email, loginFormData.password);
    } catch (error) {
      // Tratar erro
    } finally {
      if(!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 170),
              height: 110,
              width: 110,
              child: SvgPicture.asset(
                'assets/images/main_logo.svg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: LoginForm(onSubmit: _handleSubmit,),
            ),
            if(_isLoading) 
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ), 
    );
  }
}