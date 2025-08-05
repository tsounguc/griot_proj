import 'package:dartz/dartz.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/domain/use_cases/build_prompt.dart';
import 'package:griot_proj/features/model_context/domain/use_cases/select_role.dart';
import 'package:griot_proj/features/reflect/domain/use_cases/get_gpt_response.dart';
import 'package:griot_proj/features/understand/domain/entities/analyzed_result.dart';

class InputRouter {
  InputRouter({
    required this.selectRole,
    required this.buildPrompt,
    required this.getGPTResponse,
  });

  final SelectRole selectRole;
  final BuildPrompt buildPrompt;
  final GetGPTResponse getGPTResponse;

  ResultFuture<String> route(AnalyzedResult input) async {
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

    // 2. Build Prompt
    final promptResult = await buildPrompt(
      BuildPromptParams(input: input.input, role: role),
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

    // 3. Get GPT Response
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

    return responseResult;
  }
}
