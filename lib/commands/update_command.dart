// lib/commands/update_command.dart
import 'package:args/command_runner.dart';
import 'package:darttoolx/core/config_manager.dart';
import 'package:darttoolx/core/update_manager.dart';

class UpdateCommand extends Command {
  @override
  final name = 'update';
  
  @override
  final description = 'Update CLI, templates, and rules';

  UpdateCommand() {
    argParser
      ..addFlag('self', help: 'Update the CLI tool itself', defaultsTo: false)
      ..addFlag('templates', help: 'Update available templates', defaultsTo: false)
      ..addFlag('rules', help: 'Update code generation rules', defaultsTo: false)
      ..addFlag('all', help: 'Update everything', defaultsTo: false);
  }

  @override
  Future<void> run() async {
    final updateSelf = argResults?['self'] as bool? ?? false;
    final updateTemplates = argResults?['templates'] as bool? ?? false;
    final updateRules = argResults?['rules'] as bool? ?? false;
    final updateAll = argResults?['all'] as bool? ?? false;
    
    final updateManager = UpdateManager();
    
    if (updateAll || updateSelf) {
      print('Updating CLI tool...');
      await updateManager.updateCli();
    }
    
    if (updateAll || updateTemplates) {
      print('Updating templates...');
      await updateManager.updateTemplates();
    }
    
    if (updateAll || updateRules) {
      print('Updating code generation rules...');
      await updateManager.updateRules();
    }
    
    print('Update completed successfully!');
  }
}