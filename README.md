# FlutterGen CLI

A powerful command-line tool for Flutter developers to quickly generate applications with customizable options for state management, architecture patterns, and package integration.

## Features

- **Application Generation**: Create new Flutter apps with customizable settings
- **Template Options**: Choose from full apps, specific components, or widget collections
- **State Management Integration**: Easily integrate GetX, Provider, Bloc, Riverpod, or MobX
- **Architecture Patterns**: Support for MVVM, Clean Architecture, MVC, and default patterns
- **Package Management**: Customize packages included in your project
- **Code Generation**: Generate boilerplate code for features and components
- **Project Analysis**: Analyze existing projects for improvements
- **Self-Updating**: Keep templates and rules up to date

## Installation

```bash
# Via pub
dart pub global activate fluttergen_cli

# Via Git
git clone https://github.com/yourusername/fluttergen_cli.git
cd fluttergen_cli
dart pub global activate --source path .
```

## Usage

### Create a new Flutter application

```bash
fluttergen create --name my_app --template full-app --state provider --pattern mvvm
```

Options:
- `--name, -n`: Name of the application (required)
- `--template, -t`: Template type (full-app, auth-flow, dashboard, e-commerce, social-media, widgets)
- `--state`: State management solution (getx, provider, bloc, riverpod, mobx)
- `--pattern`: Architecture pattern (mvvm, clean, mvc, default)
- `--flutter-version`: Flutter SDK version to use
- `--packages, -p`: Additional packages to include (comma separated)

### Generate code components

```bash
fluttergen generate --type screen --name profile --path lib/screens
```

Options:
- `--type`: Type of code to generate (screen, widget, model, service, repository, bloc)
- `--name, -n`: Name for the generated component
- `--path, -p`: Output path (default: lib)

### Analyze a Flutter project

```bash
fluttergen analyze --path ./my_flutter_project
```

Options:
- `--path, -p`: Path to the Flutter project (default: current directory)
- `--dependencies`: Check dependencies health (default: true)
- `--architecture`: Check architecture issues (default: true)
- `--performance`: Check performance issues (default: true)

### Update the CLI tool and resources

```bash
fluttergen update --all
```

Options:
- `--self`: Update the CLI tool itself
- `--templates`: Update available templates
- `--rules`: Update code generation rules
- `--all`: Update everything

## Project Structure

The FlutterGen CLI tool has the following structure:

```
fluttergen_cli/
├── bin/
│   └── fluttergen.dart          # CLI entry point
├── lib/
│   ├── analyzers/               # Project analysis tools
│   │   └── project_analyzer.dart
│   ├── commands/                # CLI commands
│   │   ├── analyze_command.dart
│   │   ├── commands.dart
│   │   ├── create_command.dart
│   │   ├── generate_command.dart
│   │   └── update_command.dart
│   ├── core/                    # Core functionality
│   │   ├── config_manager.dart
│   │   ├── update_manager.dart
│   │   └── version.dart
│   ├── generators/              # Code and project generators
│   │   ├── app_generator.dart
│   │   ├── code_generator.dart
│   │   ├── pubspec_generator.dart
│   │   ├── state_management_generator.dart
│   │   └── structure_generator.dart
│   └── models/                  # Data models
│       ├── app_config.dart
│       ├── package_info.dart
│       └── template.dart
├── pubspec.yaml
└── README.md
```

## Generated Project Structure

### MVVM Architecture

```
lib/
├── app/
│   ├── views/         # UI components and screens
│   ├── viewmodels/    # ViewModels for UI logic
│   ├── models/        # Data models and entities
│   ├── services/      # Services for data sources
│   ├── utils/         # Utility functions
│   └── widgets/       # Reusable widgets
└── main.dart
```

### Clean Architecture

```
lib/
├── domain/
│   ├── entities/      # Business objects
│   ├── repositories/  # Abstract repositories
│   └── usecases/      # Business use cases
├── data/
│   ├── models/        # Data models
│   ├── repositories/  # Repository implementations
│   └── datasources/   # Remote and local data sources
├── presentation/
│   ├── pages/         # Screens
│   ├── widgets/       # Reusable UI components
│   └── bloc/          # State management
├── core/
│   ├── utils/         # Utility functions
│   ├── errors/        # Error handling
│   └── network/       # Network related code
└── main.dart
```

### MVC Architecture

```
lib/
├── app/
│   ├── models/        # Data models
│   ├── views/         # UI components and screens
│   ├── controllers/   # Controllers for business logic
│   ├── utils/         # Utility functions
│   ├── services/      # Services for data sources
│   └── widgets/       # Reusable widgets
└── main.dart
```

## Templates

Available templates:

- **Full App Templates**:
  - E-commerce
  - Social Media
  - Dashboard

- **Partial App Templates**:
  - Authentication Flow
  - Settings Screens

- **Widget Collections**:
  - Form Elements
  - Custom UI Components

## State Management Options

- **GetX**: Complete solution with routing, dependency injection and state management
- **Provider**: Simple state management solution using InheritedWidget
- **Bloc**: Business Logic Component pattern with event-driven architecture
- **Riverpod**: Next-generation state management solution
- **MobX**: Reactive state management with observables

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.