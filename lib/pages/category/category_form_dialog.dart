import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_stateful_form.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/widgets/color_selector.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class CategoryForm extends GenericStatefulForm<Category> {
  CategoryForm({
    super.key,
    super.entityToEdit,
    super.onActionSubmit,
    super.onBeforeSubmit,
    super.onAfterSubmit,
    super.onSuccess,
    super.onReload,
    super.state,
  });

  @override
  Widget? build(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  State<CategoryForm> createState() => CategoryFormDialogState();
}

class CategoryFormDialogState
    extends GenericStatefulFormState<CategoryForm, Category> {
  late final TextEditingController _nameController;

  ValueNotifier<int> colorValueNotifier = ValueNotifier(Colors.red.toARGB32());
  ValueNotifier<IconData> iconDataNotifier = ValueNotifier(Icons.money_off);
  ValueNotifier<TransactionType> typeNotifier = ValueNotifier(
    TransactionType.expense,
  );

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: widget.entityToEdit?.name ?? '',
    );

    colorValueNotifier = ValueNotifier(
      widget.entityToEdit?.colorValue ?? Colors.red.toARGB32(),
    );

    iconDataNotifier = ValueNotifier(
      widget.entityToEdit?.iconCodePoint ?? Icons.money_off,
    );
  }

  @override
  Future<CommonResult<Category?>?> onBeforeSubmit() async {
    final category = Category(
      id: widget.entityToEdit?.id ?? 0,
      name: _nameController.text,
      type: typeNotifier.value,
      colorValue: colorValueNotifier.value,
      iconCodePoint: iconDataNotifier.value,
      archived: widget.entityToEdit?.archived ?? false,
      iconName:
          AppAvaliableIcons.getIconNameFromData(iconDataNotifier.value) ??
          "help_outline",
    );
    return CommonResult.success(data: category);
  }

  @override
  void dispose() {
    _nameController.dispose();
    colorValueNotifier.dispose();
    iconDataNotifier.dispose();
    super.dispose();
  }

  @override
  Widget? builderContainer(BuildContext context) {
    return Column(children: [_bodyForm(context)]);
  }

  Widget _bodyForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira o nome da categoria';
            }
            return null;
          },
          decoration: const InputDecoration(labelText: 'Nome da Categoria'),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const Text('Tipo:'),
            const Spacer(),
            ValueListenableBuilder<TransactionType?>(
              valueListenable: typeNotifier,
              builder: (context, selectedId, _) {
                return SegmentedButton<TransactionType>(
                  segments: const [
                    ButtonSegment(
                      value: TransactionType.income,
                      label: Text('Receita'),
                    ),
                    ButtonSegment(
                      value: TransactionType.expense,
                      label: Text('Despesa'),
                    ),
                  ],
                  selected: <TransactionType>{typeNotifier.value},
                  onSelectionChanged: (Set<TransactionType> newSelection) {
                    typeNotifier.value = newSelection.first;
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'Selecione uma Cor:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        // --- Seletor de Cor ---
        ColorSelector(
          // Use o valor inicial do ValueNotifier
          initialColorARGB32: colorValueNotifier.value,
          onColorSelected: (value) {
            // Em vez de setState, use o .value do ValueNotifier
            colorValueNotifier.value = value.toARGB32();
          },
        ),
        const SizedBox(height: 15),
        IconSelector(iconDataNotifier: iconDataNotifier),
      ],
    );
  }
}

class IconSelector extends StatelessWidget {
  const IconSelector({
    super.key,
    required ValueNotifier<IconData> iconDataNotifier,
  }) : _iconDataNotifier = iconDataNotifier;

  final ValueNotifier<IconData> _iconDataNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
