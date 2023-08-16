import 'scanner.dart';
import 'token.dart';

class Lox {
  static bool hadError = false;

  static void run(String source) {
    Scanner scanner = Scanner(source);
    List<Token> tokens = scanner.scanTokens();

    // For now, just print the tokens.
    for (Token token in tokens) {
      print(token);
    }
  }

  static void error(int line, String message) {
    _report(line, "", message);
  }

  static void _report(int line, String where, String message) {
    print("[line $line] Error$where: $message");
    hadError = true;
  }
}
