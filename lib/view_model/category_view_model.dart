import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/entities.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/view_model/entity_view_modal.dart';
import 'package:flutter_crypto_control/widgets/app_colors.dart';

class CategoryViewModel extends EntityViewModel<Category> {
  String publicId;
  String name;
  TransactionType type;
  Color colorValue;
  bool? archived;
  double? currentBalance;
  String iconName;
  IconData iconData;

  CategoryViewModel({
    required this.publicId,
    required this.name,
    required this.type,
    required this.colorValue,
    required this.iconData,
    required this.iconName,
    this.currentBalance,
    this.archived = false,
  });

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void fromEntity(Category entity) {
    publicId = entity.publicId ?? '';
    name = entity.name;
    type = entity.type;
    colorValue = Color(entity.colorValue);
    archived = entity.archived;
    currentBalance = entity.currentBalance;
    iconName = entity.iconName;
    iconData = AppAvaliableIcons.getIconData(iconName) ?? Icons.help_outline;
  }

  static CategoryViewModel fromEntityToViewModel(Category entity) {
    var iconData = AppAvaliableIcons.getIconDataByName(entity.iconName);

    return CategoryViewModel(
      publicId: entity.publicId ?? '',
      name: entity.name,
      type: entity.type,
      colorValue: Color(entity.colorValue),
      archived: entity.archived,
      currentBalance: entity.currentBalance,
      iconName: entity.iconName,
      iconData: iconData,
    );
  }

  @override
  void reset() {
    // TODO: implement reset
  }

  @override
  Category toEntity() {
    var iconName = AppAvaliableIcons.getIconName(iconData);

    return Category(
      id: 0,
      publicId: publicId,
      name: name,
      type: type,
      colorValue: colorValue.toARGB32(),
      archived: archived,
      currentBalance: currentBalance,
      iconName: iconName,
    );
  }

  static CategoryViewModel createEmpty() {
    return CategoryViewModel(
      publicId: '',
      name: '',
      type: TransactionType.expense,
      colorValue: Colors.red,
      archived: false,
      currentBalance: 0.0,
      iconData: Icons.money,
      iconName: 'money',
    );
  }
}
