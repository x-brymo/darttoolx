// lib/generators/structure_generator.dart
import 'dart:io';

import 'package:darttoolx/models/app_config.dart';
import 'package:path/path.dart' as path;

class StructureGenerator {
  final AppConfig config;
  final String projectPath;

  StructureGenerator(this.config, this.projectPath);

  Future<void> generate() async {
    // Generate project structure based on pattern
    switch (config.pattern) {
      case 'mvvm':
        await _generateMvvmStructure();
        break;
      case 'clean':
        await _generateCleanArchitectureStructure();
        break;
      case 'mvc':
        await _generateMvcStructure();
        break;
      default:
        await _generateDefaultStructure();
        break;
    }
  }

  Future<void> _generateMvvmStructure() async {
    final structures = [
      'lib/app/views',
      'lib/app/viewmodels',
      'lib/app/models',
      'lib/app/services',
      'lib/app/utils',
      'lib/app/widgets',
      'test/viewmodels',
      'test/services',
    ];

    for (final structure in structures) {
      await Directory(path.join(projectPath, structure)).create(recursive: true);
    }

    // Create a README.md file explaining the structure
    final readmeFile = File(path.join(projectPath, 'README.md'));
    await readmeFile.writeAsString('''
# ${config.name}

A Flutter application using MVVM architecture pattern.

## Project Structure

- **views**: Contains UI components and screens
- **viewmodels**: Contains ViewModels that handle UI logic
- **models**: Contains data models and entities
- **services**: Contains services for external data sources
- **utils**: Contains utility functions and classes
- **widgets**: Contains reusable widgets
''');
  }

  Future<void> _generateCleanArchitectureStructure() async {
    final structures = [
      'lib/domain/entities',
      'lib/domain/repositories',
      'lib/domain/usecases',
      'lib/data/models',
      'lib/data/repositories',
      'lib/data/datasources',
      'lib/presentation/pages',
      'lib/presentation/widgets',
      'lib/presentation/bloc',
      'lib/core/utils',
      'lib/core/errors',
      'lib/core/network',
      'test/domain',
      'test/data',
      'test/presentation',
    ];

    for (final structure in structures) {
      await Directory(path.join(projectPath, structure)).create(recursive: true);
    }

    // Create a README.md file explaining the structure
    final readmeFile = File(path.join(projectPath, 'README.md'));
    await readmeFile.writeAsString('''
# ${config.name}

A Flutter application using Clean Architecture pattern.

## Project Structure

- **domain**: Contains business logic
  - entities: Business objects
  - repositories: Abstract repositories
  - usecases: Business use cases
- **data**: Contains data handling logic
  - models: Data models implementing domain entities
  - repositories: Repository implementations
  - datasources: Remote and local data sources
- **presentation**: Contains UI components
  - pages: Screens
  - widgets: Reusable UI components
  - bloc: State management
- **core**: Contains core functionality
  - utils: Utility functions and classes
  - errors: Error handling
  - network: Network related code
''');
  }

  Future<void> _generateMvcStructure() async {
    final structures = [
      'lib/app/models',
      'lib/app/views',
      'lib/app/controllers',
      'lib/app/utils',
      'lib/app/services',
      'lib/app/widgets',
      'test/models',
      'test/controllers',
      'test/services',
    ];

    for (final structure in structures) {
      await Directory(path.join(projectPath, structure)).create(recursive: true);
    }

    // Create a README.md file explaining the structure
    final readmeFile = File(path.join(projectPath, 'README.md'));
    await readmeFile.writeAsString('''
# ${config.name}

A Flutter application using MVC architecture pattern.

## Project Structure

- **models**: Contains data models
- **views**: Contains UI components and screens
- **controllers**: Contains controllers that handle business logic
- **utils**: Contains utility functions and classes
- **services**: Contains services for external data sources
- **widgets**: Contains reusable widgets
''');
  }

  Future<void> _generateDefaultStructure() async {
    final structures = [
      'lib/screens',
      'lib/models',
      'lib/widgets',
      'lib/services',
      'lib/utils',
      'test/screens',
      'test/models',
      'test/services',
    ];

    for (final structure in structures) {
      await Directory(path.join(projectPath, structure)).create(recursive: true);
    }

    // Create a README.md file explaining the structure
    final readmeFile = File(path.join(projectPath, 'README.md'));
    await readmeFile.writeAsString('''
# ${config.name}

A Flutter application.

## Project Structure

- **screens**: Contains screens/pages
- **models**: Contains data models
- **widgets**: Contains reusable widgets
- **services**: Contains services for external data sources
- **utils**: Contains utility functions and classes
''');
  }


  Future<void> _createDirectory(String path) async {
    final directory = Directory(path);
    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    }
  }
}