import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_objbox/controllers/obj_box_controller.dart';

class ObjBoxInputScreen extends StatefulWidget {
  const ObjBoxInputScreen({super.key});

  @override
  State<ObjBoxInputScreen> createState() => _ObjBoxInputScreenState();
}

class _ObjBoxInputScreenState extends State<ObjBoxInputScreen> {
  late final ObjBoxController _objBoxController;
  int count = 0 ;
  final _formKey = GlobalKey<FormState>();
  final _rowController = TextEditingController();
  final _repeatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _objBoxController = ObjBoxController();
    Timer.periodic( const Duration(seconds: 1), (t) {
        t.cancel();
        setState(() {
          count = _objBoxController.countOfEntries();
        });
      }
    );
    
  }

  @override
  void dispose() {
    _objBoxController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(title: const Text("ObjectBox Input")),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text("ຈຳນວນຂໍ້ມູນທັງໝົດ: $count ",
                  style: const TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: _rowController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "ກະລຸນາພິມຈຳນວນແຖວ";
                    }
                    if(value == '0'){
                      return "ຈຳນວນແຖວຕ້ອງໃຫຍ່ກວ່າ 0";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "ພິມຈຳນວນແຖວ",
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: _repeatController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "ກະລຸນາພິມຈຳນວນຮອບເຮັດຊໍ້າ";
                    }
                    if(value == '0'){
                      return "ຈຳນວນຮອບຕ້ອງໃຫຍ່ກວ່າ 0";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "ພິມຈຳນວນຮອບເຮັດຊໍ້າ",
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                    onPressed: (){
                      bool pass = _formKey.currentState!.validate(); // validate form
                      if(pass){
                        int row = int.parse(_rowController.text);
                        int repeat = int.parse(_repeatController.text);
                        if( args['action'] == "insert" ){
                          _objBoxInsert(row,repeat);
                        }else if( args['action'] == "select" ){
                          _objBoxSelect(row,repeat);
                        }
                        else if( args['action'] == "update" ){
                          _objBoxUpdate(row,repeat);
                        }
                        else if( args['action'] == "delete" ){
                          _objBoxDelete(row,repeat);
                        }
                      }
                    }, 
                    child: Text("${args['action']}")
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _objBoxInsert(int row, int repeat)async{
    await _objBoxController.insert(row: row,repeat: repeat);
    setState(() {
      count = _objBoxController.countOfEntries();
    });
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("ສຳເລັດເພີ່ມຂໍ້ມູນ ${row*repeat} ແຖວ" )));
  }

  _objBoxSelect(int row, int repeat)async{
    await _objBoxController.select(row: row,repeat: repeat);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("ສຳເລັດດຶງຂໍ້ມູນ ${row*repeat} ແຖວ" )));
  }

  _objBoxUpdate(int row, int repeat)async{
    await _objBoxController.update(row: row,repeat: repeat);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("ສຳເລັດອັບເດດຂໍ້ມູນ ${row*repeat} ແຖວ" )));
  }

  _objBoxDelete(int row, int repeat) async{
    await _objBoxController.delete(row: row,repeat: repeat);
    setState(() {
      count = _objBoxController.countOfEntries();
    });
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("ສຳເລັດລຶບຂໍ້ມູນ ${row*repeat} ແຖວ" )));
  }
}