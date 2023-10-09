import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_objbox/controllers/random_data.dart';
import 'package:hive_objbox/databases/hive_database.dart';
import 'package:hive_objbox/models/hive_model.dart';
import 'package:hive_objbox/screens/hive_input_screen.dart';
import 'package:hive_objbox/screens/hive_screen.dart';
import 'package:hive_objbox/screens/home_screen.dart';
import 'package:hive_objbox/screens/obj_box_input_screen.dart';
import 'package:hive_objbox/screens/obj_box_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  await Hive.openBox<HiveModel>("hive_box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomeScreen(),
        '/Hive' :(context) =>const HiveScreen(),
        '/HiveInput' :(context) =>const HiveInputScreen(),
        '/ObjectBox' :(context) =>const ObjectBoxScreen(),
        '/ObjectBoxInput' :(context) =>const ObjBoxInputScreen(),
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _hiveInsert, 
            child: const Text("Hive insert")
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: _hiveSelect, 
            child: const Text("Hive select")
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              _hiveGet(0);
            }, 
            child: const Text("Hive get ")
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              _hiveUpdate(0);
            }, 
            child: const Text("Hive update at")
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              _hiveDelete(2);
            }, 
            child: const Text("Hive delete at")
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              _fakerData();
            }, 
            child: const Text("Faker data")
          ),
        ],
      ),
    );
  }

  _hiveInsert()async{
    HiveDatabase hiveDatabase = HiveDatabase();
    HiveModel hiveModel = HiveModel(1, "name", "surname", "birth_date", "address", "tel");
    int result =  await hiveDatabase.createItem(hiveModel);
    print("insert OK : ${result.toString()}");
  }

  _hiveSelect() async{
    HiveDatabase hiveDatabase =  HiveDatabase();
    final List<HiveModel> datas = await hiveDatabase.selectItem();
    for (var val in datas) {
      print(val.toMap());
    }
  }

  _hiveGet(id) async{
    HiveDatabase hiveDatabase =  HiveDatabase();
    final HiveModel data = await hiveDatabase.getItem(id);
    print(data.toMap());
  }

  _hiveUpdate(id) async {
    HiveDatabase hiveDatabase = HiveDatabase();
    HiveModel hiveModel = HiveModel(1, "name", "surname", "birth_date", "address", "tel");
    await hiveDatabase.updateItem(id, hiveModel);
    print("update: $id OK");
  }

  _hiveDelete(id)async{
    HiveDatabase hiveDatabase = HiveDatabase();
    await hiveDatabase.deleteItem(id);
    print("delete: $id OK");
  }

  _fakerData(){
    RandomData r = RandomData.forHive();
    print(r.toMap());
  }
}

