# Hive-ObjBox-DB
Hive database and Object-Box database testing CRUD with Flutter

file structure: lib
    main.dart
    /screens
        home_screen.dart
        hive_screen.dart
        hive_input_screen.dart
        obj_box_screen.dart
        obj_box_input_screen.dart
    /controllers
        hive_controller.dart
        obj_box_controller.dart
        random_data.dart
    /databases
        hive_database.dart
        obj_box_database.dart
    /models
        hive_model.dart
        obj_box_model.dart

dependencies:
    objectbox: ^2.3.1
    objectbox_flutter_libs: any
    faker: ^2.1.0
    path_provider: ^2.1.1
    hive_flutter: ^1.1.0
    hive: ^2.2.3

dev_dependencies:
    build_runner: ^2.4.6
    objectbox_generator: any
    hive_generator: any
run:    flutter pub run build_runner build