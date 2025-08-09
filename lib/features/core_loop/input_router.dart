import 'package:dartz/dartz.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/core_loop/domain/entities/routed_response.dart';
import 'package:griot_proj/features/model_context/domain/entities/griot_interaction.dart';
import 'package:griot_proj/features/model_context/domain/use_cases/build_prompt.dart';
import 'package:griot_proj/features/model_context/domain/use_cases/get_recent_context_memory.dart';
import 'package:griot_proj/features/model_context/domain/use_cases/select_role.dart';
import 'package:griot_proj/features/reflect/domain/entities/reflect_answer.dart';
import 'package:griot_proj/features/reflect/domain/use_cases/get_gpt_response.dart';
import 'package:griot_proj/features/understand/domain/entities/analyzed_result.dart';

class InputRouter {
  InputRouter({
    required this.selectRole,
    required this.buildPrompt,
    required this.getGPTResponse,
    required this.getRecentContextMemory,
  });

  final SelectRole selectRole;
  final BuildPrompt buildPrompt;
  final GetGPTResponse getGPTResponse;
  final GetRecentContextMemory getRecentContextMemory;

  ResultFuture<RoutedResponse> route(AnalyzedResult input) async {
    // 1. Get Role
    final roleResult = await selectRole(
      SelectRoleParams(
        intent: input.intent,
        emotion: input.emotion,
      ),
    );

    if (roleResult.isLeft()) {
      return Left(
        roleResult.swap().getOrElse(
          () => SelectRoleFailure(
            message: 'RoleSelector: Unknown Failure',
            statusCode: '505',
          ),
        ),
      );
    }

    final role = roleResult.getOrElse(() => '');

    // 2. Recent memory
    final recentEither = await getRecentContextMemory(3);
    final recent = recentEither.fold(
      (_) => <GriotInteraction>[],
      (r) => r,
    );

    // 3. Build Prompt
    final promptResult = await buildPrompt(
      BuildPromptParams(
        input: input.input,
        role: role,
        recent: recent,
      ),
    );

    if (promptResult.isLeft()) {
      return Left(
        promptResult.swap().getOrElse(
          () => BuildPromptFailure(
            message: 'BuildPrompt: Unknown Failure',
            statusCode: '505',
          ),
        ),
      );
    }

    final prompt = promptResult.getOrElse(() => '');

    // 4. Get GPT Response
    final responseResult = await getGPTResponse(prompt);

    if (responseResult.isLeft()) {
      return Left(
        responseResult.swap().getOrElse(
          () => GetResponseFailure(
            message: 'GetGPTResponse: UnknownFailure',
            statusCode: '505',
          ),
        ),
      );
    }

    final answer = responseResult.getOrElse(
      () => const ReflectAnswer(
        text: '',
        meta: {},
      ),
    );

    return Right(
      RoutedResponse(text: answer.text, role: role, meta: answer.meta),
    );
  }
}
