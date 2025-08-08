import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/prompt_builder.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/domain/entities/griot_interaction.dart';

class BuildPrompt extends UseCaseWithParams<String, BuildPromptParams> {
  @override
  ResultFuture<String> call(BuildPromptParams params) async {
    final result = PromptBuilder.buildPrompt(input: params.input, role: params.role, recent: params.recent);

    return Right(result);
  }
}

class BuildPromptParams extends Equatable {
  const BuildPromptParams({
    required this.input,
    required this.role,
    required this.recent,
  });

  final String input;
  final String role;
  final List<GriotInteraction> recent;
  @override
  List<Object?> get props => [input, role];
}
