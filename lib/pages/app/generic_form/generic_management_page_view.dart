import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_container_page.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/shared/view_async.dart';
import 'package:flutter_crypto_control/widgets/app_textstyles.dart';
import 'package:flutter_crypto_control/widgets/error_info_widget.dart';

class GenericManagementPageView<T, M extends GenericModel>
    extends StatelessWidget {
  final VoidCallback onAddCategory;
  final VoidCallback onReload;
  final M viewModel;
  final ViewAsync<CommonResult<List<T?>?>> state;

  Widget? builderContainer(BuildContext context, CommonResult<List<T?>?> data) {
    return null;
  }

  const GenericManagementPageView({
    super.key,
    required this.state,
    required this.viewModel,
    required this.onAddCategory,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorInfoWidget(
        error: ErrorDescription(error.toString()),
        onReload: onReload,
      ),
      data: (items) => _list(context, items),
    );
  }

  Widget _list(BuildContext context, CommonResult<List<T?>?> categories) {
    if (categories.error != null) {
      return ErrorInfoWidget(
        error: ErrorDescription(categories.error!.message),
        onReload: onReload,
      );
    }

    if (viewModel.entities.isEmpty) {
      return Center(
        child: Text(
          "Nenhum Registro Encontrado!",
          style: AppTextStyles.bigText,
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        child: Column(
          children: [
            builderContainer(context, categories) ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Text("Empty");
                        },
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
