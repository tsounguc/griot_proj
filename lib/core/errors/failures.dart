import 'package:equatable/equatable.dart';
import 'package:griot_proj/core/errors/exceptions.dart';

/// Base class for handling failures across the app.
///
/// [Failure] ensures all errors are **typed**,
/// rather than using raw exceptions.
/// This helps with **better error handling** and **functional programming**.
///
/// - `message`: Human-readable error description.
/// - `statusCode`: Can be an `int` (e.g., HTTP 404) or
/// `String` (e.g., Firebase error codes).
abstract class Failure extends Equatable {
  /// Creates a [Failure] instance.
  ///
  /// - **message**: Describes the error.
  /// - **statusCode**: Can be an integer (e.g., HTTP error codes) or
  /// a string (e.g., Firebase error codes).
  Failure({required this.message, required this.statusCode})
    : assert(statusCode is String || statusCode is int, 'StatusCode cannot be a ${statusCode.runtimeType}');

  /// The error message (human-readable).
  final String message;

  /// Error code, which may be an `int` (for HTTP errors)
  /// or `String` (Firebase errors).
  final dynamic statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// **Base class for all user input failures.**
///
/// This allows us to have specific failure types.
abstract class UserInputFailure extends Failure {
  UserInputFailure({required super.message, required super.statusCode});
}

class WakeWordFailure extends UserInputFailure {
  WakeWordFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [WakeWordException] into a [WakeWordFailure].
  WakeWordFailure.fromException(WakeWordException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

class SpeechFailure extends UserInputFailure {
  SpeechFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [SpeechException] into a [SpeechFailure].
  SpeechFailure.fromException(SpeechException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

/// **Base class for all voice responder failures.**
///
/// This allows us to have specific failure types.
abstract class VoiceResponderFailure extends Failure {
  VoiceResponderFailure({
    required super.message,
    required super.statusCode,
  });
}

class SpeakResponseFailure extends VoiceResponderFailure {
  SpeakResponseFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [SpeakResponseException] into a [SpeakResponseFailure].
  SpeakResponseFailure.fromException(SpeakResponseException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

/// **Base class for all understand failures.**
///
/// This allows us to have specific failure types.
abstract class UnderstandFailure extends Failure {
  UnderstandFailure({
    required super.message,
    required super.statusCode,
  });
}

class AnalyzeFailure extends UnderstandFailure {
  AnalyzeFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [AnalyzeException] into a [AnalyzeFailure].
  AnalyzeFailure.fromException(AnalyzeException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

/// **Base class for all reflect failures.**
///
/// This allows us to have specific failure types.
abstract class ReflectFailure extends Failure {
  ReflectFailure({
    required super.message,
    required super.statusCode,
  });
}

class GetResponseFailure extends ReflectFailure {
  GetResponseFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [GetResponseException] into a [GetResponseFailure].
  GetResponseFailure.fromException(GetResponseException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

/// **Base class for all model context failures.**
///
/// This allows us to have specific failure types.
abstract class ModelContextFailure extends Failure {
  ModelContextFailure({
    required super.message,
    required super.statusCode,
  });
}

class SelectRoleFailure extends ModelContextFailure {
  SelectRoleFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [SelectRoleException] into a [SelectRoleFailure].
  SelectRoleFailure.fromException(SelectRoleException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

class BuildPromptFailure extends ModelContextFailure {
  BuildPromptFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [BuildPromptException] into a [BuildPromptFailure].
  BuildPromptFailure.fromException(SelectRoleException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

class GriotInteractionFailure extends ModelContextFailure {
  GriotInteractionFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [GriotInteractionException] into a [GriotInteractionFailure].
  GriotInteractionFailure.fromException(GriotInteractionException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}
