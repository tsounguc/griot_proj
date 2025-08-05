import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/prompt_builder.dart';
import 'package:griot_proj/core/utils/type_defs.dart';

class BuildPrompt extends UseCaseWithParams<String, BuildPromptParams> {
  @override
  ResultFuture<String> call(BuildPromptParams params) async {
    final result = PromptBuilder.buildPrompt(
      params.input,
      params.role,
    );

    return Right(result);
  }
}

class BuildPromptParams extends Equatable {
  const BuildPromptParams({
    required this.input,
    required this.role,
  });

  final String input;
  final String role;

  @override
  List<Object?> get props => [input, role];
}
