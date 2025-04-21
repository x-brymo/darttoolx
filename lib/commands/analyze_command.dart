// lib/commands/analyze_command.dart
import 'package:args/command_runner.dart';
import 'package:darttoolx/analyzers/project_analyzer.dart';

class AnalyzeCommand extends Command {
  @override
  final name = 'analyze';
  
  @override
  final description = 'Analyze Flutter project and suggest improvements';

  AnalyzeCommand() {
    argParser
      ..addOption('path', abbr: 'p', help: 'Path to the Flutter project', defaultsTo: '.')
      ..addFlag('dependencies', help: 'Check dependencies health', defaultsTo: true)
      ..addFlag('architecture', help: 'Check architecture issues', defaultsTo: true)
      ..addFlag('performance', help: 'Check performance issues', defaultsTo: true);
  }

  @override
  Future<void> run() async {
    final path = argResults?['path'] as String? ?? '.';
    final checkDeps = argResults?['dependencies'] as bool? ?? true;
    final checkArch = argResults?['architecture'] as bool? ?? true;
    final checkPerf = argResults?['performance'] as bool? ?? true;
    
    final analyzer = ProjectAnalyzer(path);
    
    print('Analyzing Flutter project at $path');
    
    if (checkDeps) {
      print('\nChecking dependencies health...');
      await analyzer.analyzeDependencies();
    }
    
    if (checkArch) {
      print('\nChecking architecture...');
      await analyzer.analyzeArchitecture();
    }
    
    if (checkPerf) {
      print('\nChecking performance...');
      await analyzer.analyzePerformance();
    }
    
    print('\nAnalysis completed!');
  }
}