import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/domain/entities/griot_interaction.dart';
import 'package:griot_proj/features/model_context/domain/repositories/context_memory_repository.dart';

class GetRecentContextMemory extends UseCaseWithParams<List<GriotInteraction>, int> {
  GetRecentContextMemory(this.repository);

  final ContextMemoryRepository repository;
  @override
  ResultFuture<List<GriotInteraction>> call(int params,) => repository.getRecentInteractions(params);
}
