import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:griot_proj/core/router/app_router.dart';
import 'package:griot_proj/core/services/service_locator.dart';
import 'package:griot_proj/features/model_context/data/models/griot_interaction_model.dart';
import 'package:griot_proj/features/remember/data/models/conversation_log_entry_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(GriotInteractionModelAdapter())
    ..registerAdapter(ConversationLogEntryModelAdapter());

  await setUpServices();
  runApp(const GriotApp());
}

class GriotApp extends StatelessWidget {
  const GriotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
