// lib/commands/generate_command.dart
import 'package:args/command_runner.dart';
import 'package:darttoolx/generators/code_generator.dart';

class GenerateCommand extends Command {
  @override
  final name = 'generate';
  
  @override
  final description = 'Generate code for specific features or components';

  GenerateCommand() {
    argParser
      ..addOption('type', 
          help: 'Type of code to generate',
          allowed: ['screen', 'widget', 'model', 'service', 'repository', 'bloc'])
      ..addOption('name', abbr: 'n', help: 'Name for the generated component')
      ..addOption('path', abbr: 'p', help: 'Output path', defaultsTo: 'lib');
  }

  @override
  Future<void> run() async {
    final type = argResults?['type'] as String?;
    final name = argResults?['name'] as String?;
    final path = argResults?['path'] as String? ?? 'lib';
    
    if (type == null || name == null) {
      usageException('Type and name are required');
      
    }
    
    final generator = CodeGenerator();
    
    print('Generating $type: $name');
    await generator.generate(type, name, path);
    print('Code generated successfully!');
  }
}