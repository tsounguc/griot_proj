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
