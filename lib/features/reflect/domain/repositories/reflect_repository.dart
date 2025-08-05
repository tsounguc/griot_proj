import 'package:griot_proj/core/utils/type_defs.dart';

abstract class ReflectRepository {
  ResultFuture<String> getResponse(String prompt);
}
