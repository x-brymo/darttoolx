// lib/cli/wizard.dart
import 'dart:io';
import 'package:dart_console/dart_console.dart';
import 'package:darttoolx/models/app_config.dart';

class CliWizard {
  final console = Console();
  
  Future<AppConfig> startWizard() async {
    _clearScreen();
    _showWelcomeMessage();
    
    final name = await _promptProjectName();
    final template = await _promptTemplate();
    final stateManagement = await _promptStateManagement();
    final pattern = await _promptArchitecturePattern();
    final flutterVersion = await _promptFlutterVersion();
    final packages = await _promptPackages();
    
    _clearScreen();
    _showSummary(name, template, stateManagement, pattern, flutterVersion, packages);
    
    if (!await _confirmGeneration()) {
      print('Operation cancelled. Please run the command again to start over.');
      exit(0);
    }
    
    return AppConfig(
      name: name,
      template: template,
      stateManagement: stateManagement,
      pattern: pattern,
      flutterVersion: flutterVersion,
      packages: packages,
    );
  }
  
  void _clearScreen() {
    console.clearScreen();
    console.resetCursorPosition();
  }
  
  void _showWelcomeMessage() {
    console.setForegroundColor(ConsoleColor.brightCyan);
    console.writeLine('╔════════════════════════════════════════════════════════════╗');
    console.writeLine('║                                                            ║');
    console.writeLine('║                    FLUTTER APP GENERATOR                   ║');
    console.writeLine('║                                                            ║');
    console.writeLine('╚════════════════════════════════════════════════════════════╝');
    console.setForegroundColor(ConsoleColor.brightGreen);
    console.writeLine('             Created by mahmoud-hafez-eltarqi               ');
    console.writeLine('');
    console.resetColorAttributes();
    console.writeLine('This wizard will guide you through creating a new Flutter application');
    console.writeLine('with your preferred architecture and packages.');
    console.writeLine('');
  }
  
  Future<String> _promptProjectName() async {
    console.writeLine('STEP 1: Project Name');
    console.writeLine('-----------------');
    console.write('Enter project name (lowercase with underscores): ');
    final name = stdin.readLineSync()?.trim() ?? '';
    
    if (name.isEmpty || !RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(name)) {
      console.setForegroundColor(ConsoleColor.red);
      console.writeLine('Invalid project name. It must start with a lowercase letter and only contain lowercase letters, numbers, and underscores.');
      console.resetColorAttributes();
      return await _promptProjectName();
    }
    
    return name;
  }
  
  Future<String> _promptTemplate() async {
    console.writeLine('');
    console.writeLine('STEP 2: Application Template');
    console.writeLine('--------------------------');
    
    final templates = [
      {'id': 'full-app', 'name': 'Full Application', 'description': 'Complete app with all features'},
      {'id': 'auth-flow', 'name': 'Authentication Flow', 'description': 'Login, registration, and profile screens'},
      {'id': 'e-commerce', 'name': 'E-Commerce', 'description': 'Product listings, cart, and checkout'},
      {'id': 'social-media', 'name': 'Social Media', 'description': 'Feed, profiles, and messaging'},
      {'id': 'dashboard', 'name': 'Dashboard', 'description': 'Admin dashboard with charts and tables'},
      {'id': 'widgets', 'name': 'Widget Collection', 'description': 'Collection of reusable widgets'},
    ];
    
    for (var i = 0; i < templates.length; i++) {
      console.writeLine('${i + 1}. ${templates[i]['name']} - ${templates[i]['description']}');
    }
    
    console.write('\nSelect template (1-${templates.length}): ');
    final selection = stdin.readLineSync()?.trim() ?? '';
    
    final index = int.tryParse(selection);
    if (index == null || index < 1 || index > templates.length) {
      console.setForegroundColor(ConsoleColor.red);
      console.writeLine('Invalid selection. Please enter a number between 1 and ${templates.length}.');
      console.resetColorAttributes();
      return await _promptTemplate();
    }
    
    return templates[index - 1]['id'] as String;
  }
  
  Future<String> _promptStateManagement() async {
    console.writeLine('');
    console.writeLine('STEP 3: State Management');
    console.writeLine('----------------------');
    
    final stateManagements = [
      {'id': 'provider', 'name': 'Provider', 'description': 'Simple state management using InheritedWidget'},
      {'id': 'getx', 'name': 'GetX', 'description': 'Complete solution for routing and state management'},
      {'id': 'bloc', 'name': 'BLoC', 'description': 'Business Logic Component pattern with streams'},
      {'id': 'riverpod', 'name': 'Riverpod', 'description': 'Provider but improved with more features'},
      {'id': 'mobx', 'name': 'MobX', 'description': 'Simple, scalable state management with observables'},
    ];
    
    for (var i = 0; i < stateManagements.length; i++) {
      console.writeLine('${i + 1}. ${stateManagements[i]['name']} - ${stateManagements[i]['description']}');
    }
    
    console.write('\nSelect state management (1-${stateManagements.length}): ');
    final selection = stdin.readLineSync()?.trim() ?? '';
    
    final index = int.tryParse(selection);
    if (index == null || index < 1 || index > stateManagements.length) {
      console.setForegroundColor(ConsoleColor.red);
      console.writeLine('Invalid selection. Please enter a number between 1 and ${stateManagements.length}.');
      console.resetColorAttributes();
      return await _promptStateManagement();
    }
    
    return stateManagements[index - 1]['id'] as String;
  }
  
  Future<String> _promptArchitecturePattern() async {
    console.writeLine('');
    console.writeLine('STEP 4: Architecture Pattern');
    console.writeLine('--------------------------');
    
    final patterns = [
      {'id': 'mvvm', 'name': 'MVVM', 'description': 'Model-View-ViewModel'},
      {'id': 'clean', 'name': 'Clean Architecture', 'description': 'Domain-driven design with layers'},
      {'id': 'mvc', 'name': 'MVC', 'description': 'Model-View-Controller'},
      {'id': 'default', 'name': 'Default', 'description': 'Simple structure without specific pattern'},
    ];
    
    for (var i = 0; i < patterns.length; i++) {
      console.writeLine('${i + 1}. ${patterns[i]['name']} - ${patterns[i]['description']}');
    }
    
    console.write('\nSelect architecture pattern (1-${patterns.length}): ');
    final selection = stdin.readLineSync()?.trim() ?? '';
    
    final index = int.tryParse(selection);
    if (index == null || index < 1 || index > patterns.length) {
      console.setForegroundColor(ConsoleColor.red);
      console.writeLine('Invalid selection. Please enter a number between 1 and ${patterns.length}.');
      console.resetColorAttributes();
      return await _promptArchitecturePattern();
    }
    
    return patterns[index - 1]['id'] as String;
  }
  
 Future<String> _promptFlutterVersion() async {
  console.writeLine('');
  console.writeLine('STEP 5: Flutter SDK Version');
  console.writeLine('-------------------------');

  final versions = [
    {'id': 'latest', 'name': 'Latest Stable'},
    {'id': '3.19.0', 'name': 'Flutter 3.19.0'},
    {'id': '3.16.0', 'name': 'Flutter 3.16.0'},
    {'id': '3.13.0', 'name': 'Flutter 3.13.0'},
    {'id': 'custom', 'name': 'Custom version'},
  ];

  for (var i = 0; i < versions.length; i++) {
    console.writeLine('${i + 1}. ${versions[i]['name']}');
  }

  console.write('\nSelect Flutter version (1-${versions.length}): ');
  final selection = stdin.readLineSync()?.trim() ?? '';

  final index = int.tryParse(selection);
  if (index == null || index < 1 || index > versions.length) {
    console.setForegroundColor(ConsoleColor.red);
    console.writeLine('Invalid selection. Please enter a number between 1 and ${versions.length}.');
    console.resetColorAttributes();
    return await _promptFlutterVersion();
  }

  String selectedVersion;
  if (versions[index - 1]['id'] == 'custom') {
    console.write('\nEnter custom Flutter version (e.g. 3.10.0): ');
    final customVersion = stdin.readLineSync()?.trim() ?? '';

    if (customVersion.isEmpty || !RegExp(r'^\d+\.\d+\.\d+\$').hasMatch(customVersion)) {
      console.setForegroundColor(ConsoleColor.red);
      console.writeLine('Invalid version format. Please use the format: X.Y.Z');
      console.resetColorAttributes();
      return await _promptFlutterVersion();
    }
    selectedVersion = customVersion;
  } else if (versions[index - 1]['id'] == 'latest') {
    selectedVersion = 'stable';
  } else {
    selectedVersion = versions[index - 1]['id']!;
  }

  await _installFlutterVersion(selectedVersion);

  return selectedVersion;
}

Future<void> _installFlutterVersion(String version) async {
  console.writeLine('\n🔧 Installing Flutter version $version using FVM...');

  try {
    final installResult = await Process.run('fvm', ['install', version]);
    stdout.write(installResult.stdout);
    stderr.write(installResult.stderr);

    final useResult = await Process.run('fvm', ['use', version]);
    stdout.write(useResult.stdout);
    stderr.write(useResult.stderr);

    console.setForegroundColor(ConsoleColor.green);
    console.writeLine('✅ Flutter $version is installed and set using FVM.');
  } catch (e) {
    console.setForegroundColor(ConsoleColor.red);
    console.writeLine('❌ Failed to install Flutter version $version: \$e');
  } finally {
    console.resetColorAttributes();
  }
}

  
  Future<List<String>> _promptPackages() async {
    console.writeLine('');
    console.writeLine('STEP 6: Additional Packages');
    console.writeLine('-------------------------');
    
    final packageCategories = [
      {
        'name': 'UI Packages',
        'packages': [
          {'id': 'flutter_screenutil', 'name': 'flutter_screenutil', 'description': 'Responsive UI'},
          {'id': 'cached_network_image', 'name': 'cached_network_image', 'description': 'Image caching'},
          {'id': 'flutter_svg', 'name': 'flutter_svg', 'description': 'SVG rendering'},
        ]
      },
      {
        'name': 'Network Packages',
        'packages': [
          {'id': 'dio', 'name': 'dio', 'description': 'HTTP client'},
          {'id': 'connectivity_plus', 'name': 'connectivity_plus', 'description': 'Network connectivity'},
        ]
      },
      {
        'name': 'Utility Packages',
        'packages': [
          {'id': 'intl', 'name': 'intl', 'description': 'Internationalization'},
          {'id': 'shared_preferences', 'name': 'shared_preferences', 'description': 'Key-value storage'},
          {'id': 'path_provider', 'name': 'path_provider', 'description': 'File system access'},
        ]
      }
    ];
    
    final selectedPackages = <String>[];
    
    for (final category in packageCategories) {
      console.writeLine('\n${category['name']}:');
      
      final packages = category['packages'] as List;
      for (var i = 0; i < packages.length; i++) {
        console.writeLine('${i + 1}. ${packages[i]['name']} - ${packages[i]['description']}');
      }
      
      console.write('\nSelect packages (comma-separated numbers, or 0 to skip): ');
      final selection = stdin.readLineSync()?.trim() ?? '0';
      
      if (selection != '0') {
        final selectedIndices = selection.split(',').map((s) => int.tryParse(s.trim())).toList();
        
        for (final index in selectedIndices) {
          if (index != null && index >= 1 && index <= packages.length) {
            selectedPackages.add(packages[index - 1]['id'] as String);
          }
        }
      }
    }
    
    console.writeLine('\nCustom Packages:');
    console.writeLine('Enter additional packages one per line. Empty line to finish.');
    
    while (true) {
      console.write('Package name: ');
      final packageName = stdin.readLineSync()?.trim() ?? '';
      
      if (packageName.isEmpty) {
        break;
      }
      
      selectedPackages.add(packageName);
    }
    
    return selectedPackages;
  }
  
  void _showSummary(String name, String template, String stateManagement, 
                    String pattern, String flutterVersion, List<String> packages) {
    console.setForegroundColor(ConsoleColor.brightYellow);
    console.writeLine('╔════════════════════════════════════════════════════════════╗');
    console.writeLine('║                      PROJECT SUMMARY                       ║');
    console.writeLine('╚════════════════════════════════════════════════════════════╝');
    console.resetColorAttributes();
    
    console.writeLine('Project Name:       $name');
    console.writeLine('Template:           $template');
    console.writeLine('State Management:   $stateManagement');
    console.writeLine('Architecture:       $pattern');
    console.writeLine('Flutter Version:    $flutterVersion');
    
    if (packages.isNotEmpty) {
      console.writeLine('Packages:           ${packages.join(', ')}');
    } else {
      console.writeLine('Packages:           None');
    }
    
    console.writeLine('');
  }
  
  Future<bool> _confirmGeneration() async {
    console.write('Generate project with these settings? (y/n): ');
    final confirmation = stdin.readLineSync()?.trim().toLowerCase() ?? 'n';
    return confirmation == 'y' || confirmation == 'yes';
  }
}