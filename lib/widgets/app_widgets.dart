import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStatelessWidget extends StatelessWidget {
  const AppStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

abstract class AppStatefulWidget extends ConsumerWidget{
  const AppStatefulWidget({super.key});
}
