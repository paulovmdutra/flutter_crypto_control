import 'package:flutter_crypto_control/domain/models/entities.dart';
import 'package:flutter_crypto_control/infra/api/api_repository.dart';

void main() async {
  ApiRepository<SubCategory> controller = ApiRepository<SubCategory>(
    endPointBase: "/api/subcategory",
    fromJson: SubCategory.fromMap,
  );

  var result = await controller.getAllAsync();
  print(result.data);
}
