import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/shared/app_system.dart';
import 'package:flutter_crypto_control/shared/view_async.dart';
import 'package:flutter_crypto_control/widgets/error_info_widget.dart';
import 'package:flutter_crypto_control/widgets/waiting.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

abstract class GenericStatefulForm<T> extends StatefulWidget {
  final T? entityToEdit;
  // Variável de estado para controlar o tipo de exibição
  DisplayType selectedFormType = DisplayType.scaffold;
  bool isEditing = false;

  /// Função assíncrona chamada quando o formulário é enviado (submit).
  /// Deve retornar um [CommonResult] indicando o sucesso ou falha da operação.
  /// Pode ser usada, por exemplo, para salvar dados via controller.
  //final ResultActionCallback<T> onActionSubmit;

  Future<CommonResult<T?>?> Function(CommonResult<T?>? data)? onActionSubmit;

  /// Callback opcional chamado imediatamente antes do início do envio do formulário.
  /// Ideal para executar ações como iniciar animações, bloquear a interface, ou limpar mensagens anteriores.
  final FutureVoidCallback? onBeforeSubmit;

  /// Callback opcional chamado após a finalização do envio do formulário,
  /// independentemente de sucesso ou falha. Pode ser usado para reativar a interface,
  /// parar animações ou atualizar o estado da tela.
  final FutureVoidCallback? onAfterSubmit;

  /// Callback opcional chamado após salvar com sucesso.
  final FutureVoidCallback? onSuccess;

  final VoidCallback? onReload;

  // Injetar o estado (dados)
  final ViewAsync<CommonResult<List<T?>?>>? state;

  final List<Widget>? actionsButtons;

  Widget? build(BuildContext context);
  void initState() {}
  void dispose() {}

  GenericStatefulForm({
    super.key,
    this.entityToEdit,
    this.onActionSubmit,
    this.onBeforeSubmit,
    this.onAfterSubmit,
    this.onSuccess,
    this.onReload,
    this.state,
    this.actionsButtons,
    this.selectedFormType = DisplayType.scaffold,
  });

  @override
  State<GenericStatefulForm<T>> createState() => GenericStatefulFormState();
}

class GenericStatefulFormState<TW extends GenericStatefulForm<T>, T>
    extends State<TW> {
  GlobalKey<FormState> formtState = GlobalKey<FormState>();
  late final FocusScopeNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusScopeNode();
    widget.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
    widget.dispose();
  }

  Future<CommonResult<T?>?> onBeforeSubmit() async {
    return CommonResult<T?>.success(data: null);
  }

  Future<void> cancel() async {
    bool? result = await showConfirmDialog(
      context,
      title: "Sair?",
      content: "Deseja sair realmente?",
    );
    if (result!) {
      Navigator.of(context).pop();
    }
  }

  Future<void> submit() async {
    try {
      var formState = formtState.currentState;
      if (formState == null || !formState.validate()) {
        return;
      }

      formState.save();

      CommonResult<T?>? beforeResult = await onBeforeSubmit();

      // ⚡ CHAMA O CALLBACK ANTES DO SUBMIT
      await widget.onBeforeSubmit?.call();

      CommonResult<T?>? result = await _onAction(beforeResult);

      if (!mounted) return;

      showFeedback(result);

    } catch (e) {
      var result = CommonResult.fail(
        error: CommonError.general(),
        message: e.toString(),
      );
      showErrorDialog(result, context);
    }
  }

  Future<void> showFeedback(CommonResult<T?>? result) async {
    if (result == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Nenhum dado retornado')));
      return;
    }

    if (!result.success) {
      showErrorDialog(result, context);
      return;
    }

    await widget.onAfterSubmit?.call();

    await widget.onSuccess?.call();

    if (result.success) {
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Operação realizada com sucesso')),
      );
    }
  }

  Future<CommonResult<T?>?> _onAction(CommonResult<T?>? result) async {
    try {
      if (widget.onActionSubmit == null) {
        return CommonResult.fail(
          message: 'Nenhuma ação definida.',
          error: CommonError.general(message: 'Nenhuma ação definida'),
        );
      }

      return await widget.onActionSubmit?.call(result);
    } catch (e) {
      if (!mounted) {
        return CommonResult.fail(
          message: 'Erro inesperado.',
          error: CommonError.general(message: 'Erro inesperado.'),
        );
      }
      // Em caso de erro inesperado, interrompe o carregamento e exibe mensagem de erro.
      showFeedbackError(e);
      return CommonResult.fail(
        error: CommonError.general(message: e.toString()),
      );
    }
  }

  void showFeedbackError(Object e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Erro ao salvar: ${e.toString()}')));

    // ⚡ CHAMA O CALLBACK DEPOIS, MESMO EM CASO DE ERRO
    widget.onAfterSubmit?.call();
  }

  Widget? builderContainer(BuildContext context) {
    return const Center(
      child: Text(
        'Formulário indisponível - Não usou o método builderContainer',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state == null) {
      return _selectTypeForm(widget.selectedFormType);
    }

    return widget.state!.when(
      loading: () => const WaitingWidget(),
      error: (error, stackTrace) {
        return AppScaffold(
          // Assumindo AppScaffold é o seu Scaffold customizado
          title: widget.isEditing ? 'Editar Item' : 'Novo Item',
          body: ErrorInfoWidget(
            error: ErrorDescription(error.toString()),
            onReload: () {
              widget.onReload?.call();
            },
          ),
        );  
      },     
      
      data: (data) {
        if (data.error != null) {
          final String titleText = widget.isEditing
              ? 'Editar SubCategoria'
              : 'Nova SubCategoria';
          return AppScaffold(
            // Assumindo AppScaffold é o seu Scaffold customizado
            title: titleText,
            body: ErrorInfoWidget(
              error: ErrorDescription(data.error!.message),
              onReload: () {
                widget.onReload?.call();
              },
            ),
          );
        }
        return _selectTypeForm(widget.selectedFormType);
      },
    );
  }

  // **Novo método para selecionar e exibir o tipo de formulário**
  Widget _selectTypeForm(DisplayType type) {
    final String titleText = widget.isEditing
        ? 'Editar SubCategoria'
        : 'Nova SubCategoria';
    final formContent = _buildFormContent();

    switch (type) {
      case DisplayType.scaffold:
        return AppScaffold(
          // Assumindo AppScaffold é o seu Scaffold customizado
          title: titleText,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                formContent, // O conteúdo do seu formulário
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => cancel(),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      onPressed: submit,
                      child: Text(
                        widget.isEditing ? 'Salvar Alterações' : 'Salvar',
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          // Se precisar de botões no scaffold, adicione-os aqui (ex: FloatingActionButton ou um botão no formContent)
        );

      case DisplayType.dialog:
        // O AlertDialog não é um widget da tela principal, ele é exibido com showDialog.
        // O método deve retornar o widget que representa a tela principal com o botão de disparo.
        // O AlertDialog em si será exibido pelo método `_showFormDialog`.
        return Center(
          child: FilledButton(
            onPressed: () => _showFormDialog(titleText, formContent),
            child: const Text('Abrir Formulário em Dialog'),
          ),
        );

      case DisplayType.bottomSheet:
        // O BottomSheet também é exibido por um método.
        return Center(
          child: FilledButton(
            onPressed: () => _showFormBottomSheet(titleText, formContent),
            child: const Text('Abrir Formulário em BottomSheet'),
          ),
        );
    }
  }

  // **Widget central do formulário (o que está dentro do builderContainer)**
  Widget _buildFormContent() {
    return AppForm(
      focusNode: focusNode,
      formKey: formtState,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            builderContainer(context) ??
            const Center(child: Text('Formulário indisponível')),
      ),
    );
  }

  Widget _showFormDialog(String titleText, Widget content) {
    return AlertDialog(
      // Define a largura máxima que o AlertDialog pode ocupar
      constraints: const BoxConstraints(
        maxWidth: 1280.0, // Defina sua largura máxima desejada aqui
      ),
      title: Text(titleText),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: submit,
          child: Text(widget.isEditing ? 'Salvar Alterações' : 'Salvar'),
        ),
      ],
    );
  }

  // **Método para exibir o BottomSheet**
  void _showFormBottomSheet(String titleText, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Importante para formulários que podem ser altos
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            // Ajusta o padding para evitar que o teclado oculte o formulário
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    titleText,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                content, // O conteúdo do seu formulário
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      onPressed: submit,
                      child: Text(
                        widget.isEditing ? 'Salvar Alterações' : 'Salvar',
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
