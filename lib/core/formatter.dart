part of 'core.dart';

/// Generate formatter class
class FormatterClassGenerator {
  static Future<void> generate(projectName) async {
    print("🛠️ Generating formatter class...");

    Directory('$projectName/lib/core/util').createSync(recursive: true);
    final formatterDirectory = File('$projectName/lib/core/util/formatter.dart');

    formatterDirectory.writeAsStringSync(
      """
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
     
class Formatters {
  static MaskTextInputFormatter phoneFormatter(String? mask) => MaskTextInputFormatter(
        mask: mask ?? '##-###-##-##',
        filter: {'#': RegExp(r'[\+0-9]')},
        type: MaskAutoCompletionType.lazy,
      );

  static final cardNumberFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
  static final cardExpirationDateFormatter =
      MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
  static final cvvFormatter =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
}
      """,
    );
    print("Done ✅");
  }
}
