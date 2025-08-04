import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/understand/domain/entities/analyzed_result.dart';

abstract class UnderstandingRepository{
  ResultFuture<AnalyzedResult> analyze(String input);
}