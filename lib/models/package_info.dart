// lib/models/package_info.dart
class PackageInfo {
  final String name;
  final String latestVersion;
  final String description;
  final List<String> categories; // UI, network, state, etc.
  final Map<String, String> compatibleVersions; // flutter version -> package version

  PackageInfo({
    required this.name,
    required this.latestVersion,
    required this.description,
    required this.categories,
    required this.compatibleVersions,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latestVersion': latestVersion,
      'description': description,
      'categories': categories,
      'compatibleVersions': compatibleVersions,
    };
  }

  factory PackageInfo.fromJson(Map<String, dynamic> json) {
    return PackageInfo(
      name: json['name'] as String,
      latestVersion: json['latestVersion'] as String,
      description: json['description'] as String,
      categories: (json['categories'] as List).cast<String>(),
      compatibleVersions: Map<String, String>.from(json['compatibleVersions'] as Map),
    );
  }


  @override
  String toString() {
    return 'PackageInfo{name: $name, latestVersion: $latestVersion, description: $description, categories: $categories, compatibleVersions: $compatibleVersions}';
  }
}