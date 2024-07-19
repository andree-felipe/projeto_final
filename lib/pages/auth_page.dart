// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 270),
              height: 220,
              child: SvgPicture.asset(
                'assets/images/logo_auth_page.svg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 200),
            Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll<double>(5),
                  backgroundColor: WidgetStatePropertyAll<Color>(const Color.fromRGBO(142, 30, 3, 1)),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return LoginPage();
                    }),
                  );
                },
                child: const Text(
                  'Cadastrar-se',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll<double>(5),
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                  side: WidgetStatePropertyAll<BorderSide>(
                    BorderSide(
                      color: const Color.fromRGBO(142, 30, 3, 1),
                      width: 1.5,
                    )
                  )
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return LoginPage();
                    }),
                  );
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Color.fromRGBO(142, 30, 3, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
    ));
  }
}
