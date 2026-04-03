import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/pages/home/transaction_page.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionFormDialog extends ConsumerStatefulWidget {
  final Transaction? transactionToEdit;
  const TransactionFormDialog({super.key, this.transactionToEdit});

  @override
  ConsumerState<TransactionFormDialog> createState() =>
      _TransactionFormDialogState();
}

class _TransactionFormDialogState extends ConsumerState<TransactionFormDialog> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  TransactionType _type = TransactionType.expense;
  DateTime _selectedDate = DateTime.now();
  int? _selectedCategoryId;
  Category? _category;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Inicializa campos se estiver no modo de edição
    if (widget.transactionToEdit != null) {
      final tx = widget.transactionToEdit!;
      _descriptionController.text = tx.description;
      _amountController.text = tx.amount.toStringAsFixed(2);
      _notesController.text = tx.notes ?? '';
      _type = tx.type;
      _selectedDate = tx.date;
      _selectedCategoryId = tx.categoryId;
    } else {
      // Garante um valor inicial para o tipo (Despesa é o padrão)
      _type = TransactionType.expense;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || _selectedCategoryId == null) {
      return;
    }

    final amount =
        double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0.0;

    final newTransaction = Transaction(
      id: widget.transactionToEdit?.id ?? 0,
      accountId: widget.transactionToEdit?.accountId ?? 0, // Usando mock acc1
      description: _descriptionController.text,
      amount: amount,
      date: _selectedDate,
      type: _type,
      categoryId: _selectedCategoryId!,
      category: _category,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
    );

    final controller = ref.read(financialControllerProvider.notifier);

    if (widget.transactionToEdit != null) {
      controller.updateTransaction(newTransaction);
    } else {
      controller.addTransaction(newTransaction);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Operação realizada com sucesso!')),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transactionToEdit != null;

    // Observa as categorias cadastradas
    final allCategories = ref.watch(categoryControllerProvider);

    // Filtra as categorias pelo tipo de transação selecionado
    final filteredCategories = allCategories.value!.data!
        .where((c) => c!.type == _type)
        .toList();

    // Se o ID da categoria selecionada não estiver mais na lista filtrada, reseta
    if (_selectedCategoryId != null &&
        filteredCategories.every((c) => c!.id != _selectedCategoryId) &&
        filteredCategories.isNotEmpty) {
      // Automaticamente seleciona a primeira categoria do novo tipo, se houver
      _selectedCategoryId = filteredCategories.first!.id;
    }

    // Se não houver categoria selecionada e a lista filtrada tiver itens, seleciona a primeira
    if (_selectedCategoryId == null && filteredCategories.isNotEmpty) {
      _selectedCategoryId = filteredCategories.first!.id;
    }

    return AlertDialog(
      title: Text(isEditing ? 'Editar Transação' : 'Nova Transação'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) =>
                    value!.isEmpty ? 'Insira uma descrição.' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Insira um valor.';
                  if (double.tryParse(value.replaceAll(',', '.')) == null)
                    return 'Valor inválido.';
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text('Tipo:'),
                  const Spacer(),
                  // SegmentedButton para Tipo de Transação
                  SegmentedButton<TransactionType>(
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
                    selected: <TransactionType>{_type},
                    onSelectionChanged: (Set<TransactionType> newSelection) {
                      setState(() {
                        _type = newSelection.first;
                        _selectedCategoryId =
                            null; // Reseta a categoria ao mudar o tipo
                      });
                    },
                    style: SegmentedButton.styleFrom(
                      selectedForegroundColor: Theme.of(
                        context,
                      ).colorScheme.onPrimary,
                      selectedBackgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Dropdown para Seleção de Categoria
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                initialValue: _selectedCategoryId.toString(),
                items: filteredCategories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category!.id.toString(),
                    child: Row(
                      children: [
                        Icon(
                          category.iconCodePoint,
                          color: category.color,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(category.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategoryId = newValue.toString().isNotEmpty
                        ? int.parse(newValue!)
                        : null;
                    _category = filteredCategories
                        .where((t) => t!.id == _selectedCategoryId)
                        .first;
                  });
                },
                validator: (value) =>
                    value == null ? 'Selecione uma categoria.' : null,
              ),
              const SizedBox(height: 15),

              // Seleção de Data
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Data: ${dateFormatter.format(_selectedDate)}'),
                  TextButton.icon(
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Alterar'),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notas (Opcional)',
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(isEditing ? 'Salvar Alterações' : 'Adicionar'),
        ),
      ],
    );
  }
}
