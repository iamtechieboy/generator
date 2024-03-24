import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class MainBlocGenerator {
  static Future<void> generate({
    required String projectName,
    required String featureName,
    bool isAdditional = false,
  }) async {
    print("⏳ Start generating bloc...");
    await BlocGenerator.generate(featureName: featureName, projectName: projectName, isAdditional: isAdditional);
    await EventGenerator.generate(featureName: featureName, projectName: projectName, isAdditional: isAdditional);
    await StateGenerator.generate(featureName: featureName, projectName: projectName, isAdditional: isAdditional);
    print("✅ Done generating bloc");
  }
}
