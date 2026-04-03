import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_container_page.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';
import 'package:flutter_crypto_control/service_locator.dart';

class CategoryPage extends GenericPage {
  const CategoryPage({super.key, required super.title});
  @override
  Widget? build(BuildContext context) {
    var factory = ServiceLocator.instance.get<ICategoryFactory>();
    var main = factory.createContainerMainPage();
    return main;
  }
}
