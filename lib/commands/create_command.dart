// lib/commands/create_command.dart
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:args/command_runner.dart';
import 'package:darttoolx/cli/wizard.dart';
import 'package:darttoolx/core/config_manager.dart';
import 'package:darttoolx/generators/app_generator.dart';
import 'package:darttoolx/models/app_config.dart';

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
          help: 'Additional packages to include (comma separated)')
      ..addFlag('interactive', 
          abbr: 'i', 
          help: 'Use interactive wizard for setup', 
          defaultsTo: true);
  }

  @override
  Future<void> run() async {
    late AppConfig appConfig;
    
    final useWizard = argResults?['interactive'] as bool? ?? true;
    
    // Use the wizard if in interactive mode
    if (useWizard) {
      final wizard = CliWizard();
      appConfig = await wizard.startWizard();
    } else {
      // Use command line arguments
      final name = argResults?['name'] as String?;
      if (name == null || name.isEmpty) {
        usageException('Application name is required in non-interactive mode');
        
      }
      
      appConfig = AppConfig(
        name: name,
        template: argResults?['template'] as String? ?? 'full-app',
        stateManagement: argResults?['state'] as String? ?? 'provider',
        pattern: argResults?['pattern'] as String? ?? 'mvvm',
        flutterVersion: argResults?['flutter-version'] as String? ?? 'latest',
        packages: argResults?['packages'] as List<String>? ?? [],
      );
    }

    final generator = AppGenerator(appConfig);
    
    // Show progress with steps
    print('\n\nCreating Flutter application: ${appConfig.name}');
    
    print('\nStep 1/5: Setting up project structure...');
    await generator.structureGenerator.generate();
    
    print('\nStep 2/5: Configuring state management...');
    await generator.stateGenerator.generate();
    
    print('\nStep 3/5: Creating pubspec.yaml...');
    await generator.pubspecGenerator.generate();
    
    print('\nStep 4/5: Initializing Flutter project...');
    await _runFlutterCreate(generator.projectPath);
    
    print('\nStep 5/5: Applying template customizations...');
    await generator.applyTemplateCustomizations();
    
    print('\n✓ Application created successfully!');
    print('\nNext steps:');
    print('  1. cd ${appConfig.name}');
    print('  2. flutter pub get');
    print('  3. flutter run');
  }
  
  Future<void> _runFlutterCreate(String projectPath) async {
    try {
      final result = await Process.run('flutter', ['create', '--project-name', path.basename(projectPath), '--skip-name-checks', '--org', 'com.example', '.'], 
        workingDirectory: projectPath);
      
      if (result.exitCode != 0) {
        print('Warning: Flutter create command failed. You may need to run it manually.');
        print('Error: ${result.stderr}');
      }
    } catch (e) {
      print('Error running flutter create: $e');
      print('You may need to run it manually after CLI completes.');
    }
  }
}