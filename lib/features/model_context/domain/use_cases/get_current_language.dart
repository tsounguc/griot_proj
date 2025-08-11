import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/domain/repositories/context_memory_repository.dart';

class GetCurrentLanguage extends UseCase<String?> {
  GetCurrentLanguage(this.repository);

  final ContextMemoryRepository repository;
  @override
  ResultFuture<String?> call() => repository.getCurrentLanguage();
}
