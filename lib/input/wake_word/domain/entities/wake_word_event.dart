class WakeWordEvent {
  const WakeWordEvent({
    required this.detectedWord,
    required this.timestamp,
    this.confidence = 1.0,
  });

  final String detectedWord;
  final DateTime timestamp;
  final double confidence;
}
