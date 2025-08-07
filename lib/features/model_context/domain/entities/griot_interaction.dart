import 'package:equatable/equatable.dart';

class GriotInteraction extends Equatable {
  const GriotInteraction({
    required this.timestamp,
    required this.userInput,
    required this.griotResponse,
  });

  final DateTime timestamp;
  final String userInput;
  final String griotResponse;

  @override
  List<Object?> get props => [timestamp, userInput, griotResponse];
}
