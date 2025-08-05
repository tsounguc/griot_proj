import 'package:equatable/equatable.dart';
import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/reflect/domain/repositories/reflect_repository.dart';

class GetGPTResponse extends UseCaseWithParams<String, String> {
  GetGPTResponse(this.repository);

  final ReflectRepository repository;

  @override
  ResultFuture<String> call(String params) => repository.getResponse(params);
}
