// bin/darttoolx.dart
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:darttoolx/commands/commands.dart';
import 'package:darttoolx/core/config_manager.dart';
import 'package:darttoolx/core/version.dart';

void main(List<String> arguments) async {
  // Initialize config manager
  final configManager = ConfigManager();
  await configManager.initialize();
  
  // Show welcome message on first run
  if (arguments.isEmpty) {
    showWelcomeMessage();
    exit(0);
  }

  final runner = CommandRunner('darttoolx', 'Flutter App Generator CLI')
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

void showWelcomeMessage() {
  print('');
  print('╔════════════════════════════════════════════════════════════╗');
  print('║                                                            ║');
  print('║                    FLUTTER APP GENERATOR                   ║');
  print('║                                                            ║');
  print('╚════════════════════════════════════════════════════════════╝');
  print('                                                v$cliVersion');
  print('             Created by mahmoud-hafez-eltarqi               ');
  print('');
  print('Thank you for installing Flutter App Generator CLI!');
  print('This tool helps you create Flutter applications with customized');
  print('architecture, state management, and packages.');
  print('');
  print('To get started, try:');
  print('  darttoolx create                           Create a new application with wizard');
  print('  darttoolx create --name my_app             Create app with default settings');
  print('  darttoolx update                           Update CLI and templates');
  print('  darttoolx --help                           Show help information');
  print('');
}