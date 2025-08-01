import 'package:griot_proj/core/utils/type_defs.dart';

abstract class UserInputRepository {
  ResultVoid listenForWakeWord(Function onWakeWordDetected);
  ResultFuture<String?> listenToSpeech();
}
