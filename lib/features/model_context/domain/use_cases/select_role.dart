import 'package:equatable/equatable.dart';
import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/domain/repositories/role_selector_repository.dart';

class SelectRole extends UseCaseWithParams<String, SelectRoleParams> {
  SelectRole(this.repository);

  final RoleSelectorRepository repository;

  @override
  ResultFuture<String> call(
    SelectRoleParams params,
  ) => repository.selectRole(params.intent, params.emotion);
}

class SelectRoleParams extends Equatable {
  const SelectRoleParams({
    required this.intent,
    required this.emotion,
  });

  final String intent;
  final String emotion;
  @override
  List<Object?> get props => [intent, emotion];
}
