import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/features/model_context/data/models/griot_interaction_model.dart';
import 'package:griot_proj/features/model_context/domain/entities/griot_interaction.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ContextMemoryLocalDataSource {
  Future<void> saveInteraction(GriotInteraction interaction);
  Future<List<GriotInteractionModel>> getRecentInteractions();

  Future<void> setCurrentLanguage(String bcp47);

  Future<String?> getCurrentLanguage();
}

class ContextMemoryLocalDataSourceImpl implements ContextMemoryLocalDataSource {
  ContextMemoryLocalDataSourceImpl(this.prefs);

  final SharedPreferences prefs;

  static const _kLangKey = 'current_language';

  static const String boxName = 'griot_interactions';

  @override
  Future<List<GriotInteractionModel>> getRecentInteractions() async {
    try {
      final box = await Hive.openBox<GriotInteractionModel>(boxName);
      final interactions = box.values.toList();

      // Return the most recent 3 (or less)
      return interactions.reversed.take(3).toList();
    } catch (e) {
      throw GriotInteractionException(
        message: 'Failed to retrieve interactions: $e',
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> saveInteraction(GriotInteraction interaction) async {
    try {
      final box = await Hive.openBox<GriotInteractionModel>(boxName);

      final model = GriotInteractionModel(
        timestamp: interaction.timestamp,
        userInput: interaction.userInput,
        griotResponse: interaction.griotResponse,
      );

      await box.add(model);

      // Keep only the last 3 interactions
      if (box.length > 3) {
        await box.deleteAt(0);
      }
    } catch (e) {
      throw GriotInteractionException(
        message: 'Failed to save interaction: $e',
        statusCode: '505',
      );
    }
  }

  @override
  Future<String?> getCurrentLanguage() async {
    return prefs.getString(_kLangKey);
  }

  @override
  Future<void> setCurrentLanguage(String bcp47) async {
    await prefs.setString(_kLangKey, bcp47);
  }
}
