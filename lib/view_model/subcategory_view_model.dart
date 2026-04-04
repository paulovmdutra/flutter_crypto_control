import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/entities.dart';
import 'package:flutter_crypto_control/view_model/category_view_model.dart';
import 'package:flutter_crypto_control/view_model/entity_view_modal.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class SubCategoryViewModel extends EntityViewModel<SubCategory> {
  String publicId;
  String name;
  Color colorValue;
  IconData iconData;
  double? currentBalance;
  bool? archived;
  CategoryViewModel? category;

  SubCategoryViewModel({
    required this.publicId,
    required this.name,
    required this.colorValue,
    required this.iconData,
    this.currentBalance,
    this.category,
    this.archived,
  });

  String? get categoryName {
    if (category != null) {
      return category?.name;
    }
    return '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void fromEntity(SubCategory entity) {
    publicId = entity.publicId ?? '';
    name = entity.name;
    colorValue = Color(entity.colorValue);
    archived = entity.archived;
    currentBalance = entity.currentBalance;
    category = entity.category != null
        ? CategoryViewModel.fromEntityToViewModel(entity.category!)
        : null;
    iconData =
        AppAvaliableIcons.getIconData(entity.iconName) ?? Icons.help_outline;
  }

  @override
  void reset() {
    // TODO: implement reset
  }

  @override
  SubCategory toEntity() {
    return SubCategory(
      publicId: publicId,
      categoryId: 0,
      name: name,
      colorValue: colorValue.toARGB32(),
      currentBalance: currentBalance,
      archived: archived,
      category: category?.toEntity(),
      iconName: AppAvaliableIcons.getIconNameFromData(iconData) ?? "unknown",
    );
  }
}
