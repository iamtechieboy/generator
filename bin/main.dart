import 'package:args/args.dart';
import 'package:generator/feature/feature_generator.dart';
import 'package:generator/main/service_locator_modifier.dart';
import 'package:generator/package_generator.dart';
import 'package:generator/package_name_finder.dart';

Future<void> main(List<String> arguments) async {
  /// Print the welcome message
  // print('🚀 Hello and I am a Flutter project generator!\n'
  //     '✈️ Now you can create a Flutter project in seconds!');

  /// Generate a package generator
  PackageGenerator packageGenerator = PackageGenerator();

  /// Generate a parser to handle the commands
  /// it works like this
  /// .exe file name and then *commands
  final parser = ArgParser()
    ..addCommand('project')
    ..addCommand('feature');
  // ..addOption('project_name', abbr: 'n', help: 'The name of the project', defaultsTo: 'my_flutter_project');

  final argResults = parser.parse(arguments);

  if (argResults.command == null) {
    print('🥱 No command provided.');
    return;
  }

  switch (argResults.command!.name) {
    case 'project':
      {
        packageGenerator.consoleInteraction();
      }
      break;
    case 'feature':
      {
        var projectName = await PackageNameFinder.findPackageName();
        await FeatureGenerator.generate(projectName, isAdditional: true);
      }
      break;
    default:
      print('Unknown command: ${argResults.command!.name}');
  }
}
