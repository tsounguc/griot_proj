import 'package:equatable/equatable.dart';

/// **Base class for all user input-related exceptions.**
abstract class UserInputException extends Equatable implements Exception {
  const UserInputException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// **Exception thrown during wake word errors.**
class WakeWordException extends UserInputException {
  const WakeWordException({
    required super.message,
    required super.statusCode,
  });
}

/// **Exception thrown during user speech errors.**
class SpeechException extends UserInputException {
  const SpeechException({
    required super.message,
    required super.statusCode,
  });
}

/// **Base class for all voice responder exceptions.**
abstract class VoiceResponderException extends Equatable implements Exception {
  const VoiceResponderException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// **Exception thrown during GRIOT speaking errors.**
class SpeakResponseException extends VoiceResponderException {
  const SpeakResponseException({
    required super.message,
    required super.statusCode,
  });
}

/// **Base class for all understanding responder exceptions.**
abstract class UnderstandingException extends Equatable implements Exception {
  const UnderstandingException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// **Exception thrown when analyzing user input.**
class AnalyzeException extends UnderstandingException {
  const AnalyzeException({
    required super.message,
    required super.statusCode,
  });
}

/// **Base class for all reflect exceptions.**
abstract class ReflectException extends Equatable implements Exception {
  const ReflectException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// **Exception thrown when getting GPT reflect response.**
class GetResponseException extends ReflectException {
  const GetResponseException({
    required super.message,
    required super.statusCode,
  });
}

/// **Base class for all model context exceptions.**
abstract class ModelContextException extends Equatable implements Exception {
  const ModelContextException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// **Exception thrown when selecting GRIOT's role.**
class SelectRoleException extends ModelContextException {
  const SelectRoleException({
    required super.message,
    required super.statusCode,
  });
}

/// **Exception thrown when building prompts.**
class BuildPromptException extends ModelContextException {
  const BuildPromptException({
    required super.message,
    required super.statusCode,
  });
}

/// **Exception thrown when saving and retrieving interactions.**
class GriotInteractionException extends ModelContextException {
  const GriotInteractionException({
    required super.message,
    required super.statusCode,
  });
}

/// **Base class for all remember exceptions.**
abstract class RememberException extends Equatable implements Exception {
  const RememberException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// **Exception thrown when saving and retrieving conversation logs.**
class ConversationLogException extends RememberException {
  const ConversationLogException({
    required super.message,
    required super.statusCode,
  });
}
