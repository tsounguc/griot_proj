import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/user_input/domain/repositories/user_input_repository.dart';

class ListenForWakeWord extends UseCaseWithParams<void, Function> {
  const ListenForWakeWord(this.repository);

  final UserInputRepository repository;

  @override
  ResultFuture<void> call(Function params) => repository.listenForWakeWord(params);
}
