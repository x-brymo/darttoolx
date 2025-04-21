// lib/generators/app_generator.dart
import 'dart:io';

import 'package:darttoolx/generators/pubspec_generator.dart';
import 'package:darttoolx/generators/state_management_generator.dart';
import 'package:darttoolx/generators/structure_generator.dart';
import 'package:darttoolx/models/app_config.dart';
import 'package:path/path.dart' as path;

class AppGenerator {
  final AppConfig config;
  late final String projectPath;
  late final StructureGenerator structureGenerator;
  late final StateManagementGenerator stateGenerator;
  late final PubspecGenerator pubspecGenerator;

  AppGenerator(this.config) {
    projectPath = path.join(Directory.current.path, config.name);
    structureGenerator = StructureGenerator(config, projectPath);
    stateGenerator = StateManagementGenerator(config, projectPath);
    pubspecGenerator = PubspecGenerator(config, projectPath);
  }

  Future<void> generate() async {
    // Create base directory
    final projectDir = Directory(projectPath);
    if (await projectDir.exists()) {
      throw Exception('Directory ${config.name} already exists');
    }
    await projectDir.create();

    // Generate project structure based on template and pattern
    print('Generating project structure...');
    await structureGenerator.generate();

    // Generate state management setup
    print('Setting up state management...');
    await stateGenerator.generate();

    // Generate pubspec with dependencies
    print('Creating pubspec.yaml...');
    await pubspecGenerator.generate();

    // Run flutter create to initialize the project
    print('Initializing Flutter project...');
    await _initializeFlutterProject();

    // Apply additional customizations based on template
    print('Applying template customizations...');
    await applyTemplateCustomizations();

    print('Project generated successfully at: $projectPath');
  }

  Future<void> _initializeFlutterProject() async {
    // Simulate running flutter create command
    await Future.delayed(Duration(seconds: 2));
    
    // Create default main.dart file
    final mainFile = File(path.join(projectPath, 'lib', 'main.dart'));
    if (!(await mainFile.parent.exists())) {
      await mainFile.parent.create(recursive: true);
    }
    
    await mainFile.writeAsString(_generateMainDartContent());
  }

  Future<void> applyTemplateCustomizations() async {
    // Apply template-specific customizations
    switch (config.template) {
      case 'full-app':
        await _applyFullAppTemplate();
        break;
      case 'auth-flow':
        await _applyAuthFlowTemplate();
        break;
      case 'e-commerce':
        await _applyECommerceTemplate();
        break;
      // Add more template customizations as needed
      default:
        break;
    }
  }

  Future<void> _applyFullAppTemplate() async {
    // Simulate applying full app template
    await Future.delayed(Duration(seconds: 1));
    print('Applied full app template');
  }

  Future<void> _applyAuthFlowTemplate() async {
    // Simulate applying auth flow template
    await Future.delayed(Duration(seconds: 1));
    print('Applied authentication flow template');
  }

  Future<void> _applyECommerceTemplate() async {
    // Simulate applying e-commerce template
    await Future.delayed(Duration(seconds: 1));
    print('Applied e-commerce template');
  }

  String _generateMainDartContent() {
    // Generate main.dart based on state management choice
    switch (config.stateManagement) {
      case 'getx':
        return '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "${config.name}",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    ),
  );
}
''';
      case 'provider':
        return '''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/providers/app_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "${config.name}",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${config.name}")),
      body: Center(child: Text("Welcome to ${config.name}")),
    );
  }
}
''';
      default:
        return '''
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "${config.name}",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${config.name}")),
      body: Center(child: Text("Welcome to ${config.name}")),
    );
  }
}
''';
    }
  }
}