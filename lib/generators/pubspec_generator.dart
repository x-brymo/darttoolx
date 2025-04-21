// lib/generators/pubspec_generator.dart
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:darttoolx/models/app_config.dart';

class PubspecGenerator {
  final AppConfig config;
  final String projectPath;

  PubspecGenerator(this.config, this.projectPath);

  Future<void> generate() async {
    final pubspecFile = File(path.join(projectPath, 'pubspec.yaml'));
    await pubspecFile.writeAsString(_generatePubspecContent());
  }

  String _generatePubspecContent() {
    final dependencies = _generateDependencies();
    final devDependencies = _generateDevDependencies();

    return '''
name: ${config.name.toLowerCase().replaceAll(' ', '_')}
description: A new Flutter project generated with FlutterGen CLI.
version: 1.0.0+1

environment:
  sdk: ">=2.17.0 <3.0.0"
  flutter: ">=3.0.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.5
$dependencies

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.1
$devDependencies

flutter:
  uses-material-design: true
''';
  }

  String _generateDependencies() {
    final buffer = StringBuffer();

    // Add state management dependencies
    switch (config.stateManagement) {
      case 'getx':
        buffer.writeln('  get: ^4.6.5');
        break;
      case 'provider':
        buffer.writeln('  provider: ^6.0.5');
        break;
      case 'bloc':
        buffer.writeln('  flutter_bloc: ^8.1.2');
        buffer.writeln('  equatable: ^2.0.5');
        break;
      case 'riverpod':
        buffer.writeln('  flutter_riverpod: ^2.3.0');
        break;
      case 'mobx':
        buffer.writeln('  mobx: ^2.1.4');
        buffer.writeln('  flutter_mobx: ^2.0.6+5');
        break;
    }

    // Add common dependencies
    buffer.writeln('  http: ^0.13.5');
    buffer.writeln('  shared_preferences: ^2.1.0');
    buffer.writeln('  path_provider: ^2.0.14');

    // Add additional packages
    for (final package in config.packages) {
      buffer.writeln('  $package: ^1.0.0');
    }

    return buffer.toString();
  }

  String _generateDevDependencies() {
    final buffer = StringBuffer();

    // Add state management dev dependencies
    switch (config.stateManagement) {
      case 'mobx':
        buffer.writeln('  build_runner: ^2.3.3');
        buffer.writeln('  mobx_codegen: ^2.1.1');
        break;
    }

    return buffer.toString();
  }
}

