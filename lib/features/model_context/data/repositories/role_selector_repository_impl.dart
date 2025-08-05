import 'package:dartz/dartz.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/data/data_sources/role_selector.dart';
import 'package:griot_proj/features/model_context/domain/repositories/role_selector_repository.dart';

class RoleSelectorRepositoryImpl implements RoleSelectorRepository {
  RoleSelectorRepositoryImpl(this.selector);

  final RoleSelector selector;
  @override
  ResultFuture<String> selectRole(String intent, String emotion) async {
    try {
      final result = await selector.selectRole(intent, emotion);

      return Right(result);
    } on SelectRoleException catch (e) {
      return Left(SelectRoleFailure.fromException(e));
    }
  }
}
