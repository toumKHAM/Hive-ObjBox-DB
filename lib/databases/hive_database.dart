import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_objbox/models/hive_model.dart';

class HiveDatabase{
  late final Box<HiveModel> _hiveBox;

  HiveDatabase(){
    _hiveBox =  Hive.box<HiveModel>('hive_box');
  }

  // insert
  Future<int> createItem(HiveModel hiveModel) async {
    return await _hiveBox.add(hiveModel);
  }

  // select all
  Future<List<HiveModel>> selectItem() async {
    List<HiveModel> listItem = [];
    final ids = _hiveBox.keys;
    for (var id in ids) {
      var hiveModel = _hiveBox.get(id) as HiveModel;
      listItem.add(hiveModel);
    }
    return listItem;
  }

  // get 1 item
  Future<HiveModel> getItem(id) async {
    HiveModel item = _hiveBox.get(id) as HiveModel;
    return item;
  }

  // update 1 item
  Future<void> updateItem(int id, HiveModel hive) async {
     await _hiveBox.put(id, hive);
  }

  // delete 1 item
  Future<void> deleteItem(int id) async {
    await _hiveBox.delete(id);
  }

  // get all ids
  List<int> getIds(int limit){
    final keys = _hiveBox.keys;
    List<int> ids = [];
    int i=0;
    for (var key in keys) {
      ids.add(key);
      if( ++i == limit ){
        break;
      }
    }
    return ids;
  }

  // get number of entries in the box
  int length(){
    return _hiveBox.length;
  }
}