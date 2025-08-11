import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/domain/repositories/context_memory_repository.dart';

class SetCurrentLanguage extends UseCaseWithParams<void, String> {
  SetCurrentLanguage(this.repository);

  final ContextMemoryRepository repository;
  @override
  ResultFuture<void> call(
    String params,
  ) => repository.setCurrentLanguage(params);
}
