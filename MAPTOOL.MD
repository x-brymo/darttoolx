# FlutterGen CLI Structure

Below is the complete file structure for the Flutter CLI tool:

```
fluttergen_cli/
│
├── bin/
│   └── fluttergen.dart             # CLI entry point
│
├── lib/
│   ├── analyzers/                  # Project analysis tools
│   │   └── project_analyzer.dart   # Project analysis implementation
│   │
│   ├── commands/                   # CLI commands
│   │   ├── commands.dart           # Exports all commands
│   │   ├── create_command.dart     # Command for creating new projects
│   │   ├── update_command.dart     # Command for updating CLI & templates
│   │   ├── analyze_command.dart    # Command for analyzing projects
│   │   └── generate_command.dart   # Command for generating code
│   │
│   ├── core/                       # Core functionality
│   │   ├── config_manager.dart     # Manages CLI configuration
│   │   ├── update_manager.dart     # Handles CLI & template updates
│   │   └── version.dart            # Version information
│   │
│   ├── generators/                 # Code and project generators
│   │   ├── app_generator.dart      # Main project generator
│   │   ├── structure_generator.dart # Directory structure generator
│   │   ├── state_management_generator.dart # State setup generator
│   │   ├── pubspec_generator.dart  # Pubspec.yaml generator
│   │   └── code_generator.dart     # Component code generator
│   │
│   └── models/                     # Data models
│       ├── app_config.dart         # Application configuration
│       ├── template.dart           # Template information
│       └── package_info.dart       # Package metadata
│
├── pubspec.yaml                    # Dependencies and package information
├── LICENSE                         # License information
└── README.md                       # Project documentation
```

## Implementation Details

### Commands

1. **Create Command**: Handles app creation with customizable options
   - State management integration
   - Project architecture setup
   - Template application

2. **Update Command**: Manages updates to CLI components
   - Self-update functionality
   - Template repositories update
   - Rule and configuration updates

3. **Analyze Command**: Provides project analysis tools
   - Dependency health checks
   - Architecture validation
   - Performance recommendations

4. **Generate Command**: Creates code components
   - Screens/pages generation
   - Widget creation
   - Service/repository boilerplate

### Generators

1. **App Generator**: Orchestrates the entire app generation process
   - Coordinates other generators
   - Initializes Flutter project
   - Applies template customizations

2. **Structure Generator**: Creates folder structure based on architecture pattern
   - MVVM structure generation
   - Clean Architecture setup
   - MVC pattern implementation

3. **State Management Generator**: Sets up the chosen state management solution
   - GetX setup
   - Provider integration
   - Bloc pattern implementation
   - Riverpod configuration
   - MobX setup

4. **Pubspec Generator**: Creates pubspec.yaml with appropriate dependencies
   - Adds state management packages
   - Includes template-required dependencies
   - Sets up dev dependencies

### Models

1. **App Config**: Stores project generation configuration
   - Name, template, state management choice
   - Architecture pattern selection
   - Flutter version specification
   - Package selection

2. **Template**: Defines template properties and compatibility
   - Template metadata
   - Compatible state management solutions
   - Compatible architecture patterns

3. **Package Info**: Contains package metadata
   - Version information
   - Dependencies
   - Category classification

### Core Components

1. **Config Manager**: Handles CLI configuration
   - Configuration storage
   - Default settings
   - User preferences

2. **Update Manager**: Manages update processes
   - Version checking
   - Download and installation
   - Repository management

## Extension Points

The CLI is designed to be extensible in the following ways:

1. **New Commands**: Additional commands can be added to the CommandRunner
2. **New Templates**: Templates can be added to the template repository
3. **New State Management**: Support for additional state management solutions
4. **New Architecture Patterns**: Additional architecture patterns can be implemented
5. **Custom Generators**: Specialized code generators can be added

## Configuration Files

The CLI stores configuration in the user's home directory:

```
~/.fluttergen/
├── config.json           # CLI configuration
├── templates/            # Template storage
│   ├── full-app/
│   ├── auth-flow/
│   └── widgets/
└── cache/                # Package cache
```