// lib/generators/state_management_generator.dart
import 'dart:io';

import 'package:darttoolx/models/app_config.dart';
import 'package:path/path.dart' as path;

class StateManagementGenerator {
  final AppConfig config;
  final String projectPath;

  StateManagementGenerator(this.config, this.projectPath);

  Future<void> generate() async {
    switch (config.stateManagement) {
      case 'getx':
        await _setupGetX();
        break;
      case 'provider':
        await _setupProvider();
        break;
      case 'bloc':
        await _setupBloc();
        break;
      case 'riverpod':
        await _setupRiverpod();
        break;
      case 'mobx':
        await _setupMobx();
        break;
      default:
        // No specific state management setup
        break;
    }
  }

  Future<void> _setupGetX() async {
    // Create GetX folder structure
    final structures = [
      'lib/app/modules',
      'lib/app/data',
      'lib/app/routes',
      'lib/app/global_widgets',
    ];

    for (final structure in structures) {
      await Directory(path.join(projectPath, structure)).create(recursive: true);
    }

    // Create routes file
    final routesFile = File(path.join(projectPath, 'lib/app/routes/app_pages.dart'));
    await routesFile.writeAsString('''
import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
''');

    // Create routes part file
    final routesPartFile = File(path.join(projectPath, 'lib/app/routes/app_routes.dart'));
    await routesPartFile.writeAsString('''
part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
}
''');

    // Create sample module
    await Directory(path.join(projectPath, 'lib/app/modules/home/bindings')).create(recursive: true);
    await Directory(path.join(projectPath, 'lib/app/modules/home/controllers')).create(recursive: true);
    await Directory(path.join(projectPath, 'lib/app/modules/home/views')).create(recursive: true);

    // Create sample binding
    final bindingFile = File(path.join(projectPath, 'lib/app/modules/home/bindings/home_binding.dart'));
    await bindingFile.writeAsString('''
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
''');

    // Create sample controller
    final controllerFile = File(path.join(projectPath, 'lib/app/modules/home/controllers/home_controller.dart'));
    await controllerFile.writeAsString('''
import 'package:get/get.dart';
class HomeController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
''');

    // Create sample view
    final viewFile = File(path.join(projectPath, 'lib/app/modules/home/views/home_view.dart'));
    await viewFile.writeAsString('''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(() => Text(
              '\${controller.count}',
              style: TextStyle(fontSize: 20),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
''');
  }

  Future<void> _setupProvider() async {
    // Create Provider folder structure
    final structures = [
      'lib/app/providers',
      'lib/app/screens',
      'lib/app/models',
      'lib/app/widgets',
    ];

    for (final structure in structures) {
      await Directory(path.join(projectPath, structure)).create(recursive: true);
    }

    // Create sample provider
    final providerFile = File(path.join(projectPath, 'lib/app/providers/app_provider.dart'));
    await providerFile.writeAsString('''
import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}
''');

    // Create sample screen
    final screenFile = File(path.join(projectPath, 'lib/app/screens/home_screen.dart'));
    await screenFile.writeAsString('''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer<AppProvider>(
              builder: (context, provider, child) {
                return Text(
                  '\${provider.counter}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AppProvider>(context, listen: false).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
''');
  }

  Future<void> _setupBloc() async {
    // Create BLoC folder structure
    final structures = [
      'lib/app/blocs',
      'lib/app/repositories',
      'lib/app/screens',
      'lib/app/models',
      'lib/app/widgets',
    ];

    for (final structure in structures) {
      await Directory(path.join(projectPath, structure)).create(recursive: true);
    }

    // Create counter bloc
    final counterEventFile = File(path.join(projectPath, 'lib/app/blocs/counter_event.dart'));
    await counterEventFile.writeAsString('''
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}
''');

    final counterStateFile = File(path.join(projectPath, 'lib/app/blocs/counter_state.dart'));
    await counterStateFile.writeAsString('''
class CounterState {
  final int count;
  
  CounterState(this.count);
}
''');

    final counterBlocFile = File(path.join(projectPath, 'lib/app/blocs/counter_bloc.dart'));
    await counterBlocFile.writeAsString('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<IncrementEvent>((event, emit) {
      emit(CounterState(state.count + 1));
    });
  }
}
''');

    // Create sample screen
    final screenFile = File(path.join(projectPath, 'lib/app/screens/home_screen.dart'));
    await screenFile.writeAsString('''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/counter_bloc.dart';
import '../blocs/counter_event.dart';
import '../blocs/counter_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  '\${state.count}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBloc>().add(IncrementEvent());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
''');
  }

  Future<void> _setupRiverpod() async {
    // Create Riverpod folder structure
    final structures = [
      'lib/app/providers',
      'lib/app/screens',
      'lib/app/models',
      'lib/app/widgets',
    ];

    for (final structure in structures) {
      await Directory(path.join(projectPath, structure)).create(recursive: true);
    }

    // Create sample provider
    final providerFile = File(path.join(projectPath, 'lib/app/providers/counter_provider.dart'));
    await providerFile.writeAsString('''
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
}
''');

    // Create sample screen
    final screenFile = File(path.join(projectPath, 'lib/app/screens/home_screen.dart'));
    await screenFile.writeAsString('''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/counter_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '\$count',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
''');
  }

  Future<void> _setupMobx() async {
    // Create MobX folder structure
    final structures = [
      'lib/app/stores',
      'lib/app/screens',
      'lib/app/models',
      'lib/app/widgets',
    ];

    for (final structure in structures) {
      await Directory(path.join(projectPath, structure)).create(recursive: true);
    }

    // Create sample store
    final storeFile = File(path.join(projectPath, 'lib/app/stores/counter_store.dart'));
    await storeFile.writeAsString('''
import 'package:mobx/mobx.dart';

part 'counter_store.g.dart';

class CounterStore = _CounterStore with _\$CounterStore;

abstract class _CounterStore with Store {
  @observable
  int count = 0;

  @action
  void increment() {
    count++;
  }
}
''');

    // Create a placeholder for the generated file
    final genFile = File(path.join(projectPath, 'lib/app/stores/counter_store.g.dart'));
    await genFile.writeAsString('''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// This is a placeholder for the generated code
// Run 'flutter pub run build_runner build' to generate it
''');

    // Create sample screen
    final screenFile = File(path.join(projectPath, 'lib/app/screens/home_screen.dart'));
    await screenFile.writeAsString('''
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/counter_store.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final CounterStore counterStore = CounterStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) => Text(
                '\${counterStore.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterStore.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
''');
  }
}