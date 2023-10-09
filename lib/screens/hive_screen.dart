import 'package:flutter/material.dart';

class HiveScreen extends StatelessWidget {
  const HiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive Database")),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text("HiveDatabase",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                const SizedBox(height: 30,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: (){
                    Navigator.pushNamed(context, "/HiveInput",arguments: {"action":"insert"});
                  }, 
                  child: const Text("Insert")
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: (){
                    Navigator.pushNamed(context, "/HiveInput",arguments: {"action":"select"});
                  }, 
                  child: const Text("select")
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: (){
                    Navigator.pushNamed(context, "/HiveInput",arguments: {"action":"update"});
                  }, 
                  child: const Text("update")
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: (){
                    Navigator.pushNamed(context, "/HiveInput",arguments: {"action":"delete"});
                  }, 
                  child: const Text("delete")
                ),
                const SizedBox(height: 20,),
              ],
            )
          ),
        ],
      ),
    );
  }
}