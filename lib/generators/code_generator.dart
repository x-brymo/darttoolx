// lib/generators/code_generator.dart
import 'dart:io';
import 'package:path/path.dart' as path;

class CodeGenerator {
  Future<void> generate(String type, String name, String outputPath) async {
    switch (type) {
      case 'screen':
        await _generateScreen(name, outputPath);
        break;
      case 'widget':
        await _generateWidget(name, outputPath);
        break;
      case 'model':
        await _generateModel(name, outputPath);
        break;
      case 'service':
        await _generateService(name, outputPath);
        break;
      case 'repository':
        await _generateRepository(name, outputPath);
        break;
      case 'bloc':
        await _generateBloc(name, outputPath);
        break;
      default:
        throw Exception('Unknown generation type: $type');
    }
  }

  Future<void> _generateScreen(String name, String outputPath) async {
    final fileName = _formatFileName(name);
    final className = _formatClassName(name);
    final filePath = path.join(outputPath, 'screens', '${fileName}_screen.dart');
    
    // Ensure directory exists
    final directory = Directory(path.dirname(filePath));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    
    final content = '''
import 'package:flutter/material.dart';

class ${className}Screen extends StatelessWidget {
  const ${className}Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$className'),
      ),
      body: Center(
        child: Text('$className Screen'),
      ),
    );
  }
}
''';
    
    final file = File(filePath);
    await file.writeAsString(content);
  }

  Future<void> _generateWidget(String name, String outputPath) async {
    final fileName = _formatFileName(name);
    final className = _formatClassName(name);
    final filePath = path.join(outputPath, 'widgets', '${fileName}_widget.dart');
    
    // Ensure directory exists
    final directory = Directory(path.dirname(filePath));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    
    final content = '''
import 'package:flutter/material.dart';

class ${className}Widget extends StatelessWidget {
  const ${className}Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Text('$className Widget'),
    );
  }
}
''';
    
    final file = File(filePath);
    await file.writeAsString(content);
  }

  Future<void> _generateModel(String name, String outputPath) async {
    final fileName = _formatFileName(name);
    final className = _formatClassName(name);
    final filePath = path.join(outputPath, 'models', '${fileName}_model.dart');
    
    // Ensure directory exists
    final directory = Directory(path.dirname(filePath));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    
    final content = '''
class ${className}Model {
  final int id;
  final String name;

  ${className}Model({
    required this.id,
    required this.name,
  });

  factory ${className}Model.fromJson(Map<String, dynamic> json) {
    return ${className}Model(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
''';
    
    final file = File(filePath);
    await file.writeAsString(content);
  }

  Future<void> _generateService(String name, String outputPath) async {
    final fileName = _formatFileName(name);
    final className = _formatClassName(name);
    final filePath = path.join(outputPath, 'services', '${fileName}_service.dart');
    
    // Ensure directory exists
    final directory = Directory(path.dirname(filePath));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    
    final content = '''
import 'package:http/http.dart' as http;
import 'dart:convert';

class ${className}Service {
  final String baseUrl;

  ${className}Service({this.baseUrl = 'https://api.example.com'});

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('\$baseUrl/data'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
''';
    
    final file = File(filePath);
    await file.writeAsString(content);
  }

  Future<void> _generateRepository(String name, String outputPath) async {
    final fileName = _formatFileName(name);
    final className = _formatClassName(name);
    final filePath = path.join(outputPath, 'repositories', '${fileName}_repository.dart');
    
    // Ensure directory exists
    final directory = Directory(path.dirname(filePath));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    
    final content = '''
abstract class ${className}Repository {
  Future<List<dynamic>> getAll();
  Future<dynamic> getById(int id);
  Future<void> create(dynamic data);
  Future<void> update(int id, dynamic data);
  Future<void> delete(int id);
}

class ${className}RepositoryImpl implements ${className}Repository {
  @override
  Future<List<dynamic>> getAll() async {
    // TODO: Implement getAll
    return [];
  }

  @override
  Future<dynamic> getById(int id) async {
    // TODO: Implement getById
    return null;
  }

  @override
  Future<void> create(dynamic data) async {
    // TODO: Implement create
  }

  @override
  Future<void> update(int id, dynamic data) async {
    // TODO: Implement update
  }

  @override
  Future<void> delete(int id) async {
    // TODO: Implement delete
  }
}
''';
    
    final file = File(filePath);
    await file.writeAsString(content);
  }

  Future<void> _generateBloc(String name, String outputPath) async {
    final fileName = _formatFileName(name);
    final className = _formatClassName(name);
    final dirPath = path.join(outputPath, 'blocs', fileName);
    
    // Ensure directory exists
    final directory = Directory(dirPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    
    // Create event file
    final eventFilePath = path.join(dirPath, '${fileName}_event.dart');
    final eventContent = '''
abstract class ${className}Event {}

class ${className}LoadEvent extends ${className}Event {}

class ${className}AddEvent extends ${className}Event {
  final dynamic data;
  
  ${className}AddEvent(this.data);
}

class ${className}UpdateEvent extends ${className}Event {
  final int id;
  final dynamic data;
  
  ${className}UpdateEvent(this.id, this.data);
}

class ${className}DeleteEvent extends ${className}Event {
  final int id;
  
  ${className}DeleteEvent(this.id);
}
''';
    
    final eventFile = File(eventFilePath);
    await eventFile.writeAsString(eventContent);
    
    // Create state file
    final stateFilePath = path.join(dirPath, '${fileName}_state.dart');
    final stateContent = '''
abstract class ${className}State {}

class ${className}Initial extends ${className}State {}

class ${className}Loading extends ${className}State {}

class ${className}Loaded extends ${className}State {
  final List<dynamic> data;
  
  ${className}Loaded(this.data);
}

class ${className}Error extends ${className}State {
  final String message;
  
  ${className}Error(this.message);
}
''';
    
    final stateFile = File(stateFilePath);
    await stateFile.writeAsString(stateContent);
    
    // Create bloc file
    final blocFilePath = path.join(dirPath, '${fileName}_bloc.dart');
    final blocContent = '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '${fileName}_event.dart';
import '${fileName}_state.dart';

class ${className}Bloc extends Bloc<${className}Event, ${className}State> {
  ${className}Bloc() : super(${className}Initial()) {
    on<${className}LoadEvent>(_onLoad);
    on<${className}AddEvent>(_onAdd);
    on<${className}UpdateEvent>(_onUpdate);
    on<${className}DeleteEvent>(_onDelete);
  }

  Future<void> _onLoad(${className}LoadEvent event, Emitter<${className}State> emit) async {
    emit(${className}Loading());
    try {
      // TODO: Load data from repository
      final data = [];
      emit(${className}Loaded(data));
    } catch (e) {
      emit(${className}Error(e.toString()));
    }
  }

  Future<void> _onAdd(${className}AddEvent event, Emitter<${className}State> emit) async {
    try {
      // TODO: Add data to repository
    } catch (e) {
      emit(${className}Error(e.toString()));
    }
  }

  Future<void> _onUpdate(${className}UpdateEvent event, Emitter<${className}State> emit) async {
    try {
      // TODO: Update data in repository
    } catch (e) {
      emit(${className}Error(e.toString()));
    }
  }

  Future<void> _onDelete(${className}DeleteEvent event, Emitter<${className}State> emit) async {
    try {
      // TODO: Delete data from repository
    } catch (e) {
      emit(${className}Error(e.toString()));
    }
  }
}
''';
    
    final blocFile = File(blocFilePath);
    await blocFile.writeAsString(blocContent);
  }

  String _formatFileName(String name) {
    return name.toLowerCase().replaceAll(' ', '_');
  }

  String _formatClassName(String name) {
    return name.split('_').map((word) => word.isNotEmpty 
      ? word[0].toUpperCase() + word.substring(1).toLowerCase()
      : '').join('');
  }
}