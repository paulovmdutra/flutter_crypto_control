import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.blueAccent])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Center(
                    child: Flexible(
                  child:
                      Image.asset('assets/images/logo.png', fit: BoxFit.fill),
                )),
                const SizedBox(
                  height: 8,
                ),
                const Text('Financy',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))
              ])),
          const Padding(            
              padding: EdgeInsets.all(8),
              child: Text('@Copyright 2024 - Paulo Vinícius Moreira Dutra',
                  style: AppTextStyles.smallText))
        ],
      ),
    ));
  }
}
