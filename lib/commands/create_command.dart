// lib/commands/create_command.dart
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:darttoolx/core/config_manager.dart';
import 'package:darttoolx/cli/wizard.dart';
import 'package:darttoolx/generators/app_generator.dart';
import 'package:darttoolx/models/app_config.dart';
import 'package:path/path.dart' as path;

class CreateCommand extends Command {
  @override
  final name = 'create';
  
  @override
  final description = 'Create a new Flutter application with customizable options';

  CreateCommand() {
    argParser
      ..addOption('name', abbr: 'n', help: 'Name of the application')
      ..addOption('template', abbr: 't', 
          help: 'Template type (full, partial, widgets)',
          allowed: ['full-app', 'auth-flow', 'dashboard', 'e-commerce', 'social-media', 'widgets'])
      ..addOption('state', 
          help: 'State management solution',
          allowed: ['getx', 'provider', 'bloc', 'riverpod', 'mobx'])
      ..addOption('pattern', 
          help: 'Architecture pattern',
          allowed: ['mvvm', 'clean', 'mvc', 'default'])
      ..addOption('flutter-version', help: 'Flutter SDK version')
      ..addMultiOption('packages', 
          abbr: 'p', 
          help: 'Additional packages to include (comma separated)');
  }

  @override
  Future<void> run() async {
    final name = argResults?['name'] as String? ?? '';
    if (name.isEmpty) {
      usageException('Application name is required');
      return;
    }

    final appConfig = AppConfig(
      name: name,
      template: argResults?['template'] as String? ?? 'full-app',
      stateManagement: argResults?['state'] as String? ?? 'provider',
      pattern: argResults?['pattern'] as String? ?? 'mvvm',
      flutterVersion: argResults?['flutter-version'] as String? ?? 'latest',
      packages: argResults?['packages'] as List<String>? ?? [],
    );

    final generator = AppGenerator(appConfig);
    
    print('Creating Flutter application: ${appConfig.name}');
    print('Template: ${appConfig.template}');
    print('State Management: ${appConfig.stateManagement}');
    print('Pattern: ${appConfig.pattern}');
    
    await generator.generate();
    
    print('Application created successfully!');
  }


  @override
  String get invocation => 'fluttergen create [options]';                
  @override
  String get help => 'Create a new Flutter application with customizable options';
}