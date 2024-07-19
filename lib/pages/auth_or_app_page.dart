// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';
import '../core/models/app_user.dart';
import 'loading_page.dart';
import 'auth_page.dart';
import 'home_page.dart';

class LoginOrSignupPage extends StatelessWidget {
  const LoginOrSignupPage({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return StreamBuilder<AppUser?>(
              stream: AuthService().userChanges,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                } else {
                  return snapshot.hasData ? HomePage() : AuthPage();
                }
              },
            );
          }
        });
  }
}
