import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';

abstract class BaseFormState<T extends StatefulWidget, E extends Entity<E>>
    extends State<T> {
  bool isLoading = false;

  Future<void> submitForm();

  @override
  Widget build(BuildContext context);
}
