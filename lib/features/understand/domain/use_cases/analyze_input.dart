import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/understand/domain/entities/analyzed_result.dart';
import 'package:griot_proj/features/understand/domain/repositories/understand_repository.dart';

class AnalyzeInput extends UseCaseWithParams<AnalyzedResult, String> {
  AnalyzeInput(this.repository);

  final UnderstandRepository repository;

  @override
  ResultFuture<AnalyzedResult> call(String params) => repository.analyze(params);
}
