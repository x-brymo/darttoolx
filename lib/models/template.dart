// lib/models/template.dart
class Template {
  final String id;
  final String name;
  final String description;
  final String type; // full-app, partial, widgets
  final List<String> compatibleStateManagements;
  final List<String> compatiblePatterns;

  Template({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.compatibleStateManagements,
    required this.compatiblePatterns,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'compatibleStateManagements': compatibleStateManagements,
      'compatiblePatterns': compatiblePatterns,
    };
  }

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      compatibleStateManagements: (json['compatibleStateManagements'] as List).cast<String>(),
      compatiblePatterns: (json['compatiblePatterns'] as List).cast<String>(),
    );
  }


  @override
  String toString() {
    return 'Template{id: $id, name: $name, description: $description, type: $type, compatibleStateManagements: $compatibleStateManagements, compatiblePatterns: $compatiblePatterns}';
  }
}