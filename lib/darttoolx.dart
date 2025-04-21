// Main CLI entry point
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:darttoolx/commands/commands.dart';

void main(List<String> arguments) async {
  final runner = CommandRunner('fluttergen', 'Flutter App Generator CLI')
    ..addCommand(CreateCommand())
    ..addCommand(UpdateCommand())
    ..addCommand(AnalyzeCommand())
    ..addCommand(GenerateCommand());

  try {
    await runner.run(arguments);
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}