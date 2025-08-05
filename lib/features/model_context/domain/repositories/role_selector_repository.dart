import 'package:griot_proj/core/utils/type_defs.dart';

abstract class RoleSelectorRepository {
  ResultFuture<String> selectRole(String intent, String emotion);
}
