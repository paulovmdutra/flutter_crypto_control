// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';
import 'package:flutter_crypto_control/pages/app/apps.dart';


class SearchBaseState<T extends StatefulWidget, E extends Entity<E>>
    extends State<T> {
  bool isLoading = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  IRepository? repository;

  ListModel<E> itemProvider = ListModel(items: List.empty());

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> filter(String value) async {
    if (value.isEmpty) {
      setState(() {
        isLoading = false;
        itemProvider.init();
      });
      return;
    }
    setState(() {
      isLoading = true;
    });

    //await Future.delayed(const Duration(milliseconds: 100)); // Simula latência
    await itemProvider.filter(value);

    setState(() {
      isLoading = false;
    });
  }

  void _clearList() {
    setState(() {
      itemProvider.clear();
    });
  }
}
