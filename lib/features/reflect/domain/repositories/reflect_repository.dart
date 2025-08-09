import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/reflect/domain/entities/reflect_answer.dart';

abstract class ReflectRepository {
  ResultFuture<ReflectAnswer> getResponse(String prompt);
}
