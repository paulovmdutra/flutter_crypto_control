import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_stateful_form.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/widgets/app_colors.dart';
import 'package:flutter_crypto_control/widgets/app_textstyles.dart';
import 'package:flutter_crypto_control/widgets/color_selector.dart';
import 'package:flutter_crypto_control/widgets/error_info_widget.dart';

class SubCategoryForm extends GenericStatefulForm<SubCategory> {
  final List<Category?>? listCategories;
  final Category? parentCategory;

  SubCategoryForm({
    super.key,
    super.entityToEdit,
    this.listCategories,
    this.parentCategory,
    super.onActionSubmit,
    super.onBeforeSubmit,
    super.onAfterSubmit,
    super.onSuccess,
    super.state,
  });

  @override
  Widget? build(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  State<SubCategoryForm> createState() => SubCategoryFormDialogState();
}

class SubCategoryFormDialogState
    extends GenericStatefulFormState<SubCategoryForm, SubCategory> {
  late final TextEditingController _nameController;

  ValueNotifier<int> _colorValueNotifier = ValueNotifier(Colors.red.toARGB32());
  ValueNotifier<IconData> _iconDataNotifier = ValueNotifier(Icons.money_off);
  ValueNotifier<String?> _selectedCategoryIdNotifier = ValueNotifier(null);
  String? initialCategoryId;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    isEditing = widget.entityToEdit != null;
    _nameController = TextEditingController(
      text: widget.entityToEdit?.name ?? '',
    );

    _colorValueNotifier = ValueNotifier(
      widget.entityToEdit?.colorValue ?? Colors.red.toARGB32(),
    );

    _iconDataNotifier = ValueNotifier(
      widget.entityToEdit?.iconCodePoint ?? Icons.money_off,
    );

    if (widget.parentCategory != null) {
      // Se veio uma categoria pai forçada (ex: criando sub dentro de cat)
      initialCategoryId = widget.parentCategory!.publicId;
    } else if (isEditing) {
      // Se está editando
      initialCategoryId = widget.entityToEdit!.publicId;
    } else if (widget.listCategories != null &&
        widget.listCategories!.isNotEmpty) {
      // Padrão: Pega o primeiro da lista
      initialCategoryId = widget.listCategories!.first!.publicId;
    }

    _selectedCategoryIdNotifier = ValueNotifier(initialCategoryId);
  }

  @override
  Future<CommonResult<SubCategory?>?> onBeforeSubmit() async {
    if (_selectedCategoryIdNotifier.value == null) {
      return CommonResult.fail(
        error: CommonError.notFound(),
        message: "Selecione uma categoria.",
      );
    }

    // Busca o objeto Categoria completo baseado no ID selecionado
    Category? selectedCategory = widget.listCategories?.firstWhere(
      (c) => c!.publicId == _selectedCategoryIdNotifier.value,
      // Fallback de segurança, embora a validação da UI deva prevenir isso
      orElse: () => Category.createEmpty(),
    );

    if (selectedCategory != null && selectedCategory.publicId!.isEmpty) {
      return CommonResult.fail(
        error: CommonError.notFound(),
        message: "Falha ao encontrar a categoria selecionada.",
      );
    }

    final subCategory = SubCategory(
      id: widget.entityToEdit?.id ?? 0,
      name: _nameController.text,
      colorValue: _colorValueNotifier.value,
      iconCodePoint: _iconDataNotifier.value,
      category: selectedCategory,
      categoryId: selectedCategory!.id,
      currentBalance: widget.entityToEdit?.currentBalance ?? 0,
      archived: widget.entityToEdit?.archived ?? false,
    );
    return CommonResult.success(data: subCategory);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _colorValueNotifier.dispose();
    _iconDataNotifier.dispose();
    _selectedCategoryIdNotifier.dispose();
    super.dispose();
  }

  @override
  Widget? builderContainer(BuildContext context) {
    widget.isEditing = widget.entityToEdit != null;

    final allCategories = widget.listCategories;

    if (isEditing && initialCategoryId == null && allCategories != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: ErrorInfoWidget(
              error: ErrorDescription(
                'A categoria associada a esta subcategoria não está disponível na lista atual. Por favor, selecione uma categoria válida ou verifique se o cadastro da categoria pai foi concluído corretamente.',
              ),
              onReload: () {},
            ),
          ),
        ],
      );
    }

    if (initialCategoryId == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: ErrorInfoWidget(
              error: ErrorDescription(
                'A categoria selecionada para esta subcategoria não está disponível. Por favor, selecione uma categoria válida. Verifique se o cadastro da categoria pai foi concluído corretamente.',
              ),
              onReload: () {},
            ),
          ),
        ],
      );
    }

    if (allCategories!.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Nenhuma categoria disponível. Cadastre uma categoria primeiro.',
              style: AppTextStyles.bigText,
            ),
          ),
        ],
      );
    }

    return Column(children: [_bodyForm(allCategories, context)]);
  }

  Column _bodyForm(List<Category?> categories, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira o nome da subcategoria';
            }
            return null;
          },
          decoration: const InputDecoration(labelText: 'Nome da SubCategoria'),
        ),
        const SizedBox(height: 15),
        // --- Dropdown Categoria  ---
        ValueListenableBuilder<String?>(
          valueListenable: _selectedCategoryIdNotifier,
          builder: (context, selectedId, _) {
            return DropdownButtonFormField<String>(
              initialValue:
                  selectedId, // Vincula explicitamente ao valor do Notifier
              decoration: const InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category!.publicId,
                  child: Row(
                    children: [
                      Icon(
                        category.iconCodePoint,
                        color: Color(category.colorValue),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _selectedCategoryIdNotifier.value = newValue;
                }
              },
              validator: (value) =>
                  value == null ? 'Selecione uma categoria.' : null,
            );
          },
        ),
        const SizedBox(height: 15),
        // --- Seletor de Cor ---
        ColorSelector(
          // Use o valor inicial do ValueNotifier
          initialColorARGB32: _colorValueNotifier.value,
          onColorSelected: (value) {
            // Em vez de setState, use o .value do ValueNotifier
            _colorValueNotifier.value = value.toARGB32();
          },
        ),
        const SizedBox(height: 15),
        // --- Seletor de Ícone ---
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selecione um Ícone:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: _iconDataNotifier,
              builder: (context, value, child) {
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: AppAvaliableIcons.availableIcons
                      .map(
                        (icon) => GestureDetector(
                          onTap: () {
                            // Em vez de setState, use o .value
                            _iconDataNotifier.value = icon;
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: value == icon
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primary.withAlpha(50)
                                  : Colors.transparent,
                              border: Border.all(
                                color: value == icon
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                              ),
                            ),
                            child: Icon(
                              icon,
                              color: value == icon
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
