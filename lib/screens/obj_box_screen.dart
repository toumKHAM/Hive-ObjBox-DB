import 'package:flutter/material.dart';

class ObjectBoxScreen extends StatelessWidget {
  const ObjectBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Object Box Database")),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text("Object Box Database",
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
                    Navigator.pushNamed(context, "/ObjectBoxInput",arguments: {"action":"insert"});
                  }, 
                  child: const Text("Insert")
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: (){
                    Navigator.pushNamed(context, "/ObjectBoxInput",arguments: {"action":"select"});
                  }, 
                  child: const Text("select")
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: (){
                    Navigator.pushNamed(context, "/ObjectBoxInput",arguments: {"action":"update"});
                  }, 
                  child: const Text("update")
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: (){
                    Navigator.pushNamed(context, "/ObjectBoxInput",arguments: {"action":"delete"});
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