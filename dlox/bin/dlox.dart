import 'dart:io';

import 'package:args/args.dart';
import 'package:dlox/lox.dart';

void main(List<String> arguments) {
  exitCode = 0;

  final parser = ArgParser();
  final results = parser.parse(arguments);
  final filePath = results.rest;

  if (filePath.length > 1) {
    print('Usage: dlox [script]');
    exitCode = 64;
  } else if (filePath.length == 1) {
    runFile(filePath[0]);
  } else {
    runPrompt();
  }
}

void runFile(String filePath) {
  final file = File(filePath);
  final source = file.readAsStringSync();

  Lox.run(source);
}

void runPrompt() {
  // Keep reading and print the user's output until
  // they type Ctrl+D (EOF).
  while (true) {
    stdout.write('> ');
    final input = stdin.readLineSync();
    if (input == null) {
      break;
    }
    Lox.run(input);
  }
}
