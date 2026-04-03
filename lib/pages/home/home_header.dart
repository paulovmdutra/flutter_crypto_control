import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class HomeHeader extends StatelessWidget {
  final Map<String, String> images = {"logo": 'assets/images/logo.png'};

  HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0), //EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: const Center(
                  child: Text(
                    'Home Header',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 120,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Profile Image.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: SearchField())],
          ),
        ],
      ),
    );
  }
}
