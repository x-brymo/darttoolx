// lib/models/app_config.dart
class AppConfig {
  final String name;
  final String template;
  final String stateManagement;
  final String pattern;
  final String flutterVersion;
  final List<String> packages;

  AppConfig({
    required this.name,
    required this.template,
    required this.stateManagement,
    required this.pattern,
    required this.flutterVersion,
    required this.packages,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'template': template,
      'stateManagement': stateManagement,
      'pattern': pattern,
      'flutterVersion': flutterVersion,
      'packages': packages,
    };
  }

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      name: json['name'] as String,
      template: json['template'] as String,
      stateManagement: json['stateManagement'] as String,
      pattern: json['pattern'] as String,
      flutterVersion: json['flutterVersion'] as String,
      packages: (json['packages'] as List).cast<String>(),
    );
  }
}