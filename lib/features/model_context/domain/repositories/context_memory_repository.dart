import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/domain/entities/griot_interaction.dart';

abstract class ContextMemoryRepository {
  ResultVoid saveInteraction(GriotInteraction interaction);

  ResultFuture<List<GriotInteraction>> getRecentInteractions(int limit);
}
