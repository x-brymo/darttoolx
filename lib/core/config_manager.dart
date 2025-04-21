// lib/core/config_manager.dart
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

class ConfigManager {
  static final ConfigManager _instance = ConfigManager._internal();
  factory ConfigManager() => _instance;
  ConfigManager._internal();

  late final Directory _configDir;
  late final File _configFile;
  late final Map<String, dynamic> _config;

  Future<void> initialize() async {
    final homeDir = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
    _configDir = Directory(path.join(homeDir!, '.darttoolx'));
    _configFile = File(path.join(_configDir.path, 'config.json'));

    if (!await _configDir.exists()) {
      await _configDir.create(recursive: true);
    }

    if (!await _configFile.exists()) {
      await _createDefaultConfig();
    }

    _config = jsonDecode(await _configFile.readAsString());
  }

  Future<void> _createDefaultConfig() async {
    final defaultConfig = {
      'cli_version': '1.0.0',
      'templates_version': '1.0.0',
      'rules_version': '1.0.0',
      'templates_path': path.join(_configDir.path, 'templates'),
      'cache_path': path.join(_configDir.path, 'cache'),
      'last_update_check': DateTime.now().toIso8601String(),
    };

    await _configFile.writeAsString(jsonEncode(defaultConfig));
    
    // Create necessary directories
    await Directory(defaultConfig['templates_path']!).create(recursive: true);
    await Directory(defaultConfig['cache_path']!).create(recursive: true);
  }

  String get templatesPath => _config['templates_path'];
  String get cachePath => _config['cache_path'];
  String get cliVersion => _config['cli_version'];

  Future<void> updateConfig(Map<String, dynamic> updates) async {
    _config.addAll(updates);
    await _configFile.writeAsString(jsonEncode(_config));
  }
}